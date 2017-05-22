namespace RemObjects.Elements.EUnit;

interface

type
  {$IF ISLAND}[Used(Inherit := true)]{$ENDIF}
  Test = public class
  public
    method SetupTest; virtual; empty;
    method TeardownTest; virtual; empty;
    method Setup; virtual; empty;
    method Teardown; virtual; empty;
  end;

implementation
end.