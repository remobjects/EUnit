namespace RemObjects.Elements.EUnit;

interface

type
  AssemblyDiscovery = assembly class (BaseDiscovery)
  private
    Items: sequence of System.Reflection.&Assembly;
  public
    constructor(Assemblies: sequence of System.Reflection.&Assembly);

    method Filter: List<ITest>; override;
  end;

implementation

constructor AssemblyDiscovery(Assemblies: sequence of System.Reflection.Assembly);
begin
  ArgumentNilException.RaiseIfNil(Assemblies, "Assemblies");
  Items := Assemblies;
end;

method AssemblyDiscovery.Filter: List<ITest>;
begin
  result := new List<ITest>;

  for asm in Items do begin
    if Token:Canceled then
      exit;

    var TypeDiscovery := new TypeDiscovery(asm.GetTypes);
    result.Add(TypeDiscovery.Filter);
  end;
end;

end.