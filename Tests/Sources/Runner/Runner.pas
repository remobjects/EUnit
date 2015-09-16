namespace EUnit.Tests;

interface

uses
  {$IF COOPER}com.remobjects.elements.linq{$ELSEIF ECHOES}System.Linq{$ELSEIF NOUGAT}RemObjects.Elements.Linq{$ENDIF},
  RemObjects.Elements.EUnit;

type
  RunnerTest = public class (Test)
  private
    Discovered: ITest;
  public
    method Setup; override;

    method RunSuite;
    method RunTest;
    method RunTestcase;
    method &Skip;
    method RunSuiteAsync;
    method RunTestAsync;
    method RunTestcaseAsync;
    method AsyncCancel;
    method RunAbstract;
  end;

  _SlowTest = public class (Test)
  private
    method FindPrime(N: Integer): Int64;
  public
    method Slow;
    method Slow1;
    method Slow2;
    method Slow3;
  end;

implementation

method RunnerTest.Setup;
begin
  Discovered := Discovery.FromType(typeOf(_SecondEmptyTest)); 
end;

method RunnerTest.RunSuite;
begin
  Discovered := Discovery.FromTypes([typeOf(_EmptyTest), typeOf(_SecondEmptyTest)]);
  Assert.IsNotNil(Discovered);
  var Actual := Runner.RunTests(Discovered);

  Assert.AreEqual(Actual.Name, "Test suite (2 tests)");
  Assert.AreEqual(Actual.DisplayName, Actual.Name);
  Assert.AreEqual(Actual.Id, "5780EA0B68618EFC");
  Assert.AreEqual(Actual.Message, "");
  Assert.AreEqual(Actual.State, TestState.Succeeded);
  Assert.IsNotNil(Actual.Test);
  Assert.AreEqual(Actual.Test.Id, Actual.Id);
  Assert.IsTrue(Actual.Children.All(item -> item.State = TestState.Succeeded));
end;

method RunnerTest.RunTest;
begin
  var Actual := Runner.RunTests(Discovered);
  
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Name, "_SecondEmptyTest");
  Assert.AreEqual(Actual.DisplayName, Actual.Name);
  Assert.AreEqual(Actual.Id, "FB90E8977E5A8D8E");
  Assert.AreEqual(Actual.Message, "");
  Assert.AreEqual(Actual.State, TestState.Succeeded);
  Assert.IsNotNil(Actual.Test);
  Assert.AreEqual(Actual.Test.Id, Actual.Id);
end;

method RunnerTest.RunTestcase;
begin
  var Actual := Runner.RunTests(Discovered.Children.FirstOrDefault);
  
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Name, "Public6");
  Assert.AreEqual(Actual.DisplayName, Actual.Name);
  Assert.AreEqual(Actual.Id, "14CB0215BD99CBCA");
  Assert.AreEqual(Actual.Message, "");
  Assert.AreEqual(Actual.State, TestState.Succeeded);
  Assert.IsNotNil(Actual.Test);
  Assert.AreEqual(Actual.Test.Id, Actual.Id);
end;

method RunnerTest.Skip;
begin
  Discovered := Discovery.FromTypes([typeOf(_EmptyTest), typeOf(_SecondEmptyTest)]);  
  Assert.IsNotNil(Discovered);
  Discovered.Children.FirstOrDefault.Skip := true;
  var Actual := Runner.RunTests(Discovered);

  Assert.AreEqual(Actual.Name, "Test suite (2 tests)");
  Assert.AreEqual(Actual.DisplayName, Actual.Name);
  Assert.AreEqual(Actual.Id, "5780EA0B68618EFC");
  Assert.AreEqual(Actual.Message, "");
  Assert.AreEqual(Actual.State, TestState.Succeeded);
  Assert.IsNotNil(Actual.Test);
  Assert.AreEqual(Actual.Test.Id, Actual.Id);
  Assert.IsFalse(Actual.Children.All(item -> item.State = TestState.Succeeded));

  Actual := Actual.Children.FirstOrDefault;
  Assert.AreEqual(Actual.Name, "_EmptyTest");
  Assert.AreEqual(Actual.DisplayName, Actual.Name);
  Assert.AreEqual(Actual.Id, "D762A834F821EB94");
  Assert.AreEqual(Actual.Message, "Skipped");
  Assert.AreEqual(Actual.State, TestState.Skipped);
  Assert.IsNotNil(Actual.Test);
  Assert.AreEqual(Actual.Test.Id, Actual.Id);
end;

