// Positive guard: the public ExpectedException test must remain discoverable and run its expected-exception check.
// Negative regression guard: private, protected, assembly, static, and generated lambda methods must not become tests.
namespace EUnit.Tests;

uses
  RemObjects.Elements.RTL,
  RemObjects.Elements.EUnit;

type
  IslandDiscoveryFixture = public class(Test)
  private

    method PrivateHelper;
    begin
      raise new Exception('Private helper must not run as a test.');
    end;

  protected

    method ProtectedHelper;
    begin
      raise new Exception('Protected helper must not run as a test.');
    end;

  assembly

    method AssemblyHelper;
    begin
      raise new Exception('Assembly helper must not run as a test.');
    end;

  public

    class method StaticHelper;
    begin
      raise new Exception('Static helper must not run as a test.');
    end;

    method ExpectedException;
    begin
      Check.Throws(() -> begin
        raise new Exception('Expected exception from a generated lambda.');
      end);
    end;

  end;

begin
  var lTests := Discovery.FromType(typeOf(IslandDiscoveryFixture));
  var lCount := 0;
  for each lTest in lTests.Children do begin
    inc(lCount);
    if lTest.Name <> 'ExpectedException' then begin
      writeLn('Unexpected test discovered: ' + lTest.Name);
      exit 1;
    end;
  end;
  if lCount <> 1 then begin
    writeLn('Expected exactly one public instance test, got ' + lCount.ToString);
    exit 1;
  end;
  result := Runner.RunTests(lTests) withListener(Runner.DefaultListener).ExitCode;
end.
