namespace RemObjects.Elements.EUnit;

interface


type
  SetupAction = assembly class (InstanceAction)
  protected
    method DoExecute(Context: RunContext); override;
  end;

implementation

method SetupAction.DoExecute(Context: RunContext);
begin
  inherited DoExecute(Context);
  Context.Instance.Setup;
end;

end.