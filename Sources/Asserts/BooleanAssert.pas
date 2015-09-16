namespace RemObjects.Elements.EUnit;

interface

uses
  Sugar;

type
  Assert = public partial static class {$IF NOUGAT}mapped to Object{$ENDIF}
  private
    method BoolToString(Value: Boolean): String;
  public
    method AreEqual(Actual, Expected : Boolean; Message: String := nil);
    method AreNotEqual(Actual, Expected: Boolean; Message: String := nil);

    method IsTrue(Actual: Boolean; Message: String := nil);
    method IsFalse(Actual: Boolean; Message: String := nil);
  end;

implementation

class method Assert.BoolToString(Value: Boolean): String;
begin
  exit if Value then Consts.TrueString else Consts.FalseString;
end;

class method Assert.AreEqual(Actual: Boolean; Expected: Boolean; Message: String := nil);
begin
  FailIfNot(Actual = Expected, BoolToString(Actual), BoolToString(Expected), coalesce(Message, AssertMessages.NotEqual));
end;

class method Assert.AreNotEqual(Actual: Boolean; Expected: Boolean; Message: String := nil);
begin
  FailIf(Actual = Expected, BoolToString(Actual), BoolToString(Expected), coalesce(Message, AssertMessages.Equal));
end;

class method Assert.IsTrue(Actual: Boolean; Message: String := nil);
begin
  FailIfNot(Actual, BoolToString(Actual), Consts.TrueString, coalesce(Message, AssertMessages.NotEqual));
end;

class method Assert.IsFalse(Actual: Boolean; Message: String := nil);
begin
  FailIf(Actual, BoolToString(Actual), Consts.FalseString, coalesce(Message, AssertMessages.NotEqual));
end;

end.