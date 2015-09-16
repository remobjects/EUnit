namespace RemObjects.Elements.EUnit;

interface

uses
  Sugar;

type
  Assert = public partial static class {$IF NOUGAT}mapped to Object{$ENDIF}
  public
    method AreEqual(Actual, Expected : Object; Message: String := nil);
    method AreNotEqual(Actual, Expected: Object; Message: String := nil);

    method IsNil(Actual: Object; Message: String := nil);
    method IsNotNil(Actual: Object; Message: String := nil);
  end;

implementation

class method Assert.AreEqual(Actual: Object; Expected: Object; Message: String := nil);
begin
  if Expected = nil then begin
    IsNil(Actual);
    exit;
  end;

  FailIfNot(Expected.{$IF NOUGAT}isEqual{$ELSE}Equals{$ENDIF}(Actual), Actual, Expected, coalesce(Message, AssertMessages.NotEqual));
end;

class method Assert.AreNotEqual(Actual: Object; Expected: Object; Message: String := nil);
begin
  if Expected = nil then begin
    IsNotNil(Actual);
    exit;
  end;

  FailIf(Expected.{$IF NOUGAT}isEqual{$ELSE}Equals{$ENDIF}(Actual), Actual, Expected, coalesce(Message, AssertMessages.Equal));
end;

class method Assert.IsNil(Actual: Object; Message: String := nil);
begin
  FailIfNot(Actual = nil, Actual, nil, coalesce(Message, AssertMessages.NotEqual));
end;

class method Assert.IsNotNil(Actual: Object; Message: String := nil);
begin
  FailIfNot(Actual <> nil, coalesce(Message, AssertMessages.ObjectIsNil));
end;

end.