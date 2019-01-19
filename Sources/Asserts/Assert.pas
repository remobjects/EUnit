namespace RemObjects.Elements.EUnit;

interface

type
  Assert = public partial static class
  assembly

    method FailIf(Condition: Boolean; Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName(); aSoftFail: Boolean := false);
    begin
      if Condition then
        Fail(Message, aFile, aLine, aClass, aMethod)
      else
        Success(Message, aFile, aLine, aClass, aMethod);
    end;

    method FailIfNot(Condition: Boolean; Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName(); aSoftFail: Boolean := false);
    begin
      if not Condition then
        Fail(Message, aFile, aLine, aClass, aMethod)
      else
        Success(Message, aFile, aLine, aClass, aMethod);
    end;

    method FailComparison(Actual, Expected: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName(); aSoftFail: Boolean := false);
    begin
      if not assigned(Message) then
        Message := String.Format(AssertMessages.Unknown2, coalesce(Actual, "(nil)"), coalesce(Expected, "(nil)"))
      else if Message.StartsWith("EUNIT_REPLACE:") then
        Message := String.Format(Message.Substring(14), coalesce(Actual, "(nil)"), coalesce(Expected, "(nil)"));

      Fail(Message, aFile, aLine, aClass, aMethod);
    end;

    method FailComparisonIf(Condition: Boolean; Actual, Expected : Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName(); aSoftFail: Boolean := false);
    begin
      if Condition then
        FailComparison(Actual, Expected, Message, aFile, aLine, aClass, aMethod)
      else
        Success(Message, aFile, aLine, aClass, aMethod);
    end;

    method FailComparisonIfNot(Condition: Boolean; Actual, Expected : Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName(); aSoftFail: Boolean := false);
    begin
      if not Condition then
        FailComparison(Actual, Expected, Message, aFile, aLine, aClass, aMethod)
      else
        Success(Message, aFile, aLine, aClass, aMethod);
    end;

    method Fail(Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName(); aSoftFail: Boolean := false);
    begin
      Message := coalesce(Message, AssertMessages.Unknown);
      raise new AssertException(Message, aFile, aLine, aClass, aMethod);
    end;

    method Success(aIgnoredMessage: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName(); aSoftFail: Boolean := false);
    begin
      {$IF NOT WINDOWS_PHONE AND NOT NETFX_CORE}
      if ConsoleTestListener.EmitParseableSuccessMessages then begin
        writeLn(String.Format("TEST-SUCCEEDED,{0},{1},{2}.{3},{4}", aFile, if aLine > 0 then aLine else "", aClass:Trim, aMethod:Trim, "Succeeded"));
      end;
      {$ENDIF}
    end;

  end;

  Check = public partial static class
  private

    method FailIf(Condition: Boolean; Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    begin
      if Condition then
        Fail(Message, aFile, aLine, aClass, aMethod)
      else
        Success(Message, aFile, aLine, aClass, aMethod);
    end;

    method FailIfNot(Condition: Boolean; Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    begin
      if not Condition then
        Fail(Message, aFile, aLine, aClass, aMethod)
      else
        Success(Message, aFile, aLine, aClass, aMethod);
    end;

    method FailComparison(Actual, Expected: Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    begin
      if not assigned(Message) then
        Message := String.Format(AssertMessages.Unknown2, coalesce(Actual, "(nil)"), coalesce(Expected, "(nil)"))
      else if Message.StartsWith("EUNIT_REPLACE:") then
        Message := String.Format(Message.Substring(14), coalesce(Actual, "(nil)"), coalesce(Expected, "(nil)"));

      Fail(Message, aFile, aLine, aClass, aMethod);
    end;

    method FailComparisonIf(Condition: Boolean; Actual, Expected : Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    begin
      if Condition then
        FailComparison(Actual, Expected, Message, aFile, aLine, aClass, aMethod)
      else
        Success(Message, aFile, aLine, aClass, aMethod);
    end;

    method FailComparisonIfNot(Condition: Boolean; Actual, Expected : Object; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    begin
      if not Condition then
        FailComparison(Actual, Expected, Message, aFile, aLine, aClass, aMethod)
      else
        Success(Message, aFile, aLine, aClass, aMethod);
    end;

    method Fail(Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    begin
      Message := coalesce(Message, AssertMessages.Unknown);
      var ParsableMessage := String.Format("TEST-FAILED,{0},{1},{2}.{3},{4}", aFile, if aLine > 0 then aLine else "", aClass:Trim, aMethod:Trim, Message.Replace(#10,"\n").Replace(#13,"\r"));
      RunContext.CurrentContext.AddIntermediateTestResult(TestState.Failed, Message, ParsableMessage);
    end;

    method Success(aIgnoredMessage: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    begin
      {$IF NOT WINDOWS_PHONE AND NOT NETFX_CORE}
      if ConsoleTestListener.EmitParseableSuccessMessages then begin
        writeLn(String.Format("TEST-SUCCEEDED,{0},{1},{2}.{3},{4}", aFile, if aLine > 0 then aLine else "", aClass:Trim, aMethod:Trim, "Succeeded"));
      end;
      {$ENDIF}
    end;

  end;

implementation

end.