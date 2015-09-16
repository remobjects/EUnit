namespace RemObjects.Elements.EUnit;

interface

uses
  Sugar,
  Sugar.Collections;

type
  TestResultNode = assembly class (ITestResult)
  private
    List: List<ITestResult> := new List<ITestResult>;
  public
    constructor(aTest: ITest);
    constructor(aTest: ITest; aState: TestState; aMessage: String);

    method &Add(Item: ITestResult);
    method SetResult(aState: TestState; aMessage: String);

    method {$IF NOUGAT}description: Foundation.NSString{$ELSEIF COOPER}ToString: java.lang.String{$ELSEIF ECHOES}ToString: System.String{$ENDIF}; override;

    class method HandleException(Test: ITest; Ex: Exception): TestResultNode;

    property Id: String read Test.Id;
    property Name: String read Test.Name;
    property DisplayName: String read write;
    property State: TestState read private write;
    property Message: String read private write;
    property Test: ITest read write; readonly;
    property Children: sequence of ITestResult read List.ToArray;
  end;

implementation

constructor TestResultNode(aTest: ITest; aState: TestState; aMessage: String);
begin
  ArgumentNilException.RaiseIfNil(aTest, "Test");

  self.Test := aTest;
  State := aState;
  DisplayName := aTest.Name;

  if aMessage = nil then
    aMessage := "";

  Message := aMessage;
end;

method TestResultNode.Add(Item: ITestResult);
begin
  List.Add(Item);
end;

constructor TestResultNode(aTest: ITest);
begin
  constructor(aTest, TestState.Untested, "");
end;

method TestResultNode.SetResult(aState: TestState; aMessage: String);
begin
  if aMessage = nil then
    aMessage := "";

  State := aState;
  Message := aMessage;
end;

class method TestResultNode.HandleException(Test: ITest; Ex: Exception): TestResultNode;
begin
  ArgumentNilException.RaiseIfNil(Test, "Test");

  exit new TestResultNode(Test, TestState.Failed, if Ex = nil then "Unknown error" else Ex.{$IF NOUGAT}description{$ELSE}Message{$ENDIF});
end;

method TestResultNode.{$IF NOUGAT}description: Foundation.NSString{$ELSEIF COOPER}ToString: java.lang.String{$ELSEIF ECHOES}ToString: System.String{$ENDIF};
begin
  exit String.Format("[{0}] {1} Kind: {2} Message: {3}", Id, Name, case State of
      TestState.Failed: "Failed";
      TestState.Skipped: "Skipped";
      TestState.Succeeded: "Succeeded";
      TestState.Untested: "Untested";
    end, Message);
end;

end.