namespace RemObjects.Elements.EUnit;

interface

type
  ArgumentException = public class (BaseException)
  public
    constructor (anArgument: String; Message: String);
    property Argument: String read write; readonly;
  end;

implementation

constructor ArgumentException(anArgument: String; Message: String);
begin
  inherited constructor(Message);
  Argument := anArgument;
end;

end.