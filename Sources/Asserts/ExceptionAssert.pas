namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections;

type 
  Assert = public partial static class {$IF NOUGAT}mapped to Object{$ENDIF}
  private
    method TypeToString(aType: NativeType): String;
  public
    method Throws(Action: AssertAction; Message: String := nil);
    method Throws(Action: AssertAction; OfType: NativeType; Message: String := nil);
    method DoesNotThrows(Action: AssertAction; Message: String := nil);

    method Catch(Action: AssertAction; Message: String := nil): Exception;
  end;

implementation

class method Assert.TypeToString(aType: NativeType): String;
begin
  if aType = nil then
    exit nil;

  exit new TypeReference(aType).Name;
end;

class method Assert.Throws(Action: AssertAction; Message: String := nil);
begin
  var Ex := ExceptionHelper.CatchException(Action);

  FailIf(Ex = nil, coalesce(Message, AssertMessages.NoException));
end;

class method Assert.Throws(Action: AssertAction; OfType: NativeType; Message: String := nil);
begin
  var Ex := ExceptionHelper.CatchException(Action);

  FailIf(Ex = nil, coalesce(Message, AssertMessages.NoException));
  FailIfNot(typeOf(Ex) = OfType, TypeToString(typeOf(Ex)), TypeToString(OfType), coalesce(Message, AssertMessages.NotEqual));
end;

class method Assert.DoesNotThrows(Action: AssertAction; Message: String := nil);
begin
  var Ex := ExceptionHelper.CatchException(Action);

  FailIf(Ex <> nil, TypeToString(typeOf(Ex)), nil, coalesce(Message, AssertMessages.UnexpectedException));
end;

class method Assert.Catch(Action: AssertAction; Message: String := nil): Exception;
begin
  var Ex := ExceptionHelper.CatchException(Action);
  FailIf(Ex = nil, coalesce(Message, AssertMessages.NoException));
  exit Ex;
end;

end.