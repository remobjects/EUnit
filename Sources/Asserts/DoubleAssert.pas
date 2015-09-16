namespace RemObjects.Elements.EUnit;

interface

uses
  Sugar;

type
  Assert = public partial static class {$IF NOUGAT}mapped to Object{$ENDIF}
  public
    method AreEqual(Actual, Expected : Double; Message: String := nil);
    method AreEqual(Actual, Expected, Precision : Double; Message: String := nil);
    method AreNotEqual(Actual, Expected: Double; Message: String := nil);
    method AreNotEqual(Actual, Expected, Precision: Double; Message: String := nil);
    method Greater(Actual, Expected: Double; Message: String := nil);
    method GreaterOrEquals(Actual, Expected: Double; Message: String := nil);
    method Less(Actual, Expected: Double; Message: String := nil);
    method LessOrEquals(Actual, Expected: Double; Message: String := nil);

    method IsNaN(Actual: Double; Message: String := nil);
    method IsNotNaN(Actual: Double; Message: String := nil);
    method IsInfinity(Actual: Double; Message: String := nil);
    method IsNotInfinity(Actual: Double; Message: String := nil);
  end;

implementation

class method Assert.AreEqual(Actual: Double; Expected: Double; Message: String := nil);
begin
  FailIfNot(Actual = Expected, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.NotEqual));
end;

class method Assert.AreEqual(Actual: Double; Expected: Double; Precision: Double; Message: String := nil);
begin
  if Consts.IsInfinity(Expected) or Consts.IsNaN(Expected) or Consts.IsNaN(Actual) then
    AreEqual(Actual, Expected, Message)
  else
    FailIfNot(Math.Abs(Expected - Actual) <= Precision, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.NotEqual));
end;

class method Assert.AreNotEqual(Actual: Double; Expected: Double; Message: String := nil);
begin
  FailIfNot(Actual <> Expected, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.Equal));
end;

class method Assert.AreNotEqual(Actual: Double; Expected: Double; Precision: Double; Message: String := nil);
begin
  if Consts.IsInfinity(Expected) or Consts.IsNaN(Expected) or Consts.IsNaN(Actual) then
    AreNotEqual(Actual, Expected, Message)
  else
    FailIfNot(Math.Abs(Expected - Actual) > Precision, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.Equal));
end;

class method Assert.Greater(Actual: Double; Expected: Double; Message: String := nil);
begin
  FailIfNot(Actual > Expected, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.GreaterExpected));
end;

class method Assert.GreaterOrEquals(Actual: Double; Expected: Double; Message: String := nil);
begin
  FailIfNot(Actual >= Expected, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.GreaterOrEqualExpected));
end;

class method Assert.Less(Actual: Double; Expected: Double; Message: String := nil);
begin
  FailIfNot(Actual < Expected, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.LessExpected));
end;

class method Assert.LessOrEquals(Actual: Double; Expected: Double; Message: String := nil);
begin
  FailIfNot(Actual <= Expected, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.LessOrEqualExpected));
end;

class method Assert.IsNaN(Actual: Double; Message: String := nil);
begin
  FailIfNot(Consts.IsNaN(Actual), Convert.ToString(Actual), Convert.ToString(Consts.NaN), coalesce(Message, AssertMessages.ValueIsNotNaN));
end;

class method Assert.IsNotNaN(Actual: Double; Message: String := nil);
begin
  FailIf(Consts.IsNaN(Actual), Convert.ToString(Actual), Convert.ToString(Consts.NaN), coalesce(Message, AssertMessages.ValueIsNaN));
end;

class method Assert.IsInfinity(Actual: Double; Message: String := nil);
begin
  FailIfNot(Consts.IsInfinity(Actual), Convert.ToString(Actual), Convert.ToString(Consts.PositiveInfinity), coalesce(Message, AssertMessages.ValueIsNotInf));
end;

class method Assert.IsNotInfinity(Actual: Double; Message: String := nil);
begin
  FailIf(Consts.IsInfinity(Actual), Convert.ToString(Actual), Convert.ToString(Consts.PositiveInfinity), coalesce(Message, AssertMessages.ValueIsInf));
end;

end.