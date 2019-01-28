namespace RemObjects.Elements.EUnit;

interface

type
  BaseAsserts = public partial abstract class
  public
    method AreEqual(Actual, Expected : Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method AreNotEqual(Actual, Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method Greater(Actual, Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method GreaterOrEquals(Actual, Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method Less(Actual, Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method LessOrEquals(Actual, Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());

    method AreEqual(Actual, Expected : Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method AreNotEqual(Actual, Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method Greater(Actual, Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method GreaterOrEquals(Actual, Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method Less(Actual, Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method LessOrEquals(Actual, Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
  end;

implementation

method BaseAsserts.AreNotEqual(Actual: Integer; Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual <> Expected, Actual, Expected, coalesce(Message, AssertMessages.Equal), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.AreEqual(Actual: Integer; Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual = Expected, Actual, Expected, coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.Greater(Actual: Integer; Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual > Expected, Actual, Expected, coalesce(Message, AssertMessages.GreaterExpected), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.GreaterOrEquals(Actual: Integer; Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual >= Expected, Actual, Expected, coalesce(Message, AssertMessages.GreaterOrEqualExpected), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.Less(Actual: Integer; Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual < Expected, Actual, Expected, coalesce(Message, AssertMessages.LessExpected), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.LessOrEquals(Actual: Integer; Expected: Integer; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual <= Expected, Actual, Expected, coalesce(Message, AssertMessages.LessOrEqualExpected), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.AreEqual(Actual: Int64; Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual = Expected, Actual, Expected, coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.AreNotEqual(Actual: Int64; Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual <> Expected, Actual, Expected, coalesce(Message, AssertMessages.Equal), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.Greater(Actual: Int64; Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual > Expected, Actual, Expected, coalesce(Message, AssertMessages.GreaterExpected), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.GreaterOrEquals(Actual: Int64; Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual >= Expected, Actual, Expected, coalesce(Message, AssertMessages.GreaterOrEqualExpected), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.Less(Actual: Int64; Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual < Expected, Actual, Expected, coalesce(Message, AssertMessages.LessExpected), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.LessOrEquals(Actual: Int64; Expected: Int64; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual <= Expected, Actual, Expected, coalesce(Message, AssertMessages.LessOrEqualExpected), aFile, aLine, aClass, aMethod);
end;

end.