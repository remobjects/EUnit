namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections;

type
  RunContext = assembly class
  public
    constructor (aTest: ITest);
    constructor (aTest: ITest; aListener: IEventListener);
    constructor (aTest: ITest; aListener: IEventListener; aToken: ICancelationToken);
    constructor withContext(aTest: ITest; aContext: RunContext);

    property Test: ITest read write; readonly;
    property Token: ICancelationToken read write;
    property Listener: IEventListener read write;

    property Instance: Test read write;
    property &Type: TypeReference read write;
    property &Method: MethodReference read write;
    property CurrentResult: ITestResult read write;

    method AddIntermediateTestResult(aState: TestState; aException: BaseException);
    begin
      try
        raise aException
      except
        on E: BaseException do begin
          var lResult := new TestResultNode(Test, TestState.Failed, E.Message, E.ParsableMessage);
          TestNode(Test):AddIntermediateTestResult(lResult);
          if ConsoleTestListener.EmitParseableMessages then begin
            writeLn(E.ParsableMessage);
          end;
        end;
      end;
    end;

    class property CurrentContext: RunContext read assembly write;
  end;

implementation

constructor RunContext(aTest: ITest);
begin
  constructor(aTest, nil, nil);
end;

constructor RunContext(aTest: ITest; aListener: IEventListener);
begin
  constructor(aTest, aListener, nil);
end;

constructor RunContext(aTest: ITest; aListener: IEventListener; aToken: ICancelationToken);
begin
  ArgumentNilException.RaiseIfNil(aTest, "Test");
  self.Test := aTest;
  self.Listener := aListener;
  self.Token := aToken;
end;

constructor RunContext withContext(aTest: ITest; aContext: RunContext);
begin
  ArgumentNilException.RaiseIfNil(aContext, "Context");
  ArgumentNilException.RaiseIfNil(aTest, "Test");

  self.Test := aTest;
  self.Listener := aContext.Listener;
  self.Token := aContext.Token;
  self.Type := aContext.Type;
  self.Method := aContext.Method;
  self.Instance := aContext.Instance;
end;

end.