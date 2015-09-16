namespace EUnit.Tests;

interface

uses
  RemObjects.Elements.EUnit;

type
  _RunnerFailureTest = public class (Test)
  public
    method Fail1;
    method FailAssert;
  end;

  _SetupFailed = public class (Test)
  public
    class var WasCalled: Boolean := false;
    method Setup; override;
    method Test;
  end;

  _TeardownFailed = public class (Test)
  public
    class var WasCalled: Boolean := false;
    method Test;
    method Teardown; override;
  end;

  _SetupTestFailed = public class (Test)
  public
    method SetupTest; override;
    method ShouldBeUntested1; empty;
    method ShouldBeUntested2; empty;
  end;

  _TeardownTestFailed = public class (Test)
  public
    method TeardownTest; override;
    method ShouldPass1; empty;
    method ShouldPass2; empty;
  end;

implementation

method _SetupFailed.Setup;
begin
  raise new InvalidOperationException("Setup Failed");
end;

method _SetupFailed.Test;
begin
  WasCalled := true;
end;

method _RunnerFailureTest.Fail1;
begin
  raise new ArgumentException("Param", "Error");
end;

method _RunnerFailureTest.FailAssert;
begin
  Assert.AreEqual(true, false);
end;

method _TeardownFailed.Teardown;
begin
  raise new InvalidOperationException("Teardown Failed");
end;

method _TeardownFailed.Test;
begin
  WasCalled := true;
end;

method _SetupTestFailed.SetupTest;
begin
  raise new InvalidOperationException("SetupTest Failed");
end;

method _TeardownTestFailed.TeardownTest;
begin
  raise new InvalidOperationException("TeardownTest Failed");
end;

end.