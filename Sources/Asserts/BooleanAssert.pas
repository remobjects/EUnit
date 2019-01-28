namespace RemObjects.Elements.EUnit;

type
  BaseAsserts = public partial abstract class
  private
    method BoolToString(Value: Boolean): String;
    begin
      exit if Value then Consts.TrueString else Consts.FalseString;
    end;

  public
    method AreEqual(Actual, Expected : Boolean; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    begin
      FailComparisonIfNot(Actual = Expected, BoolToString(Actual), BoolToString(Expected), coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
    end;

    method AreNotEqual(Actual, Expected: Boolean; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    begin
      FailComparisonIf(Actual = Expected, BoolToString(Actual), BoolToString(Expected), coalesce(Message, AssertMessages.Equal), aFile, aLine, aClass, aMethod);
    end;


    method IsTrue(Actual: Boolean; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    begin
      FailComparisonIfNot(Actual, BoolToString(Actual), Consts.TrueString, coalesce(Message, AssertMessages.NotTrue), aFile, aLine, aClass, aMethod);
    end;

    method IsFalse(Actual: Boolean; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    begin
      FailComparisonIf(Actual, BoolToString(Actual), Consts.FalseString, coalesce(Message, AssertMessages.NotFalse), aFile, aLine, aClass, aMethod);
    end;

  end;

end.