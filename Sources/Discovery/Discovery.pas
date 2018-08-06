namespace RemObjects.Elements.EUnit;

interface

uses
  {$IF NETFX_CORE}System.Reflection,{$ENDIF}
  RemObjects.Elements.EUnit.Reflections;

type
  Discovery = public partial static class
  public
    method FromObject(Value: Object): ITest;
    method FromObjects(Value: sequence of Object): ITest;
    method FromType(Value: NativeType): ITest;
    method FromTypes(Value: sequence of NativeType): ITest;
    {$IF NOT ISLAND}
    method FromObjectAsync(Value: Object; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
    method FromObjectsAsync(Value: sequence of Object; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
    method FromTypeAsync(Value: NativeType; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
    method FromTypesAsync(Value: sequence of NativeType; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
    {$ENDIF}
    {$IF COOPER AND ANDROID}
    method DiscoverTests(Instance: android.content.Context): ITest;
    method DiscoverTestsAsync(Instance: android.content.Context; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil): ITest;
    {$ELSE}
    method DiscoverTests(): ITest;
    {$IF NOT ISLAND}
    method DiscoverTestsAsync(OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil): ITest;
    {$ENDIF}
    {$ENDIF}
  end;

implementation

class method Discovery.FromObject(Value: Object): ITest;
begin
  ArgumentNilException.RaiseIfNil(Value, "Value");
  {$IFDEF COCOA}
  var r: Foundation.NSArray<Object> := [Value];
  exit new InstanceDiscovery(r).Discover;
  {$ELSE}
  exit new InstanceDiscovery([Value]).Discover;
  {$ENDIF}
end;

{$IF NOT ISLAND}
class method Discovery.FromObjectAsync(Value: Object; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken);
begin
  ArgumentNilException.RaiseIfNil(Value, "Value");
  {$IFDEF COCOA}
  var r: Foundation.NSArray<Object> := [Value];
  new InstanceDiscovery(r).DiscoverAsync(OnCompleted, Token);
  {$ELSE}
  new InstanceDiscovery([Value]).DiscoverAsync(OnCompleted, Token);
  {$ENDIF}
end;
{$ENDIF}

class method Discovery.FromObjects(Value: sequence of Object): ITest;
begin
  exit new InstanceDiscovery(Value).Discover;
end;

{$IF NOT ISLAND}
class method Discovery.FromObjectsAsync(Value: sequence of Object; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken);
begin
  new InstanceDiscovery(Value).DiscoverAsync(OnCompleted, Token);
end;
{$ENDIF}

class method Discovery.FromType(Value: NativeType): ITest;
begin
  ArgumentNilException.RaiseIfNil(Value, "Value");
  exit new TypeDiscovery([Value]).Discover;
end;

{$IF NOT ISLAND}
class method Discovery.FromTypeAsync(Value: NativeType; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken);
begin
  ArgumentNilException.RaiseIfNil(Value, "Value");
  new TypeDiscovery([Value]).DiscoverAsync(OnCompleted, Token);
end;
{$ENDIF}

class method Discovery.FromTypes(Value: sequence of NativeType): ITest;
begin
  exit new TypeDiscovery(Value).Discover;
end;

{$IF NOT ISLAND}
class method Discovery.FromTypesAsync(Value: sequence of NativeType; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken);
begin
  new TypeDiscovery(Value).DiscoverAsync(OnCompleted, Token);
end;
{$ENDIF}

{$IF COOPER AND ANDROID}
class method Discovery.DiscoverTestsAsync(Instance: android.content.Context; OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken): ITest;
begin
  Discovery.FromContextAsync(Instance, OnCompleted, Token);
end;

class method Discovery.DiscoverTests(Instance: android.content.Context): ITest;
begin
  exit Discovery.FromContext(Instance);
end;

{$ELSE}
class method Discovery.DiscoverTests(): ITest;
begin
  {$IF COOPER}
  exit Discovery.FromTypes(PackageHelper.LoadAllClasses);
  {$ELSEIF WINDOWS_PHONE}
  exit Discovery.FromAppDomain(AppDomain.CurrentDomain);
  {$ELSEIF NETFX_CORE}
  exit Discovery.FromAssembly(typeOf(Windows.UI.Xaml.Application.Current).GetTypeInfo.Assembly);
  {$ELSEIF ECHOES}
  exit Discovery.FromAppDomain(AppDomain.CurrentDomain);
  {$ELSEIF ISLAND OR TOFFEE}
  exit Discovery.FromModule;
  {$ENDIF}
end;

{$IF NOT ISLAND}
class method Discovery.DiscoverTestsAsync(OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken): ITest;
begin
  {$IF COOPER}
  Discovery.FromTypesAsync(PackageHelper.LoadAllClasses, OnCompleted, Token);
  {$ELSEIF WINDOWS_PHONE}
  Discovery.FromAppDomainAsync(AppDomain.CurrentDomain, OnCompleted, Token);
  {$ELSEIF NETFX_CORE}
  Discovery.FromAssemblyAsync(typeOf(Windows.UI.Xaml.Application.Current).GetTypeInfo.Assembly, OnCompleted, Token);
  {$ELSEIF ECHOES}
  Discovery.FromAppDomainAsync(AppDomain.CurrentDomain, OnCompleted, Token);
  {$ELSEIF ISLAND OR TOFFEE}
  Discovery.FromModuleAsync(OnCompleted, Token);
  {$ENDIF}
end;
{$ENDIF}

{$ENDIF}




end.