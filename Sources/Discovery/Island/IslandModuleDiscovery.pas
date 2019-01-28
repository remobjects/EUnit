namespace RemObjects.Elements.EUnit;

uses
  RemObjects.Elements.EUnit.Reflections;

type
  IslandModuleDiscovery = assembly class(BaseDiscovery)
  public

    constructor; empty;

    method Filter: List<ITest>; override;
    begin
      result := new List<ITest>;
      var lTestType := typeOf(Test);
      for c in RemObjects.Elements.System.Type.AllTypes do begin
        //if (c.Flags and IslandTypeFlags.Class) ≠ 0 then begin // 77579: Island: cannot use 'in' in flags
        if (c.Flags = 16) then begin
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

      if defined("DARWIN") then begin
        var lCocoaTests := new CocoaModuleDiscovery().Filter;
        result.Add(lCocoaTests)
        //var lSwiftTests := new CocoaModuleDiscovery().Filter;
        //result.Add(lSwiftTests)
      end;

    end;

  end;

end.