namespace RemObjects.Elements.EUnit;

interface

type
  IDiscovery = public interface
    method Discover: ITest;
    {$IF NOT ISLAND}
    method DiscoverAsync(OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
    {$ENDIF}
  end;

implementation
end.