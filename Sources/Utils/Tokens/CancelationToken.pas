namespace RemObjects.Elements.EUnit;

interface

type
  CancelationToken = assembly class (ICancelationToken)
  private
    fCanceled: Boolean;
  public
    constructor;

    method Cancel;
    property Canceled: Boolean read fCanceled;
  end;

implementation

constructor CancelationToken;
begin
  fCanceled := false;
end;

method CancelationToken.Cancel;
begin
  if fCanceled then
    raise new InvalidOperationException("Operation already canceled.");

  locking self do
    fCanceled := true;
end;

end.