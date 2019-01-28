namespace RemObjects.Elements.EUnit;

interface

type
  BaseAsserts = public partial abstract class
  public
    method AreEqual(Actual, Expected : Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method AreNotEqual(Actual, Expected: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());

    method IsNil(Actual: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method IsNotNil(Actual: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
  end;

implementation

method BaseAsserts.AreEqual(Actual: Object; Expected: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  if Expected = nil then begin
    IsNil(Actual, coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
    exit;
  end;

  FailComparisonIfNot({$IF NOUGAT}Expected.isEqual(Actual){$ELSE}Expected.Equals(Actual){$ENDIF}, Actual, Expected, coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.AreNotEqual(Actual: Object; Expected: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  if Expected = nil then begin
    IsNotNil(Actual, coalesce(Message, AssertMessages.Equal), aFile, aLine, aClass, aMethod);
    exit;
  end;

  FailComparisonIf({$IF NOUGAT}Expected.isEqual(Actual){$ELSE}Expected.Equals(Actual){$ENDIF}, Actual, Expected, coalesce(Message, AssertMessages.Equal), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.IsNil(Actual: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual = nil, Actual, nil, coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.IsNotNil(Actual: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailIfNot(Actual <> nil, coalesce(Message, AssertMessages.ObjectIsNil), aFile, aLine, aClass, aMethod);
end;

end.