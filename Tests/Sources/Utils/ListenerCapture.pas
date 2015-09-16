namespace EUnit.Tests;

interface

uses
  RemObjects.Elements.EUnit;

type
  ListenerCapture = public class (IEventListener) 
  private
    CapturedTests: Sugar.Collections.List<ITest> := new Sugar.Collections.List<ITest>;
    CapturedResults: Sugar.Collections.List<ITestResult> := new Sugar.Collections.List<ITestResult>;

    method TestStarted(Test: ITest);
    method TestFinished(TestResult: ITestResult);
    method RunStarted(Test: ITest);
    method RunFinished(TestResult: ITestResult);
  public
    method Reset;

    property Tests: Sugar.Collections.List<ITest> read CapturedTests;
    property Results: Sugar.Collections.List<ITestResult> read CapturedResults;
  end;

implementation

method ListenerCapture.TestStarted(Test: ITest);
begin
  CapturedTests.Add(Test);
end;

method ListenerCapture.TestFinished(TestResult: ITestResult);
begin
  CapturedResults.Add(TestResult);
end;

method ListenerCapture.Reset;
begin
  CapturedTests.Clear;
  CapturedResults.Clear;
end;

method ListenerCapture.RunStarted(Test: ITest);
begin
  //CapturedTests.Add(Test);
end;

method ListenerCapture.RunFinished(TestResult: ITestResult);
begin
  //CapturedResults.Add(TestResult);
end;

end.
