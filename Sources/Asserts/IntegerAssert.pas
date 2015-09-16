namespace RemObjects.Elements.EUnit;

interface

type
  Assert = public partial static class {$IF NOUGAT}mapped to Object{$ENDIF}
  public
    method AreEqual(Actual, Expected : Int32; Message: String := nil);
    method AreNotEqual(Actual, Expected: Int32; Message: String := nil);
    method Greater(Actual, Expected: Int32; Message: String := nil);
    method GreaterOrEquals(Actual, Expected: Int32; Message: String := nil);
    method Less(Actual, Expected: Int32; Message: String := nil);
    method LessOrEquals(Actual, Expected: Int32; Message: String := nil);

    method AreEqual(Actual, Expected : Int64; Message: String := nil);
    method AreNotEqual(Actual, Expected: Int64; Message: String := nil);
    method Greater(Actual, Expected: Int64; Message: String := nil);
    method GreaterOrEquals(Actual, Expected: Int64; Message: String := nil);
    method Less(Actual, Expected: Int64; Message: String := nil);
    method LessOrEquals(Actual, Expected: Int64; Message: String := nil);
  end;

implementation

class method Assert.AreNotEqual(Actual: Integer; Expected: Integer; Message: String := nil);
begin
  FailIfNot(Actual <> Expected, Actual, Expected, coalesce(Message, AssertMessages.Equal));
end;

class method Assert.AreEqual(Actual: Integer; Expected: Integer; Message: String := nil);
begin
  FailIfNot(Actual = Expected, Actual, Expected, coalesce(Message, AssertMessages.NotEqual));
end;

class method Assert.Greater(Actual: Integer; Expected: Integer; Message: String := nil);
begin
  FailIfNot(Actual > Expected, Actual, Expected, coalesce(Message, AssertMessages.GreaterExpected));
end;

class method Assert.GreaterOrEquals(Actual: Integer; Expected: Integer; Message: String := nil);
begin
  FailIfNot(Actual >= Expected, Actual, Expected, coalesce(Message, AssertMessages.GreaterOrEqualExpected));
end;

class method Assert.Less(Actual: Integer; Expected: Integer; Message: String := nil);
begin
  FailIfNot(Actual < Expected, Actual, Expected, coalesce(Message, AssertMessages.LessExpected));
end;

class method Assert.LessOrEquals(Actual: Integer; Expected: Integer; Message: String := nil);
begin
  FailIfNot(Actual <= Expected, Actual, Expected, coalesce(Message, AssertMessages.LessOrEqualExpected));
end;

class method Assert.AreEqual(Actual: Int64; Expected: Int64; Message: String := nil);
begin
  FailIfNot(Actual = Expected, Actual, Expected, coalesce(Message, AssertMessages.NotEqual));
end;

class method Assert.AreNotEqual(Actual: Int64; Expected: Int64; Message: String := nil);
begin
  FailIfNot(Actual <> Expected, Actual, Expected, coalesce(Message, AssertMessages.Equal));
end;

class method Assert.Greater(Actual: Int64; Expected: Int64; Message: String := nil);
begin
  FailIfNot(Actual > Expected, Actual, Expected, coalesce(Message, AssertMessages.GreaterExpected));
end;

class method Assert.GreaterOrEquals(Actual: Int64; Expected: Int64; Message: String := nil);
begin
  FailIfNot(Actual >= Expected, Actual, Expected, coalesce(Message, AssertMessages.GreaterOrEqualExpected));
end;

class method Assert.Less(Actual: Int64; Expected: Int64; Message: String := nil);
begin
  FailIfNot(Actual < Expected, Actual, Expected, coalesce(Message, AssertMessages.LessExpected));
end;

class method Assert.LessOrEquals(Actual: Int64; Expected: Int64; Message: String := nil);
begin
  FailIfNot(Actual <= Expected, Actual, Expected, coalesce(Message, AssertMessages.LessOrEqualExpected));
end;

end.