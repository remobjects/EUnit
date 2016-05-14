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

                          ctx.Method.Invoke(ctx.Instance);
                          exit new TestResultNode(ctx.Test, TestState.Succeeded, nil, nil);
                       end);
end;

end.