namespace EUnit.Tests;

interface

uses
  Sugar,
  RemObjects.Elements.EUnit;

type
  Messages = public class (Test)
  private
    const Msg: String = "Custom Message";
    method AssertMessage(Action: AssertAction; Message: String);
  public
    method &Default;
    method AreEqual;
    method AreNotEqual;
    method Catch;
    method Contains;
    method DoesNotContains;
    method DoesNotThrow;
    method EndsWith;
    method Greater;
    method Less;
    method IsEmpty;
    method BooleanCompare;
    method IsInfinity;
    method IsNaN;
    method IsNil;
    method StartsWith;
    method Throws;
  end;

implementation

method Messages.AssertMessage(Action: AssertAction; Message: String);
begin
  Assert.AreEqual(Assert.Catch(Action).{$IF NOUGAT}reason{$ELSE}Message{$ENDIF}, Message);
end;

method Messages.Throws;
begin
  AssertMessage(->Assert.Throws(->begin end), "Action does not throw an exception");
  AssertMessage(->Assert.Throws(->begin end, typeOf(ArgumentNilException)), "Action does not throw an exception");
  AssertMessage(->Assert.Throws(->raise new InvalidOperationException(""), typeOf(ArgumentNilException)), 
    "Expected: <ArgumentNilException> but was: <InvalidOperationException>");

  AssertMessage(->Assert.Throws(->begin end, Msg), Msg);
  AssertMessage(->Assert.Throws(->begin end, typeOf(ArgumentNilException), Msg), Msg);
  AssertMessage(->Assert.Throws(->raise new InvalidOperationException(""), typeOf(ArgumentNilException), Msg), Msg);
end;

method Messages.StartsWith;
begin
  AssertMessage(->Assert.StartsWith("x", "String"), "String <String> does not starts with <x>");
  AssertMessage(->Assert.StartsWith("x", "String", Msg), Msg);
end;

method Messages.IsNil;
begin
  AssertMessage(->Assert.IsNil("String"), "Expected: <(nil)> but was: <String>");
  AssertMessage(->Assert.IsNil("String", Msg), Msg);
  AssertMessage(->Assert.IsNotNil(nil), "Object is nil");
  AssertMessage(->Assert.IsNotNil(nil, Msg), Msg);
end;

method Messages.IsNaN;
begin
  AssertMessage(->Assert.IsNaN(1), "NaN expected but was: <1>");
  AssertMessage(->Assert.IsNaN(1, Msg), Msg);
  AssertMessage(->Assert.IsNotNaN(Consts.NaN), "Value is NaN");
  AssertMessage(->Assert.IsNotNaN(Consts.NaN, Msg), Msg);
end;

method Messages.IsInfinity;
begin
  AssertMessage(->Assert.IsInfinity(1), "Infinity expected but was: <1>");
  AssertMessage(->Assert.IsInfinity(1, Msg), Msg);
  AssertMessage(->Assert.IsNotInfinity(Consts.PositiveInfinity), "Value is infinity");
  AssertMessage(->Assert.IsNotInfinity(Consts.PositiveInfinity, Msg), Msg);
end;

method Messages.BooleanCompare;
begin
  AssertMessage(->Assert.IsTrue(false), "Expected: <True> but was: <False>");
  AssertMessage(->Assert.IsTrue(false, Msg), Msg);
  AssertMessage(->Assert.IsFalse(true), "Expected: <False> but was: <True>");
  AssertMessage(->Assert.IsFalse(true, Msg), Msg);
end;

method Messages.IsEmpty;
begin  
  AssertMessage(->Assert.IsEmpty("Abc"), "String is not empty");
  AssertMessage(->Assert.IsEmpty("Abc", Msg), Msg);
  AssertMessage(->Assert.IsEmpty([1, 2, 3]), "Sequence is not empty");
  AssertMessage(->Assert.IsEmpty([1, 2, 3], Msg), Msg);

  AssertMessage(->Assert.IsNotEmpty(""), "String is empty");
  AssertMessage(->Assert.IsNotEmpty("", Msg), Msg);
  AssertMessage(->Assert.IsNotEmpty<Integer>([]), "Sequence is empty");
  AssertMessage(->Assert.IsNotEmpty<Integer>([], Msg), Msg);  
end;

