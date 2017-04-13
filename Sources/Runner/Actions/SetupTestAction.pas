namespace RemObjects.Elements.EUnit;

interface

type
  SetupTestAction = assembly class (InstanceAction)
  protected
    method DoExecute(Context: RunContext); override;
  end;

implementation

method SetupTestAction.DoExecute(Context: RunContext);
begin
  inherited DoExecute(Context);

  if Context.CurrentResult:State = TestState.Failed then
    exit;

  try
    Context.Instance.SetupTest;
  except
    on Ex: Exception do begin
      var Node := new TestResultNode(Context.Test, TestState.Failed, "[Failed to setup test] " + HandleException(Context, Ex).Message, BaseException(Ex):ParsableMessage);
      for child in Context.Test.Children do
        Node.Add(ForEach(child, item -> new TestResultNode(item, TestState.Untested, "Failed to setup test.", BaseException(Ex):ParsableMessage)));

      Context.CurrentResult := Node;
    end;
  end;
end;

end.