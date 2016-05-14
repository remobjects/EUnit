namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections;

type 
  Assert = public partial static class {$IF NOUGAT}mapped to Object{$ENDIF}
  private
    method TypeToString(aType: NativeType): String;
  public
    method Throws(Action: AssertAction; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method Throws(Action: AssertAction; OfType: NativeType; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method DoesNotThrows(Action: AssertAction; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());

    method Catch(Action: AssertAction; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()): Exception;
  end;

implementation

method Assert.TypeToString(aType: NativeType): String;
begin
  if aType = nil then
    exit nil;

  exit new TypeReference(aType).Name;
end;

method Assert.Throws(Action: AssertAction; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  var Ex := ExceptionHelper.CatchException(Action);

  FailIf(Ex = nil, coalesce(Message, AssertMessages.NoException), aFile, aLine, aClass, aMethod);
end;

method Assert.Throws(Action: AssertAction; OfType: NativeType; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  var Ex := ExceptionHelper.CatchException(Action);

  FailIf(Ex = nil, coalesce(Message, AssertMessages.NoException), aFile, aLine, aClass, aMethod);
  FailComparisonIfNot(typeOf(Ex) = OfType, TypeToString(typeOf(Ex)), TypeToString(OfType), coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

method Assert.DoesNotThrows(Action: AssertAction; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  var Ex := ExceptionHelper.CatchException(Action);

  FailComparisonIf(Ex <> nil, TypeToString(typeOf(Ex)), nil, coalesce(Message, AssertMessages.UnexpectedException), aFile, aLine, aClass, aMethod);
end;

method Assert.Catch(Action: AssertAction; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()): Exception;
begin
  var Ex := ExceptionHelper.CatchException(Action);
  FailIf(Ex = nil, coalesce(Message, AssertMessages.NoException), aFile, aLine, aClass, aMethod);
  exit Ex;
end;

end.