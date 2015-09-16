namespace Nougat.Tests.OSX;

interface

uses
  RemObjects.Elements.EUnit,
  Foundation;

type
  Program = public static class
  public
    method Main(aArguments: array of String): Int32;
    method Filter(Item: ITest);
  end;

implementation

method Program.Main(aArguments: array of String): Int32;
begin  
  try
    var TestItems := Discovery.DiscoverTests;
    //Discovery.FromModule;
    Filter(TestItems);

    var TestResults := Runner.RunTests(TestItems);

    var Writer := new ConsoleWriter(TestResults);
    Writer.WriteFull;
    Writer.WriteLine("===================================================");
    Writer.WriteSummary;
    Writer.OutputToConsole;
    NSThread.sleepForTimeInterval(1);
    NSLog("");
  except
    on E: Exception do
      writeLn("Unable to perform test: " + E.reason);
  end;
end;

method Program.Filter(Item: ITest);
begin
  if (Item.Kind = TestKind.Test) and (Item.Name.StartsWith("_")) then
    Item.Skip := true;

  for child in Item.Children do
    Filter(child);
end;

end.
