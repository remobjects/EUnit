namespace RemObjects.Elements.EUnit;

interface

type
  TeardownTestAction = assembly class (InstanceAction)
  protected
    method DoExecute(Context: RunContext); override;
  end;

implementation

method TeardownTestAction.DoExecute(Context: RunContext);
begin
  inherited DoExecute(Context);

  try
    Context.Instance.TeardownTest;
  except
    on E: Exception do begin
      var Current := Context.CurrentResult;
      var Node := new TestResultNode(Context.Test, TestState.Failed, "[Failed to finalize test] " + HandleException(Context, E).Message);
      
      if Current <> nil then
        for child in Current.Children do
          Node.Add(child);

      Context.CurrentResult := Node;
    end;
  end;
end;

end.