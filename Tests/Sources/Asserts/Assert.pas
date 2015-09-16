namespace EUnit.Tests;

interface

uses
  RemObjects.Elements.EUnit;

type
  AssertTest = public class (Test) 
  public
    method Fail;
  end;

implementation

method AssertTest.Fail;
begin
  Assert.Throws(->Assert.Fail("Error"));
  Assert.Throws(->Assert.Fail("Error"), typeOf(AssertException));
  var Ex := Assert.Catch(->Assert.Fail("Error"));
  Assert.IsNotNil(Ex);
  Assert.AreEqual(Ex.{$IF NOUGAT}reason{$ELSE}Message{$ENDIF}, "Error");
 
  Ex := Assert.Catch(->Assert.Fail(nil));
  Assert.IsNotNil(Ex);
  Assert.AreEqual(Ex.{$IF NOUGAT}reason{$ELSE}Message{$ENDIF}, "Unknown failure");
end;

end.