namespace RemObjects.Elements.EUnit;

interface

type
  Assert = public partial static class
  private
    method BoolToString(Value: Boolean): String;
  public
    method AreEqual(Actual, Expected : Boolean; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method AreNotEqual(Actual, Expected: Boolean; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());

    method IsTrue(Actual: Boolean; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method IsFalse(Actual: Boolean; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
  end;

implementation

method Assert.BoolToString(Value: Boolean): String;
begin
  exit if Value then Consts.TrueString else Consts.FalseString;
end;

method Assert.AreEqual(Actual: Boolean; Expected: Boolean; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual = Expected, BoolToString(Actual), BoolToString(Expected), coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

method Assert.AreNotEqual(Actual: Boolean; Expected: Boolean; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIf(Actual = Expected, BoolToString(Actual), BoolToString(Expected), coalesce(Message, AssertMessages.Equal), aFile, aLine, aClass, aMethod);
end;

method Assert.IsTrue(Actual: Boolean; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual, BoolToString(Actual), Consts.TrueString, coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

method Assert.IsFalse(Actual: Boolean; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIf(Actual, BoolToString(Actual), Consts.FalseString, coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

end.