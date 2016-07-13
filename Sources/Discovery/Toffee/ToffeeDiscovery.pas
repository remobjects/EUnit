namespace RemObjects.Elements.EUnit;

interface

uses
  Sugar.Collections;

type
  Discovery = public partial static class
  public
    method FromModule: ITest;
    method FromModuleAsync(OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
  end;

implementation

class method Discovery.FromModule: ITest;
begin
  exit new ModuleDiscovery().Discover;
end;

class method Discovery.FromModuleAsync(OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
begin
  new ModuleDiscovery().DiscoverAsync(OnCompleted, Token);
end;

end.
