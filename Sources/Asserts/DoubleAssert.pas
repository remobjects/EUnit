namespace RemObjects.Elements.EUnit;

interface

type
  BaseAsserts = public partial abstract class
  public
    method AreEqual(Actual, Expected : Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method AreEqual(Actual, Expected, Precision : Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method AreNotEqual(Actual, Expected: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method AreNotEqual(Actual, Expected, Precision: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method Greater(Actual, Expected: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method GreaterOrEquals(Actual, Expected: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method Less(Actual, Expected: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method LessOrEquals(Actual, Expected: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());

    method IsNaN(Actual: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method IsNotNaN(Actual: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method IsInfinity(Actual: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method IsNotInfinity(Actual: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
  end;

implementation

method BaseAsserts.AreEqual(Actual: Double; Expected: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual = Expected, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.AreEqual(Actual: Double; Expected: Double; Precision: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  if Consts.IsInfinity(Expected) or Consts.IsNaN(Expected) or Consts.IsNaN(Actual) then
    AreEqual(Actual, Expected, Message, aFile, aLine, aClass, aMethod)
  else
    FailComparisonIfNot(Math.Abs(Expected - Actual) <= Precision, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.AreNotEqual(Actual: Double; Expected: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual <> Expected, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.Equal), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.AreNotEqual(Actual: Double; Expected: Double; Precision: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  if Consts.IsInfinity(Expected) or Consts.IsNaN(Expected) or Consts.IsNaN(Actual) then
    AreNotEqual(Actual, Expected, Message, aFile, aLine, aClass, aMethod)
  else
    FailComparisonIfNot(Math.Abs(Expected - Actual) > Precision, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.Equal), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.Greater(Actual: Double; Expected: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual > Expected, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.GreaterExpected), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.GreaterOrEquals(Actual: Double; Expected: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual >= Expected, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.GreaterOrEqualExpected), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.Less(Actual: Double; Expected: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual < Expected, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.LessExpected), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.LessOrEquals(Actual: Double; Expected: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual <= Expected, Convert.ToString(Actual), Convert.ToString(Expected), coalesce(Message, AssertMessages.LessOrEqualExpected), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.IsNaN(Actual: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Consts.IsNaN(Actual), Convert.ToString(Actual), Convert.ToString(Consts.NaN), coalesce(Message, AssertMessages.ValueIsNotNaN), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.IsNotNaN(Actual: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIf(Consts.IsNaN(Actual), Convert.ToString(Actual), Convert.ToString(Consts.NaN), coalesce(Message, AssertMessages.ValueIsNaN), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.IsInfinity(Actual: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Consts.IsInfinity(Actual), Convert.ToString(Actual), Convert.ToString(Consts.PositiveInfinity), coalesce(Message, AssertMessages.ValueIsNotInf), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.IsNotInfinity(Actual: Double; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIf(Consts.IsInfinity(Actual), Convert.ToString(Actual), Convert.ToString(Consts.PositiveInfinity), coalesce(Message, AssertMessages.ValueIsInf), aFile, aLine, aClass, aMethod);
end;

end.