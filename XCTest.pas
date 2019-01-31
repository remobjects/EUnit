namespace RemObjects.Elements.EUnit.XCTest;

uses
  RemObjects.Elements.EUnit;

type
  XCTestCase = public Test;

//method FormatMessage(aMessage: String; params aParameters: array of Object): String; private;
//begin
  //if length(aParameters) > 0 then
    //result := String.Format(aMessage, aParameters)
  //else
    //result := aMessage;
//end;

//
// Booleans
//

method XCTAssert(Expression: Boolean; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.IsTrue(Expression, aMessage, aFile, aLine, aClass, aMethod);
end;

method XCTAssertTrue(Expression: Boolean; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.IsTrue(Expression, aMessage, aFile, aLine, aClass, aMethod);
end;

method XCTAssertFalse(Expression: Boolean; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.IsFalse(Expression, aMessage, aFile, aLine, aClass, aMethod);
end;

//
// Nil
//

method XCTAssertNil(Expression: Object; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.IsNil(Expression, aMessage, aFile, aLine, aClass, aMethod);
end;

method XCTAssertNotNil(Expression: Object; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.IsNotNil(Expression, aMessage, aFile, aLine, aClass, aMethod);
end;

method XCTAssertNil(Expression: Pointer; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.IsTrue(not assigned(Expression), coalesce(aMessage, AssertMessages.ObjectIsNotNil), aFile, aLine, aClass, aMethod);
end;

method XCTAssertNotNil(Expression: Pointer; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.IsTrue(assigned(Expression), coalesce(aMessage, AssertMessages.ObjectIsNil), aFile, aLine, aClass, aMethod);
end;

//
// Equality
//

method XCTAssertEqualObjects(Actual, Expected: Object; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.AreEqual(Actual, Expected, aMessage, aFile, aLine, aClass, aMethod);
end;

method XCTAssertNotEqualObjects(Actual, Expected: Object; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.AreNotEqual(Actual, Expected, aMessage, aFile, aLine, aClass, aMethod);
end;

method XCTAssertEqual(Actual, Expected: Object; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.IsTrue(Actual = Expected, coalesce(aMessage, String.Format(AssertMessages.XCNotEqual, Actual, Expected)), aFile, aLine, aClass, aMethod);
end;

method XCTAssertNotEqual(Actual, Expected: Object; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.IsTrue(Actual ≠ Expected, coalesce(aMessage, String.Format(AssertMessages.XCEqual, Actual, Expected)), aFile, aLine, aClass, aMethod);
end;

method XCTAssertEqual(Actual, Expected: Int64; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.AreEqual(Actual, Expected, aMessage, aFile, aLine, aClass, aMethod);
end;

method XCTAssertNotEqual(Actual, Expected: Int64; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.AreNotEqual(Actual, Expected, aMessage, aFile, aLine, aClass, aMethod);
end;

method XCTAssertEqual(Actual, Expected: Double; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.AreEqual(Actual, Expected, aMessage, aFile, aLine, aClass, aMethod);
end;

method XCTAssertNotEqual(Actual, Expected: Double; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.AreNotEqual(Actual, Expected, aMessage, aFile, aLine, aClass, aMethod);
end;

//
// Less/Greater
//

method XCTAssertGreaterThan(Actual, Expected: Int64; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.Greater(Actual, Expected, aFile, aLine, aClass, aMethod);
end;

method XCTAssertGreaterThanOrEqual(Actual, Expected: Int64; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.GreaterOrEquals(Actual, Expected, aFile, aLine, aClass, aMethod);
end;

method XCTAssertLessThan(Actual, Expected: Int64; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.Less(Actual, Expected, aFile, aLine, aClass, aMethod);
end;

method XCTAssertLessThanOrEqual(Actual, Expected: Int64; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.LessOrEquals(Actual, Expected, aFile, aLine, aClass, aMethod);
end;

method XCTAssertGreaterThan(Actual, Expected: Double; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.Greater(Actual, Expected, aFile, aLine, aClass, aMethod);
end;

method XCTAssertGreaterThanOrEqual(Actual, Expected: Double; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.GreaterOrEquals(Actual, Expected, aFile, aLine, aClass, aMethod);
end;

method XCTAssertLessThan(Actual, Expected: Double; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.Less(Actual, Expected, aFile, aLine, aClass, aMethod);
end;

method XCTAssertLessThanOrEqual(Actual, Expected: Double; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
begin
  Assert.LessOrEquals(Actual, Expected, aFile, aLine, aClass, aMethod);
end;

//
//
//

//method XCTAssertThrows(aExpression: Object; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
//begin
  ////Assert.Throws(Message);
//end;

//method XCTAssertThrowsSpecific(aExpression: Object; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
//begin
  ////Assert.Throws(Message);
//end;

//method XCTAssertThrowsSpecificNamed(aExpression: Object; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
//begin
  ////Assert.Throws(Message);
//end;

//method XCTAssertNoThrow(aExpression: Object; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
//begin
  ////Assert.Throws(Message);
//end;

//method XCTAssertNoThrowSpecific(aExpression: Object; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
//begin
  ////Assert.Throws(Message);
//end;

//method XCTAssertNoThrowSpecificNamed(aExpression: Object; aMessage: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); public;
//begin
  ////Assert.Throws(Message);
//end;

method XCTFail(Message: String);
begin
  Assert.Fail(Message);
end;

end.