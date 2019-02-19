namespace RemObjects.Elements.EUnit.XCTest;

uses
  RemObjects.Elements.EUnit;

type
  XCTPerformanceMetric = public String;

  XCTestCase = public class(Test)
  public

    //
    // Setup/Teardown
    //

    [SwiftName("setup")]
    method Setup; override; empty;

    [SwiftName("tearDown")]
    method Teardown; override;
    begin
      for each b in fTearDownblocks do
        b();
      for each e in fExpectations do begin
        e.dispose();
      end;
    end;

    method addTeardownBlock(aBlock: Block);
    begin
      if not assigned(fTearDownblocks) then
        fTearDownblocks := new List<block>;
      fTearDownblocks.Add(aBlock);
    end;

    var fExpectations: List<XCTestExpectation>; private;
    var fTearDownblocks: List<block>; private;

    //
    //
    //

    // drop, use RTL2
    method ConvertMilisecondsToTimeString(aMS: Double): String; private;
    begin
      var lValue := aMS as Int64;
      var lMilliSeconds := lValue mod 1000;
      var lSeconds := lValue div 1000;
      var lMinutes := lSeconds div 60;
      lSeconds := lSeconds mod 60;
      var lHours := lMinutes div 60;
      lMinutes := lMinutes mod 60;
      result := "";
      if lHours > 0 then
        result := result+lHours.ToString+":";
      if lMinutes > 0 then begin
        var lMinutesString := if length(result) > 0 then Convert.ToString(lMinutes).PadStart(2, '0') else lMinutes.ToString;
        result := result+lMinutesString+":";
      end;
      var lSecondsString := if length(result) > 0 then Convert.ToString(lSeconds).PadStart(2, '0') else lSeconds.ToString;
      result := result+lSecondsString+".";
      result := result+Convert.ToString(lMilliSeconds).PadStart(3, '0');
    end;

    property defaultPerformanceMetrics: List<XCTPerformanceMetric>;

    method measure(aBlock: block);
    begin
      var lStartTimeNet := DateTime.UtcNow;
      try
        writeLn("->");
        aBlock();
      finally
        var lDurationNet := (DateTime.UtcNow-lStartTimeNet).TotalMilliSeconds;
        writeLn($"<- Code took {ConvertMilisecondsToTimeString(lDurationNet)}");
      end;
    end;

    method measureMetrics(aMetris: array of XCTPerformanceMetric) automaticallyStartMeasuring(aAutoStart: Boolean) forBlock(aBlock: block);
    begin
      if aAutoStart then
        startMeasuring;
      try
        aBlock();
      finally
        stopMeasuring();
      end;
    end;

    var fStartTimeNet: nullable DateTime; private;

    method startMeasuring;
    begin
      fStartTimeNet := DateTime.UtcNow;
      writeLn("->");
    end;

    method stopMeasuring;
    begin
      if assigned(fStartTimeNet) then begin
        var lDurationNet := (DateTime.UtcNow-fStartTimeNet).TotalMilliSeconds;
        writeLn($"Code took {ConvertMilisecondsToTimeString(lDurationNet)}");
        fStartTimeNet := nil;
      end;
    end;

    //
    //
    //

    [SwiftName("expectation(description:)")]
    method expectationWithDescription(aDescription: String): XCTestExpectation;
    begin
      result := new XCTestManualExpectation withDescription(aDescription);
      if not assigned(fExpectations) then
        fExpectations := new List<XCTestExpectation>;
      fExpectations.Add(result);
    end;

    [SwiftName("expectation(for:, object:, handler)")]
    method expectationForNotification(aNotificationName: String) object(aObject: nullable Object) handler(aHandler: XCTNSNotificationExpectation.Handler): XCTestExpectation;
    begin
      result := new XCTNSNotificationExpectation withNotification(aNotificationName) object(aObject) handler(aHandler);
      if not assigned(fExpectations) then
        fExpectations := new List<XCTestExpectation>;
      fExpectations.Add(result);
    end;

    {$IF DARWIN}
    [SwiftName("expectation(for:, evaluatedWith:, handler)")]
    method expectationForPredicate(aPredicate: Foundation.NSPredicate) evaluatedWith(aEvaluatedWith: nullable Foundation.NSObject) handler(aHandler: XCTNSPredicateExpectation.Handler): XCTestExpectation;
    begin
      result := new XCTNSPredicateExpectation withPredicate(aPredicate) evaluatedWith(aEvaluatedWith) handler(aHandler);
      if not assigned(fExpectations) then
        fExpectations := new List<XCTestExpectation>;
      fExpectations.Add(result);
    end;

    [SwiftName("keyValueObservingExpectation(for:, keyPath:, expectedValue)")]
    method keyValueObservingExpectationForObject(aObject: Foundation.NSObject) keyPath(aKeyPath: String) expectedValue(aExpectedValue: nullable Object): XCTestExpectation;
    begin
      result := new XCTKVOExpectation withObject(aObject) keyPath(aKeyPath) expectedValue(aExpectedValue);
      if not assigned(fExpectations) then
        fExpectations := new List<XCTestExpectation>;
      fExpectations.Add(result);
    end;

    [SwiftName("keyValueObservingExpectation(for:, keyPath:, handler:)")]
    method keyValueObservingExpectationForObject(aObject: Object) keyPath(aKeyPath: String) handler(handler: XCTKVOExpectation.Handler): XCTestExpectation;
    begin
      result := new XCTKVOExpectation withObject(aObject) keyPath(aKeyPath) handler(handler);
      if not assigned(fExpectations) then
        fExpectations := new List<XCTestExpectation>;
      fExpectations.Add(result);
    end;
    {$ENDIF}

    [SwiftName("wait(for:, timeout:)")]
    method waitForExpectations(aExpectations: List<XCTestExpectation>) timeout(aTimeout: TimeInterval);
    begin
      waitForExpectations(aExpectations) timeout(aTimeout) enforceOrder(false);
    end;

    [SwiftName("wait(for:, timeout:, enforceOrder)")]
    method waitForExpectations(aExpectations: List<XCTestExpectation>) timeout(aTimeout: TimeInterval) enforceOrder(aEnforceOrder: Boolean);
    begin
      if aEnforceOrder then begin
        for each e in aExpectations do begin
          e.waitFor(aTimeout);
          if not e.isFulfilled then
            XCTFail($"Expectation '{e.expectationDescription}' was not fulfilled", nil, 0, nil, nil);
        end;
      end
      else begin
        for each parallel e in aExpectations do begin
          e.waitFor(aTimeout);
          if not e.isFulfilled then
            XCTFail($"Expectation '{e.expectationDescription}' was not fulfilled", nil, 0, nil, nil);
        end;
      end;
    end;

    [SwiftName("waitForExpectations(timeout:, handler:")]
    method waitForExpectationsWithTimeout(aTimeout: TimeInterval) handler(aHandler: XCWaitCompletionHandler);
    begin
      var lException: Exception;
      try
        waitForExpectations(fExpectations) timeout(aTimeout);
      except
        on E: Exception do
          lException := E;
      end;
      if assigned(aHandler) then
        aHandler(lException);
    end;

  end;

  TimeInterval = public Double;

  XCWaitCompletionHandler = public block(aError: nullable Exception);

end.