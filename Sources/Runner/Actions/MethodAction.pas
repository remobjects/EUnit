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
    var lFaildIntermediateTestResults := TestNode(aContext.Test):IntermediateTestResults:&Where(t -> t.State ≠ TestState.Succeeded).ToList;;
    if aContext.HadFailedChecks or (lFaildIntermediateTestResults:Count > 0) then begin
      result := new TestResultNode(aContext.Test, TestState.Failed, "Test Failed some checks", "TEST-FAILED,,,"+aContext.Test.Name+",Test Failed some checks.");
      if lFaildIntermediateTestResults:Count > 0 then
        TestResultNode(result).AddChildMessages(lFaildIntermediateTestResults.Select(i -> i.Message));
    end
    else begin
      result := new TestResultNode(aContext.Test, TestState.Succeeded, nil, "TEST-SUCCEEDED,,,"+aContext.Test.Name+",Test Succeeded.");
    end;
  end);
end;

end.