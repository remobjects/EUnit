namespace RemObjects.Elements.EUnit;

interface

type
  MethodAction = assembly class (ResultAction)
  public
    constructor;
  end;

implementation

constructor MethodAction;
begin
  inherited constructor(aContext -> begin
    ArgumentNilException.RaiseIfNil(aContext.Method, "Method");
    ArgumentNilException.RaiseIfNil(aContext.Instance, "Instance");

    aContext.HadFailedChecks := false;
    aContext.Method.Invoke(aContext.Instance);
    if aContext.HadFailedChecks or TestNode(aContext.Test):IntermediateTestResults:Any(t -> t.State ≠ TestState.Succeeded) then
      result := new TestResultNode(aContext.Test, TestState.Failed, nil, "TEST-FAILED,,,"+aContext.Test.Name+",Test Failed some checks.")
    else
      result := new TestResultNode(aContext.Test, TestState.Succeeded, nil, "TEST-SUCCEEDED,,,"+aContext.Test.Name+",Test Succeeded.");
  end);
end;

end.