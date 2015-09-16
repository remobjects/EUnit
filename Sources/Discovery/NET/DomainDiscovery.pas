namespace RemObjects.Elements.EUnit;

interface

type
  DomainDiscovery = assembly class (AssemblyDiscovery)
  public
    constructor(aDomain: AppDomain);
  end;

implementation

constructor DomainDiscovery(aDomain: AppDomain);
begin
  ArgumentNilException.RaiseIfNil(aDomain, "Domain");
  inherited constructor(aDomain.GetAssemblies);
end;

end.