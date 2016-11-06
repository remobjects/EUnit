namespace RemObjects.Elements.EUnit;

interface

uses
  Sugar;

type
  Assert = public partial static class
  public
    method AreEqual(Actual, Expected : Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method AreNotEqual(Actual, Expected: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());

    method IsNil(Actual: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method IsNotNil(Actual: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
  end;

implementation

method Assert.AreEqual(Actual: Object; Expected: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  if Expected = nil then begin
    IsNil(Actual, aFile, aLine, aClass, aMethod);
    exit;
  end;

  FailComparisonIfNot(Expected.{$IF NOUGAT}isEqual{$ELSE}Equals{$ENDIF}(Actual), Actual, Expected, coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

method Assert.AreNotEqual(Actual: Object; Expected: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  if Expected = nil then begin
    IsNotNil(Actual, aFile, aLine, aClass, aMethod);
    exit;
  end;

  FailComparisonIf(Expected.{$IF NOUGAT}isEqual{$ELSE}Equals{$ENDIF}(Actual), Actual, Expected, coalesce(Message, AssertMessages.Equal), aFile, aLine, aClass, aMethod);
end;

method Assert.IsNil(Actual: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailComparisonIfNot(Actual = nil, Actual, nil, coalesce(Message, AssertMessages.NotEqual), aFile, aLine, aClass, aMethod);
end;

method Assert.IsNotNil(Actual: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  FailIfNot(Actual <> nil, coalesce(Message, AssertMessages.ObjectIsNil), aFile, aLine, aClass, aMethod);
end;

end.