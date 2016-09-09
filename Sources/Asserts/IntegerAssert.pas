namespace RemObjects.Elements.EUnit;

interface

type
  Assert = public partial static class
  public
    method AreEqual(Actual, Expected : Int32; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method AreNotEqual(Actual, Expected: Int32; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method Greater(Actual, Expected: Int32; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method GreaterOrEquals(Actual, Expected: Int32; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method Less(Actual, Expected: Int32; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method LessOrEquals(Actual, Expected: Int32; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());

    method AreEqual(Actual, Expected : Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method AreNotEqual(Actual, Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method Greater(Actual, Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method GreaterOrEquals(Actual, Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method Less(Actual, Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method LessOrEquals(Actual, Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
  end;

implementation

method Assert.AreNotEqual(Actual: Integer; Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual <> Expected, Actual, Expected, coalesce(Message, AssertMessages.Equal), aFile, aLine, aClass, aMethod);
end;

method Assert.AreEqual(Actual: Integer; Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual = Expected, Actual, Expected, coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

method Assert.Greater(Actual: Integer; Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual > Expected, Actual, Expected, coalesce(Message, AssertMessages.GreaterExpected), aFile, aLine, aClass, aMethod);
end;

method Assert.GreaterOrEquals(Actual: Integer; Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual >= Expected, Actual, Expected, coalesce(Message, AssertMessages.GreaterOrEqualExpected), aFile, aLine, aClass, aMethod);
end;

method Assert.Less(Actual: Integer; Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual < Expected, Actual, Expected, coalesce(Message, AssertMessages.LessExpected), aFile, aLine, aClass, aMethod);
end;

method Assert.LessOrEquals(Actual: Integer; Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual <= Expected, Actual, Expected, coalesce(Message, AssertMessages.LessOrEqualExpected), aFile, aLine, aClass, aMethod);
end;

method Assert.AreEqual(Actual: Int64; Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual = Expected, Actual, Expected, coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

method Assert.AreNotEqual(Actual: Int64; Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual <> Expected, Actual, Expected, coalesce(Message, AssertMessages.Equal), aFile, aLine, aClass, aMethod);
end;

method Assert.Greater(Actual: Int64; Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual > Expected, Actual, Expected, coalesce(Message, AssertMessages.GreaterExpected), aFile, aLine, aClass, aMethod);
end;

method Assert.GreaterOrEquals(Actual: Int64; Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual >= Expected, Actual, Expected, coalesce(Message, AssertMessages.GreaterOrEqualExpected), aFile, aLine, aClass, aMethod);
end;

method Assert.Less(Actual: Int64; Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual < Expected, Actual, Expected, coalesce(Message, AssertMessages.LessExpected), aFile, aLine, aClass, aMethod);
end;

method Assert.LessOrEquals(Actual: Int64; Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual <= Expected, Actual, Expected, coalesce(Message, AssertMessages.LessOrEqualExpected), aFile, aLine, aClass, aMethod);
end;

end.