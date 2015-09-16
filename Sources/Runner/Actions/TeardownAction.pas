namespace RemObjects.Elements.EUnit;

interface

type
  TeardownAction = assembly class (InstanceAction)
  protected
    method DoExecute(Context: RunContext); override;
  end;

implementation

method TeardownAction.DoExecute(Context: RunContext);
begin
  inherited DoExecute(Context);
  Context.Instance.Teardown;
end;

end.