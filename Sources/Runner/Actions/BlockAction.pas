namespace RemObjects.Elements.EUnit;

interface

type
  BlockAction = assembly class (BaseAction)
  private
    fAction: Action<RunContext>;
  protected
    method DoExecute(Context: RunContext); override;
  public
    constructor(Action: Action<RunContext>);    
    constructor(Action: Action<RunContext>; RunAlways: Boolean);
  end;

implementation

method BlockAction.DoExecute(Context: RunContext);
begin
  try
    fAction(Context);
  except
    on E: Exception do
      Context.CurrentResult := HandleException(Context, E);
  end;
end;

constructor BlockAction(Action: Action<RunContext>);
begin
  constructor(Action, true);
end;

constructor BlockAction(Action: Action<RunContext>; RunAlways: Boolean);
begin
  inherited constructor(RunAlways);
  ArgumentNilException.RaiseIfNil(Action, "Action");
  fAction := Action;
end;

end.