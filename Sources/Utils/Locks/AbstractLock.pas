namespace RemObjects.Elements.EUnit;

interface

type
  AbstractLock = public abstract class
  public
    method Signal; virtual; abstract;
    method Reset; virtual; abstract;
    method WaitFor; virtual; abstract;
    method WaitFor(Timeout: Integer): Boolean; virtual; abstract;
  end;

implementation
end.