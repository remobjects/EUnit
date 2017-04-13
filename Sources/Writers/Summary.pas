namespace RemObjects.Elements.EUnit;

interface

type
  Summary = assembly class
  private
    method Update(Item: ITestResult; Filter: Predicate<ITestResult>);
  public
    constructor(Items: ITestResult; Filter: Predicate<ITestResult>);

    property Failed: Integer read private write;
    property Succeeded: Integer read private write;
    property Skipped: Integer read private write;
    property Untested: Integer read private write;

    property TestCount: Integer read private write;
    property SuiteCount: Integer read private write;
    property TestcaseCount: Integer read private write;
  end;

implementation

method Summary.Update(Item: ITestResult; Filter: Predicate<ITestResult>);
begin
  if Item = nil then
    exit;
  case Item.Test.Kind of
    TestKind.Suite: self.SuiteCount := self.SuiteCount + 1;
    TestKind.Test: self.TestCount := self.TestCount + 1;
    TestKind.Testcase: self.TestcaseCount := self.TestcaseCount + 1;
  end;

  if (Filter = nil) or ((Filter <> nil) and Filter(Item)) then
    case Item.State of
      TestState.Untested: self.Untested := self.Untested + 1;
      TestState.Skipped: self.Skipped := self.Skipped + 1;
      TestState.Failed: self.Failed := self.Failed + 1;
      TestState.Succeeded: self.Succeeded := self.Succeeded + 1;
    end;

  for child in Item.Children do
    Update(child, Filter);
end;

constructor Summary(Items: ITestResult; Filter: Predicate<ITestResult>);
begin
  ArgumentNilException.RaiseIfNil(Items, "Items");
  Update(Items, Filter);
end;

end.