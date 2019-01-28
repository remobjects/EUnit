namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections;

type
  BaseAsserts = public partial abstract class
  private
    method TypeToString(aType: NativeType): String;
  public
    method Throws(Action: AssertAction; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method Throws(Action: AssertAction; OfType: NativeType; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method DoesNotThrows(Action: AssertAction; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());

    method Catch(Action: AssertAction; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()): Exception;
  end;

implementation

method BaseAsserts.TypeToString(aType: NativeType): String;
begin
  if aType = nil then
    exit nil;

  exit new TypeReference(aType).Name;
end;

method BaseAsserts.Throws(Action: AssertAction; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  var Ex := ExceptionHelper.CatchException(Action);

  FailIf(Ex = nil, coalesce(Message, AssertMessages.NoException), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.Throws(Action: AssertAction; OfType: NativeType; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  var Ex := ExceptionHelper.CatchException(Action);

  FailIf(Ex = nil, coalesce(Message, AssertMessages.NoException), aFile, aLine, aClass, aMethod);
  FailComparisonIfNot(typeOf(Ex) = OfType, TypeToString(typeOf(Ex)), TypeToString(OfType), coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.DoesNotThrows(Action: AssertAction; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  var Ex := ExceptionHelper.CatchException(Action);

  FailComparisonIf(Ex <> nil, TypeToString(typeOf(Ex)), nil, coalesce(Message, AssertMessages.UnexpectedException), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.Catch(Action: AssertAction; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()): Exception;
begin
  var Ex := ExceptionHelper.CatchException(Action);
  FailIf(Ex = nil, coalesce(Message, AssertMessages.NoException), aFile, aLine, aClass, aMethod);
  exit Ex;
end;

end.