namespace RemObjects.Elements.EUnit;

interface

uses
  Sugar.Collections;

type
  Discovery = public partial static class
  public
    method FromContext(Value: android.content.Context): ITest;
    method FromContextAsync(Value: android.content.Context; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
  end;

implementation

class method Discovery.FromContext(Value: android.content.Context): ITest;
begin
  exit new ContextDiscovery(Value).Discover;
end;

class method Discovery.FromContextAsync(Value: android.content.Context; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
begin
  new ContextDiscovery(Value).DiscoverAsync(OnCompleted, Token);
end;

end.