method Messages.Less;
begin
  AssertMessage(->Assert.Less(7, 5), "Value expected to be less than <5>, but was: <7>");
  AssertMessage(->Assert.Less(7, 5, Msg), Msg);
  AssertMessage(->Assert.Less(Int64(7), Int64(5)), "Value expected to be less than <5>, but was: <7>");
  AssertMessage(->Assert.Less(Int64(7), Int64(5), Msg), Msg);
  AssertMessage(->Assert.Less(7.1, 5.1), "Value expected to be less than <5.1>, but was: <7.1>");
  AssertMessage(->Assert.Less(7.1, 5.1, Msg), Msg);

  AssertMessage(->Assert.LessOrEquals(7, 5), "Value expected to be less than or equal to <5>, but was: <7>");
  AssertMessage(->Assert.LessOrEquals(7, 5, Msg), Msg);
  AssertMessage(->Assert.LessOrEquals(Int64(7), Int64(5)), "Value expected to be less than or equal to <5>, but was: <7>");
  AssertMessage(->Assert.LessOrEquals(Int64(7), Int64(5), Msg), Msg);
  AssertMessage(->Assert.LessOrEquals(7.1, 5.1), "Value expected to be less than or equal to <5.1>, but was: <7.1>");
  AssertMessage(->Assert.LessOrEquals(7.1, 5.1, Msg), Msg);
end;

method Messages.Greater;
begin
  AssertMessage(->Assert.Greater(5, 7), "Value expected to be greater than <7>, but was: <5>");
  AssertMessage(->Assert.Greater(5, 7, Msg), Msg);
  AssertMessage(->Assert.Greater(Int64(5), Int64(7)), "Value expected to be greater than <7>, but was: <5>");
  AssertMessage(->Assert.Greater(Int64(5), Int64(7), Msg), Msg);
  AssertMessage(->Assert.Greater(5.1, 7.1), "Value expected to be greater than <7.1>, but was: <5.1>");
  AssertMessage(->Assert.Greater(5.1, 7.1, Msg), Msg);

  AssertMessage(->Assert.GreaterOrEquals(5, 7), "Value expected to be greater than or equal to <7>, but was: <5>");
  AssertMessage(->Assert.GreaterOrEquals(5, 7, Msg), Msg);
  AssertMessage(->Assert.GreaterOrEquals(Int64(5), Int64(7)), "Value expected to be greater than or equal to <7>, but was: <5>");
  AssertMessage(->Assert.GreaterOrEquals(Int64(5), Int64(7), Msg), Msg);
  AssertMessage(->Assert.GreaterOrEquals(5.1, 7.1), "Value expected to be greater than or equal to <7.1>, but was: <5.1>");
  AssertMessage(->Assert.GreaterOrEquals(5.1, 7.1, Msg), Msg);
end;

method Messages.EndsWith;
begin
  AssertMessage(->Assert.EndsWith("x", "String"), "String <String> does not ends with <x>");
  AssertMessage(->Assert.EndsWith("x", "String", Msg), Msg);
end;

method Messages.DoesNotThrow;
begin
  AssertMessage(->Assert.DoesNotThrows(->raise new InvalidOperationException("")), "Unexpected exception: <InvalidOperationException>");
  AssertMessage(->Assert.DoesNotThrows(->raise new InvalidOperationException(""), Msg), Msg);
end;

method Messages.DoesNotContains;
begin
  AssertMessage(->Assert.DoesNotContains("a", "abc"), "String contains unexpected element: <a>");
  AssertMessage(->Assert.DoesNotContains("a", "abc", Msg),  Msg);
  AssertMessage(->Assert.DoesNotContains<Integer>(1, [1, 2, 3]), "Sequence contains unexpected element: <1>");
  AssertMessage(->Assert.DoesNotContains<Integer>(1, [1, 2, 3], Msg),  Msg);
end;

method Messages.Contains;
begin
  AssertMessage(->Assert.Contains("a", "world"), "String does not contains element: <a>");
  AssertMessage(->Assert.Contains("a", "world", Msg),  Msg);
  AssertMessage(->Assert.Contains<Integer>(1, [7, 6, 5]), "Sequence does not contains element: <1>");
  AssertMessage(->Assert.Contains<Integer>(1, [7, 6, 5], Msg),  Msg);
end;

method Messages.Catch;
begin
  AssertMessage(->Assert.Catch(->begin end), "Action does not throw an exception");
  AssertMessage(->Assert.Catch(->begin end, Msg), Msg);
end;

