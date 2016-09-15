namespace RemObjects.Elements.EUnit;

interface

type
  TestProcessAction = assembly block (Item: ITest): ITestResult;

  InstanceAction = assembly class (BaseAction)
  protected
    method DoExecute(Context: RunContext); override;
    method ForEach(Item: ITest; Action: TestProcessAction): ITestResult;
  end;

implementation

method InstanceAction.DoExecute(Context: RunContext);
begin
  if Context.Instance = nil then begin
    Context.CurrentResult := new TestResultNode(Context.Test, TestState.Failed, "Instance is missing. Unable to perform action.", nil);
    exit;
  end;
end;

method InstanceAction.ForEach(Item: ITest; Action: TestProcessAction): ITestResult;
begin
  if (Item = nil) or (Action = nil) then
    exit nil;

  var Node := TestResultNode(Action(Item));

  for child in  Item.Children do begin
    var ChildNode := ForEach(Item, Action);
    if ChildNode <> nil then
      Node.Add(ChildNode);
  end;

  exit Node;
end;

end.