method RunnerTest.RunSuiteAsync;
begin
  Discovered := Discovery.FromTypes([typeOf(_EmptyTest), typeOf(_SecondEmptyTest)]);
  Assert.IsNotNil(Discovered);
  var Token := TokenProvider.CreateAwaitToken;
  var WasExecuted: Boolean := false;

  Runner.RunTestsAsync(Discovered) completionHandler(item -> begin
    Token.Run(->begin
      Assert.AreEqual(item.Name, "Test suite (2 tests)");
      Assert.AreEqual(item.DisplayName, item.Name);
      Assert.AreEqual(item.Id, "5780EA0B68618EFC");
      Assert.AreEqual(item.Message, "");
      Assert.AreEqual(item.State, TestState.Succeeded);
      Assert.IsNotNil(item.Test);
      Assert.AreEqual(item.Test.Id, item.Id);
      Assert.IsTrue(item.Children.All(child -> child.State = TestState.Succeeded));
      WasExecuted := true;
    end);
  end);

  Token.WaitFor;
  Assert.IsTrue(WasExecuted);
end;

method RunnerTest.RunTestAsync;
begin
  var Token := TokenProvider.CreateAwaitToken;
  var WasExecuted: Boolean := false;

  Runner.RunTestsAsync(Discovered) completionHandler(item -> begin
    Token.Run(->begin
      Assert.IsNotNil(item);
      Assert.AreEqual(item.Name, "_SecondEmptyTest");
      Assert.AreEqual(item.DisplayName, item.Name);
      Assert.AreEqual(item.Id, "FB90E8977E5A8D8E");
      Assert.AreEqual(item.Message, "");
      Assert.AreEqual(item.State, TestState.Succeeded);
      Assert.IsNotNil(item.Test);
      Assert.AreEqual(item.Test.Id, item.Id);
      WasExecuted := true;
    end);
  end);

  Token.WaitFor;
  Assert.IsTrue(WasExecuted);
end;

method RunnerTest.RunTestcaseAsync;
begin
  var Token := TokenProvider.CreateAwaitToken;
  var WasExecuted: Boolean := false;

  Runner.RunTestsAsync(Discovered.Children.FirstOrDefault) completionHandler(item -> begin  
    Token.Run(->begin
      Assert.IsNotNil(item);
      Assert.AreEqual(item.Name, "Public6");
      Assert.AreEqual(item.DisplayName, item.Name);
      Assert.AreEqual(item.Id, "14CB0215BD99CBCA");
      Assert.AreEqual(item.Message, "");
      Assert.AreEqual(item.State, TestState.Succeeded);
      Assert.IsNotNil(item.Test);
      Assert.AreEqual(item.Test.Id, item.Id);
      WasExecuted := true;
    end);
  end);

  Token.WaitFor;
  Assert.IsTrue(WasExecuted);
end;

method RunnerTest.AsyncCancel;
begin
  Discovered := Discovery.FromType(typeOf(_SlowTest));
  Assert.IsNotNil(Discovered);
  var Lock := new ExceptionLock;
  var Token := TokenProvider.CreateCancelationToken;
  Assert.IsNotNil(Token);
  Assert.IsFalse(Token.Canceled);

  Runner.RunTestsAsync(Discovered) completionHandler(item -> begin
    try
      Assert.AreEqual(item.Name, "_SlowTest");
      Assert.AreEqual(item.Children.Count, 4);
      Assert.IsTrue(item.Children.Any(child -> child.State = TestState.Untested));
      Lock.Signal;
    except
      on E: Exception do
        Lock.Signal(E);
    end;
  end) withListener(nil) cancelationToken(Token);

  Token.Cancel;
  Lock.WaitFor;  
end;

method RunnerTest.RunAbstract;
begin
  Discovered := Discovery.FromTypes([typeOf(_AbstractBaseTest), typeOf(_NonAbstractTest)]);
  var Tested := Runner.RunTests(Discovered);
  Assert.AreEqual(Tested.State, TestState.Succeeded);
end;

method _SlowTest.Slow;
begin
  FindPrime(100);
end;

method _SlowTest.FindPrime(N: Integer): Int64;
begin
  var Count: Integer := 0;
  var a: Int64 := 2;

  while (Count < N) do begin
    var b: Int64 := 2;
    var Prime := 1;

    while (b * b <= a) do begin
      if (a mod b) = 0 then begin
        prime := 0;
        break;
      end;

      inc(b);
    end;

    if Prime > 0 then
      inc(Count);

    inc(a);
  end;

  dec(a);
  exit a;
end;

method _SlowTest.Slow1;
begin
  FindPrime(100);
end;

method _SlowTest.Slow2;
begin
  FindPrime(100);
end;

method _SlowTest.Slow3;
begin
  FindPrime(100);
end;

end.