method Messages.AreNotEqual;
begin  
  AssertMessage(->Assert.AreNotEqual(1, 1), "Actual value expected to be different from <1>");
  AssertMessage(->Assert.AreNotEqual(Int64(1), Int64(1)), "Actual value expected to be different from <1>");
  AssertMessage(->Assert.AreNotEqual(1.1, 1.1), "Actual value expected to be different from <1.1>");
  AssertMessage(->Assert.AreNotEqual(1.12, 1.11, 0.1), "Actual value expected to be different from <1.11>");
  AssertMessage(->Assert.AreNotEqual("abc", "abc"), "Actual value expected to be different from <abc>");
  AssertMessage(->Assert.AreNotEqual("abc", "AbC", true), "Actual value expected to be different from <AbC>");
  AssertMessage(->Assert.AreNotEqual(new CodeObject(1), new CodeObject(1)), "Actual value expected to be different from <1>");
  AssertMessage(->Assert.AreNotEqual(true, true), "Actual value expected to be different from <True>");
  AssertMessage(->Assert.AreNotEqual<Integer>([1, 2, 3], [1, 2, 3]), "Sequence equals but expected to be different");
  AssertMessage(->Assert.AreNotEqual<Integer>([2, 1, 3], [3, 2, 1], true), "Sequence equals but expected to be different");

  AssertMessage(->Assert.AreNotEqual(1, 1, Msg), Msg);
  AssertMessage(->Assert.AreNotEqual(Int64(1), Int64(1), Msg), Msg);
  AssertMessage(->Assert.AreNotEqual(1.1, 1.1, Msg), Msg);
  AssertMessage(->Assert.AreNotEqual(1.12, 1.11, 0.1, Msg), Msg);
  AssertMessage(->Assert.AreNotEqual("abc", "abc", Msg), Msg);
  AssertMessage(->Assert.AreNotEqual("abc", "AbC", true, Msg), Msg);
  AssertMessage(->Assert.AreNotEqual(new CodeObject(1), new CodeObject(1), Msg), Msg);
  AssertMessage(->Assert.AreNotEqual(true, true, Msg), Msg);
  AssertMessage(->Assert.AreNotEqual<Integer>([1, 2, 3], [1, 2, 3], Msg), Msg);
  AssertMessage(->Assert.AreNotEqual<Integer>([2, 1, 3], [3, 2, 1], true, Msg), Msg);
end;

method Messages.AreEqual;
begin
  AssertMessage(->Assert.AreEqual("string", "String"), "Expected: <String> but was: <string>");
  AssertMessage(->Assert.AreEqual("gnirtS", "String", true), "Expected: <String> but was: <gnirtS>");
  AssertMessage(->Assert.AreEqual("string", nil), "Expected: <(nil)> but was: <string>");
  AssertMessage(->Assert.AreEqual(1, 2), "Expected: <2> but was: <1>");
  AssertMessage(->Assert.AreEqual(1.1, 2.2), "Expected: <2.2> but was: <1.1>");
  AssertMessage(->Assert.AreEqual(1.1, 2.2, 0.00000001), "Expected: <2.2> but was: <1.1>");
  AssertMessage(->Assert.AreEqual(new CodeObject(1), new CodeObject(2)), "Expected: <2> but was: <1>");
  AssertMessage(->Assert.AreEqual(true, false), "Expected: <False> but was: <True>");
  AssertMessage(->Assert.AreEqual([1, 2, 3], [2, 4, 8]), "Expected element <2> is missing from actual sequence");
  AssertMessage(->Assert.AreEqual([1, 2, 3], [2, 4, 8], true), "Expected element <4> is missing from actual sequence");

  AssertMessage(->Assert.AreEqual(1, 2, Msg), Msg);
  AssertMessage(->Assert.AreEqual(1.1, 2.2, Msg), Msg);
  AssertMessage(->Assert.AreEqual(1.1, 2.2, 0.00000001, Msg), Msg);
  AssertMessage(->Assert.AreEqual(new CodeObject(1), new CodeObject(2), Msg), Msg);
  AssertMessage(->Assert.AreEqual(true, false, Msg), Msg);
  AssertMessage(->Assert.AreEqual([1, 2, 3], [2, 4, 8], false, Msg), Msg);
  AssertMessage(->Assert.AreEqual([1, 2, 3], [2, 4, 8], true, Msg), Msg);
end;

method Messages.Default;
begin
  AssertMessage(->Assert.Fail(nil), "Unknown failure");
  AssertMessage(->Assert.Fail(Msg), Msg);
end;

end.