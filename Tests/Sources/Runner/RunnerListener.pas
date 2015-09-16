namespace EUnit.Tests;

interface

uses
  {$IF COOPER}com.remobjects.elements.linq{$ELSEIF ECHOES}System.Linq{$ELSEIF NOUGAT}RemObjects.Elements.Linq{$ENDIF},
  RemObjects.Elements.EUnit;

type
  RunnerListenerTest = public class (Test) 
  private
    Discovered: ITest;
  public
    method Setup; override;

    method ListenTestsuite;
    method ListenTest;
    method ListenTestcase;
    method ResultTestsuite;
    method ResultTest;
    method ResultTestcase;
  end;

implementation

method RunnerListenerTest.Setup;
begin
  Discovered := Discovery.FromType(typeOf(_SecondEmptyTest)); 
end;

method RunnerListenerTest.ListenTestsuite;
begin
  Discovered := Discovery.FromTypes([typeOf(_EmptyTest), typeOf(_SecondEmptyTest)]);

  var Capture := new ListenerCapture;
  Runner.RunTests(Discovered) withListener(Capture);

  Assert.AreEqual(Capture.Tests.Count, 6);
  var Actual := Capture.Tests[0]; 

  Assert.AreEqual(Actual.Name, "Test suite (2 tests)");
  Assert.AreEqual(Actual.Skip, false);
  Assert.AreEqual(Actual.Kind, TestKind.Suite);
  Assert.AreEqual(Actual.DisplayName, Actual.Name);
  Assert.AreEqual(Actual.Id, "5780EA0B68618EFC");
end;

method RunnerListenerTest.ListenTest;
begin
  var Capture := new ListenerCapture;
  Runner.RunTests(Discovered) withListener(Capture);

  Assert.AreEqual(Capture.Tests.Count, 2);
  var Actual := Capture.Tests[0]; 

  Assert.AreEqual(Actual.Name, "_SecondEmptyTest");
  Assert.AreEqual(Actual.Skip, false);
  Assert.AreEqual(Actual.Kind, TestKind.Test);
  Assert.AreEqual(Actual.DisplayName, Actual.Name);
  Assert.AreEqual(Actual.Id, "FB90E8977E5A8D8E");
end;

method RunnerListenerTest.ListenTestcase;
begin
  Assert.AreEqual(Discovered.Children.Count, 1);
  var Capture := new ListenerCapture;
  Runner.RunTests(Discovered.Children.FirstOrDefault) withListener(Capture);
  
  Assert.AreEqual(Capture.Tests.Count, 1);
  var Actual := Capture.Tests[0]; 

  Assert.AreEqual(Actual.Name, "Public6");
  Assert.AreEqual(Actual.Skip, false);
  Assert.AreEqual(Actual.Kind, TestKind.Testcase);
  Assert.AreEqual(Actual.DisplayName, Actual.Name);
  Assert.AreEqual(Actual.Id, "14CB0215BD99CBCA");
end;

method RunnerListenerTest.ResultTestsuite;
begin
  Discovered := Discovery.FromTypes([typeOf(_EmptyTest), typeOf(_SecondEmptyTest)]);
  Assert.IsNotNil(Discovered);

  var Capture := new ListenerCapture;
  Runner.RunTests(Discovered) withListener(Capture);

  Assert.AreEqual(Capture.Results.Count, 6);
  var Actual := Capture.Results[5]; 

  Assert.AreEqual(Actual.Name, "Test suite (2 tests)");
  Assert.AreEqual(Actual.DisplayName, Actual.Name);
  Assert.AreEqual(Actual.Id, "5780EA0B68618EFC");
  Assert.AreEqual(Actual.Message, "");
  Assert.AreEqual(Actual.State, TestState.Succeeded);
  Assert.IsNotNil(Actual.Test);
  Assert.AreEqual(Actual.Test.Id, Actual.Id);
end;

method RunnerListenerTest.ResultTest;
begin
  var Capture := new ListenerCapture;
  Runner.RunTests(Discovered) withListener(Capture);

  Assert.AreEqual(Capture.Results.Count, 2);
  var Actual := Capture.Results[1]; 

  Assert.AreEqual(Actual.Name, "_SecondEmptyTest");
  Assert.AreEqual(Actual.DisplayName, Actual.Name);
  Assert.AreEqual(Actual.Id, "FB90E8977E5A8D8E");
  Assert.AreEqual(Actual.Message, "");
  Assert.AreEqual(Actual.State, TestState.Succeeded);
  Assert.IsNotNil(Actual.Test);
  Assert.AreEqual(Actual.Test.Id, Actual.Id);
end;

method RunnerListenerTest.ResultTestcase;
begin
  Assert.AreEqual(Discovered.Children.Count, 1);
  var Capture := new ListenerCapture;
  Runner.RunTests(Discovered.Children.FirstOrDefault) withListener(Capture);

  Assert.AreEqual(Capture.Results.Count, 1);
  var Actual := Capture.Results[0]; 

  Assert.AreEqual(Actual.Name, "Public6");
  Assert.AreEqual(Actual.DisplayName, Actual.Name);
  Assert.AreEqual(Actual.Id, "14CB0215BD99CBCA");
  Assert.AreEqual(Actual.Message, "");
  Assert.AreEqual(Actual.State, TestState.Succeeded);
  Assert.IsNotNil(Actual.Test);
  Assert.AreEqual(Actual.Test.Id, Actual.Id);
end;

end.