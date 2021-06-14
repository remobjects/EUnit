namespace RemObjects.Elements.EUnit;

uses
  RemObjects.Elements.WebAssembly.DOM;

type
  WebAssemblyListener = public class(IEventListener, IEventListenerGUI)
  public

    constructor(aLogElement: HTMLDivElement);
    begin
      fLogElement := aLogElement;
    end;

    { IEventListener }

    method RunStarted(Test: ITest); virtual;
    begin
      //TableViewTestListenerAppDelegate.TableViewController:title := 'EUnit — Running Rests';
    end;

    method TestStarted(aTest: ITest); virtual;
    begin
      fCurrentTestDiv := Browser.CreateElement("div") as HTMLDivElement;
      fCurrentTestDiv.innerHTML := $"Running {aTest.Name}";
      fCurrentTestDiv.className := "running";
      //fCurrentTest := aTest;
      fLogElement.appendChild(fCurrentTestDiv);
    end;

    method TestFinished(aTestResult: ITestResult); virtual;
    begin
      fCurrentTestDiv.className := case aTestResult.State of
        TestState.Untested: "untested";
        TestState.Skipped: "skipped";
        TestState.Failed: "untested";
        TestState.Succeeded: "succeeded";
      end;
      fCurrentTestDiv := nil;
      //fCurrentTest := nil;
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
    var fCurrentTestDiv: HTMLDivElement;
    //var fCurrentTest: ITest;

  end;

end.