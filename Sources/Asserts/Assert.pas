namespace RemObjects.Elements.EUnit;

type
  BaseAsserts = public partial abstract class
  assembly

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

  public

    method Fail(Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); abstract;
    method Success(aIgnoredMessage: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); abstract;

  end;

  Asserts = assembly partial class(BaseAsserts)
  public

    method Fail(Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); override;
    begin
      Message := coalesce(Message, AssertMessages.Unknown);
      raise new AssertException(Message, aFile, aLine, aClass, aMethod, "TEST");
    end;

    method Success(aIgnoredMessage: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); override;
    begin
      {$IF NOT WINDOWS_PHONE AND NOT NETFX_CORE}
      if ConsoleTestListener.EmitParseableSuccessMessages then begin
        writeLn(String.Format("TEST-SUCCEEDED,{0},{1},{2}.{3},{4}", aFile, if aLine > 0 then aLine else "", aClass:Trim, aMethod:Trim, "Succeeded"));
      end;
      {$ENDIF}
    end;

  end;

  Checks = assembly partial class(BaseAsserts)
  public

    method Fail(Message: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); override;
    begin
      Message := coalesce(Message, AssertMessages.Unknown);
      var lException := new AssertException(Message, aFile, aLine, aClass, aMethod, "CHECK");
      RunContext.CurrentContext.AddIntermediateTestResult(TestState.Failed, lException);
    end;

    method Success(aIgnoredMessage: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); override;
    begin
      {$IF NOT WINDOWS_PHONE AND NOT NETFX_CORE}
      if ConsoleTestListener.EmitParseableSuccessMessages then begin
        writeLn(String.Format("CHECK-SUCCEEDED,{0},{1},{2}.{3},{4}", aFile, if aLine > 0 then aLine else "", aClass:Trim, aMethod:Trim, "Succeeded"));
      end;
      {$ENDIF}
    end;

  end;

{$GLOBALS ON}

//property Assert: BaseAsserts := new Asserts; lazy;
//property Check: BaseAsserts := new Checks; lazy;

var Assert: BaseAsserts := new Asserts; readonly;
var Check: BaseAsserts := new Checks; readonly;

end.