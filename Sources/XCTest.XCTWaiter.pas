namespace RemObjects.Elements.EUnit.XCTest;

{$IF NOT WEBASSEMBLY}
type
  XCTWaiter = public class
  private
  protected
  public

    constructor withDelegate(aDelegate: nullable IXCTWaiterDelegate);
    begin

    end;

    property &delegate: nullable IXCTWaiterDelegate;

    [SwiftName("wait(for:, timeout:)")]
    method waitForExpectations(expectations: List<XCTestExpectation>) timeout(seconds: TimeInterval): XCTWaiterResult;
    begin
      waitForExpectations(expectations) timeout(seconds) enforceOrder(false);
    end;

    [SwiftName("wait(for:, timeout:, enforceOrder:)")]
    method waitForExpectations(expectations: List<XCTestExpectation>) timeout(seconds: TimeInterval) enforceOrder(enforceOrderOfFulfillment: Boolean): XCTWaiterResult;
    begin
      if enforceOrderOfFulfillment then begin

      end
      else begin
        result := &Result.completed;
        //for each parallel e in expectations do
          //if not e.waitFor(seconds) then result := &Result.timedOut;
      end;
    end;

    [SwiftName("wait(for:, timeout:)")]
    class method waitForExpectations(expectations: List<XCTestExpectation>) timeout(seconds: TimeInterval): XCTWaiterResult;
    begin
      //result := new XCTWaiter().waitForExpectations(expectations) timeout(seconds);
    end;

    [SwiftName("wait(for:, timeout:, enforceOrder:)")]
    class method waitForExpectations(expectations: List<XCTestExpectation>) timeout(seconds: TimeInterval) enforceOrder(enforceOrderOfFulfillment: Boolean): XCTWaiterResult;
    begin
      //result := new XCTWaiter().waitForExpectations(expectations) timeout(seconds) enforceOrder(enforceOrderOfFulfillment);
    end;

  end;

  XCTWaiterDelegate = public IXCTWaiterDelegate;
  IXCTWaiterDelegate = public interface

  end;

  &Result nested in XCTWaiter = public enum (
    XCTWaiterResultCompleted = 0,
    XCTWaiterResultTimedOut = 1,
    XCTWaiterResultIncorrectOrder = 2,
    XCTWaiterResultInvertedFulfillment = 3,
    XCTWaiterResultInterrupted = 4,
    completed = 0,
    timedOut = 1,
    incorrectOrder = 2,
    invertedFulfillment = 3,
    interrupted = 4);
  );

  XCTWaiterResult = public XCTWaiter.Result;

{$ENDIF}

end.