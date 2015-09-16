namespace RemObjects.Elements.EUnit;

interface

uses
  Sugar;

type
  Assert = public partial static class {$IF NOUGAT}mapped to Object{$ENDIF}
  private
    method Fail(Actual, Expected: Object; Message: String := nil);
    method FailIf(Condition: Boolean; Message: String);
    method FailIf(Condition: Boolean; Actual, Expected : Object; Message: String := nil);
    method FailIfNot(Condition: Boolean; Message: String);
    method FailIfNot(Condition: Boolean; Actual, Expected : Object; Message: String := nil);
  public
    method Fail(Message: String);
  end;

implementation

class method Assert.Fail(Message: String);
begin
  if Message = nil then
    Message := AssertMessages.Unknown;

  raise new AssertException(Message);
end;

class method Assert.Fail(Actual: Object; Expected: Object; Message: String);
begin
  if Message = nil then
    Message := AssertMessages.Unknown;

  Fail(String.Format(Message, coalesce(Actual, "(nil)"), coalesce(Expected, "(nil)")));
end;

class method Assert.FailIf(Condition: Boolean; Message: String);
begin
  if Condition then
    Fail(Message);
end;

class method Assert.FailIf(Condition: Boolean; Actual: Object; Expected: Object; Message: String := nil);
begin
  if Condition then
    Fail(Actual, Expected, Message);
end;

class method Assert.FailIfNot(Condition: Boolean; Message: String);
begin
  FailIf(not Condition, Message);
end;

class method Assert.FailIfNot(Condition: Boolean; Actual: Object; Expected: Object; Message: String := nil);
begin
  FailIf(not Condition, Actual, Expected, Message);
end;

end.