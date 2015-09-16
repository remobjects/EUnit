namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections,
  Sugar.Collections;

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

  var Count := objc_getClassList(nil, 0);
  if Count <= 0 then
    exit;

  var Classes := new unretained &Class[Count];
  Count := objc_getClassList(Classes, Count);

  for i: Integer := 0 to Count - 1 do begin
    var lClass: unretained &Class := Classes[i];
    var Super: &Class := class_getSuperclass(lClass);

    while Super <> nil do begin

      //inherits from Testcase
      if Super = Test.class then begin
        var Instance := Foundation.NSClassFromString(class_getName(lClass)).alloc.init;
        var Abc := new InstanceDiscovery([Instance]);
        result.AddRange(Abc.Filter);
        break;
      end;

      Super := class_getSuperclass(Super);
    end;
  end;
end;

constructor ModuleDiscovery;
begin
end;

end.