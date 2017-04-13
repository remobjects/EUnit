namespace RemObjects.Elements.EUnit;

interface

type
  ConsoleWriter = public class (StringWriter)
  public
    method OutputToConsole;
  end;

implementation

method ConsoleWriter.OutputToConsole;
begin
  {$IFNDEF NETFX_CORE}
  writeLn(self.Output);
  {$ELSE}
  System.Diagnostics.Debug.WriteLine(self.Output);
  {$ENDIF}
end;

end.