namespace RemObjects.Elements.EUnit;

interface

type
  ConsoleTestListener = public class (IEventListener)
  private
    Offset: Integer;
    method StringOffset: String;
    method StateToString(State: TestState): String;
  protected
    method Output(aMessage: String); virtual;
  public
    method RunStarted(Test: ITest); virtual;
    method TestStarted(aTest: ITest); virtual;
    method TestFinished(aTestResult: ITestResult); virtual;
    method RunFinished(aTestResult: ITestResult); virtual;

    property UseAnsiColorOutput: Boolean;
    class property EmitParseableMessages: Boolean read assembly write := false;
    class property EmitParseableSuccessMessages: Boolean read assembly write := false;
    class property EmitSuccessMessages: Boolean read assembly write := false;

    class constructor;
    begin
      var lHasParsableMessageEnvironmentVar := length(Environment.EnvironmentVariable[Runner.EUNIT_PARSABLE_MESSAGES]) > 0;
      var lHasParsableMessageCommandlineSwitch := false;
      {$IF DARWIN}
      lHasParsableMessageCommandlineSwitch := Foundation.NSProcessInfo.processInfo.arguments.Any(s -> s = "--"+Runner.EUNIT_PARSABLE_MESSAGES);
      EmitSuccessMessages :=                  Foundation.NSProcessInfo.processInfo.arguments.Any(s -> s = "--"+Runner.EUNIT_SUCCESS_MESSAGES);
      {$ELSEIF ECHOES}
      lHasParsableMessageCommandlineSwitch := System.Environment.CommandLine.Contains("--"+Runner.EUNIT_PARSABLE_MESSAGES);
      EmitSuccessMessages := System.Environment.CommandLine.Contains("--"+Runner.EUNIT_SUCCESS_MESSAGES);
      {$ENDIF}
      EmitSuccessMessages := EmitSuccessMessages or (length(Environment.EnvironmentVariable[Runner.EUNIT_SUCCESS_MESSAGES]) > 0);
      EmitParseableMessages := lHasParsableMessageEnvironmentVar or lHasParsableMessageCommandlineSwitch;
      EmitParseableSuccessMessages := EmitSuccessMessages and EmitParseableMessages; // for now
    end;

  end;

implementation

method ConsoleTestListener.StateToString(State: TestState): String;
begin
  case State of
    TestState.Untested: exit "Untested";
    TestState.Skipped: exit "Skipped";
    TestState.Failed: exit "Failed";
    TestState.Succeeded: exit "Succeeded";
  end;
end;

method ConsoleTestListener.TestFinished(aTestResult: ITestResult);
begin
  if aTestResult.State = TestState.Skipped then
    exit;

  if aTestResult.Test.Kind <> TestKind.Testcase then
      dec(Offset, 2);

  if EmitParseableMessages then begin
    if (aTestResult.State ≠ TestState.Succeeded) or ConsoleTestListener.EmitParseableSuccessMessages then
      Output(aTestResult.ParsableMessage);
  end
  else begin
    var Failed := "failed";
    var Succeeded := "succeeded";

    if UseAnsiColorOutput then begin
      Failed := #27"[1m"#27"[31mfailed"#27"[0m";
      Succeeded := #27"[32msucceded"#27"[0m";
    end;

    if aTestResult.State = TestState.Failed then begin
      for each c in aTestResult.ChildMessages do
        Output(#"{StringOffset}❌ Check {Failed}: {c}");
      Output(#"{StringOffset}❌ Test {aTestResult.Name} {Failed}: {aTestResult.Message}");
    end
    else begin
      Output(#"{StringOffset}✅ Test {aTestResult.Name} {Succeeded}.");
    end;
  end;

end;

method ConsoleTestListener.RunStarted(Test: ITest);
begin
  Offset := 0;
end;

method ConsoleTestListener.RunFinished(aTestResult: ITestResult);
begin
  if EmitParseableMessages then begin
  end
  else begin
    Output("======================================");
    var S := new Summary(aTestResult, item -> (item.Test.Kind = TestKind.Testcase));
    Output(String.Format("{0} succeeded, {1} failed, {2} skipped, {3} untested", S.Succeeded, S.Failed, S.Skipped, S.Untested));
  end;
end;

method ConsoleTestListener.Output(aMessage: String);
begin
  if length(aMessage) > 0 then begin
    {$IFNDEF NETFX_CORE}
    writeLn(aMessage);
    {$ELSE}
    System.Diagnostics.Debug.WriteLine(Message);
    {$ENDIF}
  end;
end;

method ConsoleTestListener.TestStarted(aTest: ITest);
begin
  if (aTest.Kind = TestKind.Testcase) or (aTest.Skip) then
    exit;

  if not EmitParseableMessages then
    Output(String.Format("{0}{1} started", StringOffset, aTest.Name));
  inc(Offset, 2);
end;

method ConsoleTestListener.StringOffset: String;
begin
  if Offset <= 0 then
    exit "";

  exit new StringBuilder().Append(' ', Offset).ToString;
end;

end.