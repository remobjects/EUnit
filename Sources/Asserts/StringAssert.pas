namespace RemObjects.Elements.EUnit;

interface

uses
  Sugar;

type
  Assert = public partial static class {$IF NOUGAT}mapped to Object{$ENDIF}
  public
    method AreEqual(Actual, Expected : String; IgnoreCase: Boolean := false; Message: String := nil);
    method AreNotEqual(Actual, Expected: String; IgnoreCase: Boolean := false; Message: String := nil);    
    method Contains(SubString, InString: String; Message: String := nil);
    method DoesNotContains(SubString, InString: String; Message: String := nil);

    method StartsWith(Prefix, SourceString: String; Message: String := nil);
    method EndsWith(Suffix, SourceString: String; Message: String := nil);

    method IsEmpty(Actual: String; Message: String := nil);
    method IsNotEmpty(Actual: String; Message: String := nil);
  end;

implementation

class method Assert.AreEqual(Actual: String; Expected: String; IgnoreCase: Boolean := false; Message: String := nil);
begin
  if (Expected = nil) and (Actual = nil) then
    exit;

  if (Expected = nil) and (Actual <> nil) then
    Fail(Actual, Expected, coalesce(Message, AssertMessages.NotEqual));

  if IgnoreCase then
    FailIfNot(Expected.EqualsIgnoreCase(Actual), Actual, Expected, coalesce(Message, AssertMessages.NotEqual))
  else
    FailIfNot(Expected.Equals(Actual), Actual, Expected, coalesce(Message, AssertMessages.NotEqual));
end;

class method Assert.AreNotEqual(Actual: String; Expected: String; IgnoreCase: Boolean := false; Message: String := nil);
begin
  if (Expected = nil) and (Actual = nil) then
    Fail(Actual, Expected, coalesce(Message, AssertMessages.Equal));

  if (Expected = nil) and (Actual <> nil) then
    exit;

  if IgnoreCase then
    FailIf(Expected.EqualsIgnoreCase(Actual), Actual, Expected, coalesce(Message, AssertMessages.Equal))
  else
    FailIf(Expected.Equals(Actual), Actual, Expected, coalesce(Message, AssertMessages.Equal));
end;

class method Assert.Contains(SubString: String; InString: String; Message: String := nil);
begin
  ArgumentNilException.RaiseIfNil(InString, "InString");
  ArgumentNilException.RaiseIfNil(SubString, "SubString");

  FailIfNot(InString.Contains(SubString), SubString, "String", coalesce(Message, AssertMessages.DoesNotContains));
end;

class method Assert.DoesNotContains(SubString: String; InString: String; Message: String := nil);
begin
  ArgumentNilException.RaiseIfNil(InString, "InString");
  ArgumentNilException.RaiseIfNil(SubString, "SubString");

  FailIf(InString.Contains(SubString), SubString, "String", coalesce(Message, AssertMessages.UnexpectedContains));
end;

class method Assert.StartsWith(Prefix: String; SourceString: String; Message: String := nil);
begin
  ArgumentNilException.RaiseIfNil(Prefix, "Prefix"); 
  ArgumentNilException.RaiseIfNil(SourceString, "SourceString"); 

  FailIfNot(SourceString.StartsWith(Prefix), Prefix, SourceString, coalesce(Message, AssertMessages.StringPrefixMissing));
end;

class method Assert.EndsWith(Suffix: String; SourceString: String; Message: String := nil);
begin
  ArgumentNilException.RaiseIfNil(Suffix, "Suffix"); 
  ArgumentNilException.RaiseIfNil(SourceString, "SourceString"); 

  FailIfNot(SourceString.EndsWith(Suffix), Suffix, SourceString, coalesce(Message, AssertMessages.StringSufixMissing));
end;

class method Assert.IsEmpty(Actual: String; Message: String := nil);
begin
  ArgumentNilException.RaiseIfNil(Actual, "Actual");
  FailIfNot(Actual.Length = 0, Actual, "String", coalesce(Message, AssertMessages.IsNotEmpty));
end;

class method Assert.IsNotEmpty(Actual: String; Message: String := nil);
begin
  ArgumentNilException.RaiseIfNil(Actual, "Actual");
  FailIfNot(Actual.Length <> 0, Actual, "String", coalesce(Message, AssertMessages.IsEmpty));
end;

end.