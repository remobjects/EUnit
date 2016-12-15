namespace RemObjects.Elements.EUnit;

interface

type
  Discovery = public partial static class
  public
    method FromPackage(Value: Package): ITest;
    method FromPackageAsync(Value: Package; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
  end;

implementation

class method Discovery.FromPackage(Value: Package): ITest;
begin
  exit new PackageDiscovery(Value).Discover;
end;

class method Discovery.FromPackageAsync(Value: Package; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
begin
  new PackageDiscovery(Value).DiscoverAsync(OnCompleted, Token);
end;

end.