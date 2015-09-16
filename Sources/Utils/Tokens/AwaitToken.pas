namespace RemObjects.Elements.EUnit;

interface

type
  AwaitToken = assembly class (IAwaitToken)
  private
    fLock: ExceptionLock; readonly;
  public   
    constructor;

    method Run(Action: AssertAction);
    method WaitFor;
  end;

implementation

method AwaitToken.Run(Action: AssertAction);
begin
  try
    Action();
    fLock.Signal;
  except
    on E: Exception do
      fLock.Signal(E);
  end;
end;

constructor AwaitToken;
begin
  fLock := new ExceptionLock;
end;

method AwaitToken.WaitFor;
begin
  fLock.WaitFor;
end;

end.