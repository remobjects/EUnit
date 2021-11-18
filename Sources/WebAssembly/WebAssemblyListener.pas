namespace RemObjects.Elements.EUnit;

uses
  RemObjects.Elements.WebAssembly.DOM;

type
  WebAssemblyListener = public class(IEventListener, IEventListenerGUI)
  public

    constructor(aLogElement: HTMLDivElement);
    begin
      ConsoleTestListener.EmitParseableMessages := true;
      fLogElement := aLogElement;
    end;

    { IEventListener }

    method RunStarted(Test: ITest); virtual;
    begin
      //TableViewTestListenerAppDelegate.TableViewController:title := 'EUnit — Running Rests';
    end;

    method TestStarted(aTest: ITest); virtual;
    begin
      var lCurrentTestDiv := Browser.CreateElement("div") as HTMLDivElement;
      lCurrentTestDiv.innerHTML := $"{aTest.Name} is running...";
      lCurrentTestDiv.className := "running";
      fLogElement.appendChild(lCurrentTestDiv);
      fTests.Push(new TestInfo(Test := aTest, &Div := lCurrentTestDiv));
    end;

    method TestFinished(aTestResult: ITestResult); virtual;
    begin
      var lTestInfo := fTests.Pop();
      lTestInfo.Div.innerHTML := $"{lTestInfo.Test.Name}";
      lTestInfo.Div.className := case aTestResult.State of
        TestState.Untested: "untested";
        TestState.Skipped: "skipped";
        TestState.Failed: "failed";
        TestState.Succeeded: "succeeded";
      end;
      if (TestResult.State ≠ TestState.Succeeded) or ConsoleTestListener.EmitParseableSuccessMessages then
        writeLn(TestResult.ParsableMessage);
    end;

    method RunFinished(TestResult: ITestResult); virtual;
    begin
    end;

    { IEventListenerGUI }

    method PrepareGUI;
    begin
    end;

    method RunGUI;
    begin
    end;

    method FinishGUI;
    begin
    end;

  private

    var fLogElement: HTMLDivElement;
    var fTests := new Stack<TestInfo>;

  end;

  TestInfo = unit class
    property Test: ITest;
    property &Div: HTMLDivElement;
  end;

end.