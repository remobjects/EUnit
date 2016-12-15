namespace RemObjects.Elements.EUnit;

interface

type
  ITestResult = public interface
    property Id: String read;
    property Name: String read;
    property DisplayName: String read write;
    property State: TestState read;
    property Message: String read;
    property ParsableMessage: String read;
    property Test: ITest read;
    property Children: sequence of ITestResult read;
  end;
  
implementation
end.