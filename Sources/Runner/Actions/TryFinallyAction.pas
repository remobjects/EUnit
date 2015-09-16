namespace RemObjects.Elements.EUnit;

interface

type
  TryFinallyAction = assembly class (BaseAction)
  private
    fTry: BaseAction;
    fBlock: BaseAction;
    fFinally: BaseAction;
  protected
    method DoExecute(Context: RunContext); override;
  public
    constructor(&Try, &Block, &Finally: BaseAction);
  end;

implementation

constructor TryFinallyAction(&Try: BaseAction; &Block: BaseAction; &Finally: BaseAction);
begin
  ArgumentNilException.RaiseIfNil(&Try, "Try");
  ArgumentNilException.RaiseIfNil(&Block, "Block");
  ArgumentNilException.RaiseIfNil(&Finally, "Finally");
  
  inherited constructor(false);
  fTry := &Try;
  fBlock := &Block;
  fFinally := &Finally;
end;

method TryFinallyAction.DoExecute(Context: RunContext);
begin
  fTry.Execute(Context);

  if Context.CurrentResult:State = TestState.Failed then
    exit;
  try
    fBlock.Execute(Context);
  finally
    fFinally.Execute(Context);
  end;
end;

end.
