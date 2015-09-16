namespace Nougat.Tests.iOS;

interface

uses
  RemObjects.Elements.EUnit,
  UIKit;

type
  Program = public static class
  public
    method Main(argc: Integer; argv: ^^AnsiChar): Int32;
    method Filter(Item: ITest);
  end;

implementation

method Program.Filter(Item: ITest);
begin
  if (Item.Kind = TestKind.Test) and (Item.Name.StartsWith("_")) then
    Item.Skip := true;

  for child in Item.Children do
    Filter(child);
end;

method Program.Main(argc: Integer; argv: ^^AnsiChar): Int32;
begin
  try
    var TestItems := Discovery.FromModule;
    Filter(TestItems);

    var TestResults := Runner.Run(TestItems) withListener(new ConsoleTestListener);

    var Writer := new ConsoleWriter(TestResults);
    Writer.WriteFull;
    Writer.WriteLine("===================================================");
    Writer.WriteSummary;
    Writer.OutputToConsole;
  except
    on E: Exception do
      writeLn("Unable to perform test: " + E.reason);
  end;
end;

end.