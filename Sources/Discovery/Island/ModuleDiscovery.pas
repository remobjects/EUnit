namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections;

type
  ModuleDiscovery = assembly class (BaseDiscovery)
  public
    constructor;
    method Filter: List<ITest>; override;
  end;

implementation

method ModuleDiscovery.Filter: List<ITest>;
begin
  result := new List<ITest>;
  var lTestType := typeOf(Test);
  for c in RemObjects.Elements.System.Type.AllTypes do begin
    if c.Flags = IslandTypeFlags.Class then begin

      var lSuper := c.BaseType;
      while assigned(lSuper) do begin

        //inherits from Testcase
        if lTestType.Equals(lSuper) then begin
          var Instance := c.Instantiate();
          var Abc := new InstanceDiscovery([Instance]);
          result.Add(Abc.Filter);
          break;
        end;

        lSuper := lSuper.BaseType;
      end;
    end;
  end;
end;

constructor ModuleDiscovery;
begin
end;

end.