namespace EUnit.Tests;

interface

uses
  System.Linq,
  RemObjects.Elements.EUnit;

type
  ConsoleApp = class
  public
    class method FilterTests(Item: ITest);
    class method Main(args: array of String);
  end;

implementation


class method ConsoleApp.Main(args: array of String);
begin
  try
    var TestItems := Discovery.DiscoverTests;
    FilterTests(TestItems);
    Runner.RunTests(TestItems) withListener(new ConsoleTestListener);
  except
    on E: Exception do
      Console.WriteLine("Unable to perform test: " + E.Message); 
  end;

  Console.Write("Press any key to exit."); 
  Console.ReadKey;
end;

class method ConsoleApp.FilterTests(Item: ITest);
begin
  if (Item.Kind = TestKind.Test) and (Item.Name.StartsWith("_")) then
    Item.Skip := true;

  for child in Item.Children do
    FilterTests(child);
end;

end.
