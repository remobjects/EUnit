namespace RemObjects.Elements.EUnit;

interface

type
  IEventListener = public interface
    method RunStarted(Test: ITest);
    method TestStarted(Test: ITest);
    method TestFinished(TestResult: ITestResult);
    method RunFinished(TestResult: ITestResult);
  end;

  IEventListenerGUI = public interface
    method PrepareGUI;
    method RunGUI;
    method FinishGUI;
  end;

implementation
end.