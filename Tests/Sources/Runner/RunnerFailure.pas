namespace EUnit.Tests;

interface

uses
  {$IF COOPER}com.remobjects.elements.linq{$ELSEIF ECHOES}System.Linq{$ELSEIF NOUGAT}RemObjects.Elements.Linq{$ENDIF},
  RemObjects.Elements.EUnit;

type
  RunnerFailureTest = public class (Test)
  public
    method FailedTestcase;
    method FailedTest;
    method FailedAssert;
    method FailedSetup;
    method FailedTeardown;
    method FailedTestSetup;
    method FailedTestTeardown;
  end;

implementation

method RunnerFailureTest.FailedTestcase;
begin
  var Discovered := Discovery.FromType(typeOf(_RunnerFailureTest));
  Assert.IsNotNil(Discovered);
  var Actual := Runner.RunTests(Discovered);

  Assert.IsNotNil(Actual);  
  Actual := Actual.Children.First(item -> item.Id = "4343095047368937");  
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Name, "Fail1");
  Assert.AreEqual(Actual.Id, "4343095047368937");
  Assert.AreEqual(Actual.Message, "[ArgumentException]: Error");
  Assert.AreEqual(Actual.State, TestState.Failed);
end;

method RunnerFailureTest.FailedTest;
begin
  var Discovered := Discovery.FromType(typeOf(_RunnerFailureTest));
  Assert.IsNotNil(Discovered);
  var Actual := Runner.RunTests(Discovered);

  Assert.AreEqual(Actual.Name, "_RunnerFailureTest");
  Assert.AreEqual(Actual.Id, "4A7E7BE6C11DF634");
  Assert.AreEqual(Actual.Message, "One or more test failed");
  Assert.AreEqual(Actual.State, TestState.Failed);
end;

method RunnerFailureTest.FailedAssert;
begin
  var Discovered := Discovery.FromType(typeOf(_RunnerFailureTest));
  Assert.IsNotNil(Discovered);
  var Actual := Runner.RunTests(Discovered);

  Assert.IsNotNil(Actual);  
  Actual := Actual.Children.First(item -> item.Id = "62D385C73E9F29DE");  
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Name, "FailAssert");
  Assert.AreEqual(Actual.Id, "62D385C73E9F29DE");
  Assert.AreEqual(Actual.Message, "Expected: <False> but was: <True>", true);
  Assert.AreEqual(Actual.State, TestState.Failed);
end;

method RunnerFailureTest.FailedSetup;
begin
  _SetupFailed.WasCalled := false;
  var Discovered := Discovery.FromType(typeOf(_SetupFailed));
  Assert.IsNotNil(Discovered);
  var Actual := Runner.RunTests(Discovered);

  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Children.Count, 1);
  Actual := Actual.Children.FirstOrDefault;
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Name, "Test");  
  Assert.AreEqual(Actual.State, TestState.Failed);
  Assert.AreEqual(Actual.Message, "[InvalidOperationException]: Setup Failed");  
  Assert.AreEqual(_SetupFailed.WasCalled, false);
end;

method RunnerFailureTest.FailedTeardown;
begin
  _TeardownFailed.WasCalled := false;
  var Discovered := Discovery.FromType(typeOf(_TeardownFailed));
  Assert.IsNotNil(Discovered);
  var Actual := Runner.RunTests(Discovered);

  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Children.Count, 1);
  Actual := Actual.Children.FirstOrDefault;
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Name, "Test");  
  Assert.AreEqual(Actual.State, TestState.Failed);
  Assert.AreEqual(Actual.Message, "[InvalidOperationException]: Teardown Failed");  
  Assert.AreEqual(_TeardownFailed.WasCalled, true);
end;

method RunnerFailureTest.FailedTestSetup;
begin
  var Discovered := Discovery.FromType(typeOf(_SetupTestFailed));
  Assert.IsNotNil(Discovered);
  
  var Actual := Runner.RunTests(Discovered);
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.State, TestState.Failed);

  for child in Actual.Children do
    Assert.AreEqual(child.State, TestState.Untested);
end;

method RunnerFailureTest.FailedTestTeardown;
begin
  var Discovered := Discovery.FromType(typeOf(_TeardownTestFailed));
  Assert.IsNotNil(Discovered);
  
  var Actual := Runner.RunTests(Discovered);
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.State, TestState.Failed);

  for child in Actual.Children do
    Assert.AreEqual(child.State, TestState.Succeeded);
end;

end.