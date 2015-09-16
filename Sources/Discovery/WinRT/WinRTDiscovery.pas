namespace RemObjects.Elements.EUnit;

interface

uses
  Sugar.Collections;

type
  Discovery = public partial static class
  public
    method FromAssembly(Value: System.Reflection.&Assembly): ITest;
    method FromAssemblyAsync(Value: System.Reflection.&Assembly; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
    method FromAssemblies(Value: sequence of System.Reflection.&Assembly): ITest;
    method FromAssembliesAsync(Value: sequence of System.Reflection.&Assembly; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
  end;

implementation

class method Discovery.FromAssemblies(Value: sequence of System.Reflection.Assembly): ITest;
begin
  exit new AssemblyDiscovery(Value).Discover;
end;

class method Discovery.FromAssembliesAsync(Value: sequence of System.Reflection.Assembly; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken);
begin
  new AssemblyDiscovery(Value).DiscoverAsync(OnCompleted, Token);
end;

class method Discovery.FromAssembly(Value: System.Reflection.Assembly): ITest;
begin
  ArgumentNilException.RaiseIfNil(Value, "Value");
  exit new AssemblyDiscovery([Value]).Discover;
end;

class method Discovery.FromAssemblyAsync(Value: System.Reflection.Assembly; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken);
begin
  ArgumentNilException.RaiseIfNil(Value, "Value");
  new AssemblyDiscovery([Value]).DiscoverAsync(OnCompleted, Token);
end;

end.