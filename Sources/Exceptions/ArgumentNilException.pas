namespace RemObjects.Elements.EUnit;

interface

type
  ArgumentNilException = public class (ArgumentException)
  public
    constructor (anArgument: String);
    class method RaiseIfNil(Obj: Object; Name: String);    
  end;

implementation

constructor ArgumentNilException(anArgument: String);
begin
  inherited constructor(anArgument, "Argument '"+anArgument+"' can not be nil");
end;

class method ArgumentNilException.RaiseIfNil(Obj: Object; Name: String);
begin
  if Obj = nil then
    raise new ArgumentNilException(Name);
end;

end.