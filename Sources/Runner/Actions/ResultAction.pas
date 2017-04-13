namespace RemObjects.Elements.EUnit;

interface

type
  Func<T> = public block (Obj: T): ITestResult;

  ResultAction = assembly class (BaseAction)
  private
    fAction: Func<RunContext>;
  protected
    method DoExecute(Context: RunContext); override;
  public
    constructor(Action: Func<RunContext>);
    constructor(Action: Func<RunContext>; RunAlways: Boolean);
  end;

implementation

method ResultAction.DoExecute(Context: RunContext);
begin
  try
    Context.CurrentResult := fAction(Context);
  except
    on E: Exception do
      Context.CurrentResult := HandleException(Context, E);
  end;
end;

constructor ResultAction(Action: Func<RunContext>);
begin
  constructor(Action, false);
end;

constructor ResultAction(Action: Func<RunContext>; RunAlways: Boolean);
begin
  inherited constructor(RunAlways);
  ArgumentNilException.RaiseIfNil(Action, "Action");
  fAction := Action;
end;

end.