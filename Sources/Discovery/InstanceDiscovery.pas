namespace RemObjects.Elements.EUnit;

interface

type
  InstanceDiscovery = assembly class (TypeDiscovery)
  public
    constructor(Instances: sequence of Object);
  end;

implementation

constructor InstanceDiscovery(Instances: sequence of Object);
begin
  ArgumentNilException.RaiseIfNil(Instances, "Instances");
  var ObjectList := Instances.ToList();
  var Types := new NativeType[ObjectList.Count];

  for i: Integer := 0 to ObjectList.Count - 1 do
    Types[i] := typeOf(ObjectList[i]);

  inherited constructor (Types);
end;

end.