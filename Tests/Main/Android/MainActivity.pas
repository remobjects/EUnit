namespace cooper.tests.android;

interface

uses
  java.util,
  android.app,
  RemObjects.Elements.eunit,
  android.content,
  android.os,
  android.util,
  android.view,
  android.widget;

type
  MainActivity = public class(Activity)
  public
    method onCreate(savedInstanceState: Bundle); override;
    method Filter(Item: ITest);
  end;

implementation

method MainActivity.Filter(Item: ITest);
begin
  if (Item.Kind = TestKind.Test) and (Item.Name.StartsWith("_")) then
    Item.Skip := true;

  for child in Item.Children do
    Filter(child);
end;

method MainActivity.onCreate(savedInstanceState: Bundle);
begin
  inherited;
  // Set our view from the "main" layout resource
  ContentView := R.layout.main;

  try
    var TestItems := Discovery.DiscoverTests(self);
    //Discovery.FromContext(self);
    Filter(TestItems);
    var TestResults := Runner.Run(TestItems);

    var Writer := new ConsoleWriter(TestResults);
    Writer.WriteFull;
    Writer.WriteLine("===================================================");
    Writer.WriteSummary;
    Writer.OutputToConsole;
  except
    on E: Exception do
      writeLn("Unable to perform test: " + E.Message); 
  end;

  self.finish;
end;

end.
