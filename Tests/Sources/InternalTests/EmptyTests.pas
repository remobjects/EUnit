namespace EUnit.Tests;

interface

uses
  RemObjects.Elements.EUnit;

type
  _EmptyTest = public class (Test)
  private
    method Private1; empty;
    method Private2: Boolean; empty;
    method Private3(Parameter: Boolean); empty;
    method Private4(Parameter: Boolean): Boolean; empty;
  protected
    //method Protected1; empty;
    method Protected2: Boolean; empty;
    method Protected3(Parameter: Boolean); empty;
    method Protected4(Parameter: Boolean): Boolean; empty;
  public
    method Public1; virtual; empty;
    method Public2: Boolean; empty;
    method Public3(Parameter: Boolean); empty;
    method Public4(Parameter: Boolean): Boolean; empty;
    method Public5; empty;
  end;

  _SecondEmptyTest = public class (_EmptyTest)
  public
    method Public1; override; empty;
    method Public6; empty;
  end;

  _AbstractBaseTest = public abstract class (Test)
  public
    method AbstractMethod; virtual; abstract;
  end;

  _NonAbstractTest = public class (_AbstractBaseTest)
  public
    method AbstractMethod; override; empty;
  end;

implementation
end.