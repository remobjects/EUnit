namespace RemObjects.Elements.EUnit;

interface

type
  Discovery = public partial static class
  public
    method FromModule: ITest;
    {$IF NOT ISLAND}
    method FromModuleAsync(OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
    {$ENDIF}
  end;

implementation

class method Discovery.FromModule: ITest;
begin
  exit new ModuleDiscovery().Discover;
end;

{$IF NOT ISLAND}
class method Discovery.FromModuleAsync(OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
begin
  new ModuleDiscovery().DiscoverAsync(OnCompleted, Token);
end;
{$ENDIF}

end.