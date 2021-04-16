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
  inherited constructor(ctx -> begin
    ArgumentNilException.RaiseIfNil(ctx.Method, "Method");
    ArgumentNilException.RaiseIfNil(ctx.Instance, "Instance");

    ctx.HadFailedChecks := false;
    ctx.Method.Invoke(ctx.Instance);
    if ctx.HadFailedChecks or TestNode(ctx.Test):IntermediateTestResults:Any(t -> t.State ≠ TestState.Succeeded) then
      result := new TestResultNode(ctx.Test, TestState.Succeeded, nil, "TEST-FAILED,,,"+ctx.Test.Name+",Test Failed some checks.")
    else
      result := new TestResultNode(ctx.Test, TestState.Succeeded, nil, "TEST-SUCCEEDED,,,"+ctx.Test.Name+",Test Succeeded.");
  end);
end;

end.