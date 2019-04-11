namespace RemObjects.Elements.EUnit.XCTest;

{$IF NOT WEBASSEMBLY}
type
  {$IF DARWIN}[Cocoa]{$ENDIF}
  XCTestExpectation = public class

    constructor withDescription(aDescription: String);
    begin
      expectationDescription := aDescription;
    end;

    property expectationDescription: String; readonly;
    property fulfillmentCount: Integer read private write;
    property expectedFulfillmentCount: Integer := 1;
    property assertForOverFulfill: Boolean := false;

    //[SwiftName("isInverted")]
    property inverted: Boolean := false;

  public

    method fulfill(aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); virtual;
    begin
      dofulfill;
    end;

  assembly or protected

    method waitFor(aTimeout: TimeInterval): Boolean; virtual;
    begin
      result := fFulfillmentTrigger.WaitFor(Int64(aTimeout)*1000); // Event.Timeout is in Miliseconds
    end;

    method dispose; virtual;
    begin
      //fFulfillmentTrigger.Dispose();
    end;

    property isFulfilled: Boolean read (fulfillmentCount = expectedFulfillmentCount) or (not assertForOverFulfill and (fulfillmentCount ≥ expectedFulfillmentCount)); virtual;

  protected

    method dofulfill(aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    begin
      if inverted then
        XCTFail($"Expectation '{expectationDescription}' was not expected to be fulfilled", aFile, aLine, aClass, aMethod);
      if assertForOverFulfill and (fulfillmentCount ≥ expectedFulfillmentCount) then
        XCTFail($"Expectation '{expectationDescription}' was fulfilled for than {fulfillmentCount}x", aFile, aLine, aClass, aMethod);
      inc(fulfillmentCount);
      if fulfillmentCount ≥ expectedFulfillmentCount then
        fFulfillmentTrigger.Set();
    end;

  private

    var fFulfillmentTrigger := new &Event withState(false) Mode(EventMode.Manual); private;

  end;

  //XCTestManualExpectation = public class(XCTestExpectation)
  //public

    //method fulfill(aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); override;
    //begin
      //dofulfill;
    //end;

  //end;

  XCTNSNotificationExpectation = public class(XCTestExpectation)
  assembly or protected

    constructor withNotification(aNotificationName: String) object(aObject: nullable Object) handler(aHandler: Handler);
    begin
      inherited constructor withDescription($"Expectation for notification '{aNotificationName}'");

      fNotificationName := aNotificationName;
      fObject := aObject;
      BroadcastManager.subscribe(self) toBroadcast(aNotificationName) &block( (n -> begin
        if assigned(aHandler) then
          dofulfill(nil, 0, nil, nil);
          aHandler();
      end))
    end;

    method dispose; override;
    begin
      BroadcastManager.unsubscribe(self) fromBroadcast(fNotificationName) object(fObject);
    end;

  private

    var fNotificationName: String;
    var fObject: Object;

  end;

  Handler nested in XCTNSNotificationExpectation = public block();

  {$IF DARWIN}
  XCTNSPredicateExpectation = public class(XCTestExpectation)
  assembly or protected

    constructor withPredicate(aPredicate: Foundation.NSPredicate) evaluatedWith(aEvaluatedWith: nullable Foundation.NSObject) handler(aHandler: Handler);
    begin
      inherited constructor withDescription($"Expectation with predicate '{aPredicate}'");

      fPredicate := aPredicate;
      fObject := aEvaluatedWith;
      fHandler := aHandler;
      async begin
          loop begin
          if fDone or check() then
            break;
          Thread.Sleep(500); // miliseconds
        end;
      end;
    end;

    method waitFor(aTimeout: TimeInterval): Boolean; override;
    begin
      if fFulfilled then exit;
      inherited waitFor(aTimeout);
      check();
      fDone := true;
    end;

    property isFulfilled: Boolean read inherited isFulfilled or fPredicate.evaluateWithObject(fObject); override;

  private

    var fPredicate: Foundation.NSPredicate;
    var fObject: nullable Object;
    var fHandler: Handler;
    var fFulfilled := false;
    var fDone := false;

    method check(): Boolean; locked on self;
    begin
      if fFulfilled then
        exit true;
      if fPredicate.evaluateWithObject(fObject) then begin
        fFulfilled := true;
        dofulfill(nil, 0, nil, nil);
        if assigned(fHandler) then
          fHandler();
        result := true;
      end;
    end;

  end;

  Handler nested in XCTNSPredicateExpectation = public block();

  XCTKVOExpectation = public class(XCTestExpectation)
  assembly or protected

    constructor withObject(aObject: not nullable Foundation.NSObject) keyPath(aKeyPath: String) expectedValue(aExpectedValue: nullable Object);
    begin
      inherited constructor withDescription($"Expectation for notificationkey path '{aKeyPath}'");

      fObject := aObject;
      fKeyPath := aKeyPath;
      fExpectedValue := aExpectedValue;
      fHasExpectedValue := true;
      fFulfilled := false;
      fObject.addObserver(self) forKeyPath(aKeyPath) options(0) context(nil);
    end;

    constructor withObject(aObject: not nullable Foundation.NSObject) keyPath(aKeyPath: String) handler(aHandler: XCTKVOExpectation.Handler);
    begin
      inherited constructor withDescription($"Expectation for notificationkey path '{aKeyPath}'");

      fObject := aObject;
      fKeyPath := aKeyPath;
      fHandler := aHandler;
      fFulfilled := false;
      fObject.addObserver(self) forKeyPath(aKeyPath) options(0) context(nil);
    end;

    method waitFor(aTimeout: TimeInterval): Boolean; override;
    begin
      if fFulfilled then exit;
      result := inherited waitFor(aTimeout);
    end;

    property isFulfilled: Boolean read inherited isFulfilled or (fHasExpectedValue and valueMatches); override;

  private

    method observeValueForKeyPath(keyPath: Foundation.NSString) ofObject(object: nullable id) change(aChanges: Foundation.NSDictionary<Foundation.NSString, id>) context(context: ^Void); override; public;
    begin
      check();
    end;

    var fExpectedValue: nullable Object;
    var fHasExpectedValue := false;
    var fObject: not nullable Foundation.NSObject;
    var fKeyPath: String;
    var fHandler: Handler;
    var fFulfilled := false;

    property valueMatches: Boolean read if assigned(fExpectedValue) then fExpectedValue.Equals(fObject.valueForKeyPath(fKeyPath)) else not assigned(fObject.valueForKeyPath(fKeyPath));

    method check(): Boolean; locked on self;
    begin
      if fFulfilled then
        exit true;
      if not fHasExpectedValue or valueMatches then begin
        fFulfilled := true;
        dofulfill(nil, 0, nil, nil);
        if assigned(fHandler) then
          fHandler();
        result := true;
      end;
    end;

  end;

  Handler nested in XCTKVOExpectation = public block();
  {$ENDIF}
{$ENDIF}

end.