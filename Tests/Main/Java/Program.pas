namespace Cooper.Tests;

interface

uses
  RemObjects.Elements.EUnit,
  java.util;

type
  ConsoleApp = class
  public
    class method Filter(Item: ITest);
    class method Main(args: array of String);
  end;

implementation

class method ConsoleApp.Main(args: array of String);
begin
  try
    var TestItems := Discovery.DiscoverTests;
    Filter(TestItems);
    Runner.RunTests(TestItems) withListener(new ConsoleTestListener);
  except
    on E: Exception do
      writeLn("Unable to perform test: " + E.Message); 
  end;

  writeLn("Press any key to exit."); 
  system.in.read;
end;

class method ConsoleApp.Filter(Item: ITest);
begin
  if (Item.Kind = TestKind.Test) and (Item.Name.StartsWith("_")) then
    Item.Skip := true;

  for child in Item.Children do
    Filter(child);
end;

end.
