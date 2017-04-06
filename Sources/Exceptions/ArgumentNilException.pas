namespace RemObjects.Elements.EUnit;

interface

type
  ArgumentNilException = public class (ArgumentException)
  public
    constructor (anArgument: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    class method RaiseIfNil(Obj: Object; Name: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
  end;

implementation

constructor ArgumentNilException(anArgument: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  var lMessage := String.Format('Argument "{0}" can not be nil', anArgument);
  inherited constructor(anArgument, lMessage, aFile, aLine, aClass, aMethod);
end;

class method ArgumentNilException.RaiseIfNil(Obj: Object; Name: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  if Obj = nil then begin
    raise new ArgumentNilException(Name, aFile, aLine, aClass, aMethod);
  end;
end;

end.