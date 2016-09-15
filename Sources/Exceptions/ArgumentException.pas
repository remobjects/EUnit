namespace RemObjects.Elements.EUnit;

interface

uses
  Sugar;

type
  ArgumentException = public class (BaseException)
  public
    constructor (anArgument: String; Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    property Argument: String read write; readonly;
  end;

implementation

constructor ArgumentException(anArgument: String; Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  inherited constructor(Message);
  Argument := anArgument;
end;

end.