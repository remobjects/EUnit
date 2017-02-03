namespace RemObjects.Elements.EUnit;

interface

type
  BaseAction = assembly abstract class
  private
    Prev: BaseAction;
  protected
    method DoExecute(Context: RunContext); virtual; abstract;
    method HandleException(Context: RunContext; Ex: Exception): ITestResult;
  public
    constructor;
    constructor(RunAlways: Boolean);

    method Execute(Context: RunContext); virtual;
    method &Then(NextAction: BaseAction): BaseAction;

    property RunIfFailed: Boolean read write;
  end;

implementation

method BaseAction.Execute(Context: RunContext);
begin
  try
    ArgumentNilException.RaiseIfNil(Context, "Context");

    if Prev <> nil then
      Prev.Execute(Context);

    if (Context.CurrentResult:State = TestState.Failed) and (not RunIfFailed) then
      exit;

    DoExecute(Context);
  except
    on E: Exception do
      Context.CurrentResult := HandleException(Context, E);
  end;
end;

method BaseAction.Then(NextAction: BaseAction): BaseAction;
begin
  ArgumentNilException.RaiseIfNil(NextAction, "NextAction");
  var anAction := NextAction;

  while anAction.Prev <> nil do
    anAction := anAction.Prev;

  anAction.Prev := self;
  exit NextAction;
end;

method BaseAction.HandleException(Context: RunContext; Ex: Exception): ITestResult;
begin
  {$IF COOPER}
  if Ex is java.lang.reflect.InvocationTargetException then
    Ex := Exception(java.lang.reflect.InvocationTargetException(Ex).TargetException);
  {$ELSEIF ECHOES}
  if Ex is System.Reflection.TargetInvocationException then
    Ex := System.Reflection.TargetInvocationException(Ex).InnerException
  else if Ex is System.AggregateException then
    Ex := System.AggregateException(Ex).InnerException;
  {$ENDIF}
  var Message: String := Ex.Message;
  var ExceptionName: String := {$IF COOPER}Ex.Class.SimpleName{$ELSEIF ECHOES}Ex.GetType.Name{$ELSEIF ISLAND}typeOf(Ex).Name{$ELSEIF NOUGAT}Foundation.NSString.stringWithUTF8String(class_getName(Ex.class)){$ENDIF};

  if Message = nil then
    Message := "";

  if Ex is AssertException then
    exit new TestResultNode(Context.Test, TestState.Failed, Message, BaseException(Ex):ParsableMessage)
  else
    exit new TestResultNode(Context.Test, TestState.Failed, "["+ExceptionName+"]"+ if Message = "" then "" else ": " + Message, BaseException(Ex):ParsableMessage);
end;

constructor BaseAction;
begin
  RunIfFailed := true;
end;

constructor BaseAction(RunAlways: Boolean);
begin
  RunIfFailed := RunAlways;
end;

end.