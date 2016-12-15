namespace RemObjects.Elements.EUnit;

interface

type
  Assert = public partial static class
  private
    method FailIf(Condition: Boolean; Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName(); aEmitSuccess: Boolean := true);
    method FailIfNot(Condition: Boolean; Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method FailComparison(Actual, Expected: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method FailComparisonIf(Condition: Boolean; Actual, Expected : Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method FailComparisonIfNot(Condition: Boolean; Actual, Expected : Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    method Success(aMessage: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
  public
    method Fail(Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
  end;

implementation

method Assert.Fail(Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  raise new AssertException(coalesce(Message, AssertMessages.Unknown), aFile, aLine, aClass, aMethod);
end;

method Assert.FailComparison(Actual: Object; Expected: Object; Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  if not assigned(Message) then
    Message := AssertMessages.Unknown2;

  Fail(String.Format(Message, coalesce(Actual, "(nil)"), coalesce(Expected, "(nil)")), aFile, aLine, aClass, aMethod);
end;

method Assert.FailIf(Condition: Boolean; Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName(); aEmitSuccess: Boolean := true);
begin
  if Condition then
    Fail(Message, aFile, aLine, aClass, aMethod)
  else
    if aEmitSuccess then Success(Message, aFile, aLine, aClass, aMethod);
end;

method Assert.FailIfNot(Condition: Boolean; Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  if not Condition then
    Fail(Message, aFile, aLine, aClass, aMethod)
  else
    Success(Message, aFile, aLine, aClass, aMethod);
end;

method Assert.FailComparisonIf(Condition: Boolean; Actual: Object; Expected: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  if Condition then
    FailComparison(Actual, Expected, Message, aFile, aLine, aClass, aMethod)
  else
    Success(Message, aFile, aLine, aClass, aMethod);
end;

method Assert.FailComparisonIfNot(Condition: Boolean; Actual: Object; Expected: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  if not Condition then
    FailComparison(Actual, Expected, Message, aFile, aLine, aClass, aMethod)
  else
    Success(Message, aFile, aLine, aClass, aMethod);
end;

method Assert.Success(aMessage: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  {$IF NOT WINDOWS_PHONE AND NOT NETFX_CORE}
  if ConsoleTestListener.EmitParseableSuccessMessages then begin
    writeLn(String.Format("CHECK-SUCCEEDED,{0},{1},{2}.{3},{4}", aFile, if aLine > 0 then aLine else "", aClass:Trim, aMethod:Trim, "Succeeded"));
  end;
  {$ENDIF}
end;

end.