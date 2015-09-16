namespace RemObjects.Elements.EUnit;

interface

type
  TokenProvider = public static class
  public
    method CreateAwaitToken: IAwaitToken;
    method CreateCancelationToken: ICancelationToken;
  end;

implementation

method TokenProvider.CreateAwaitToken: IAwaitToken;
begin
  exit new AwaitToken();
end;

method TokenProvider.CreateCancelationToken: ICancelationToken;
begin
  exit new CancelationToken();
end;

end.