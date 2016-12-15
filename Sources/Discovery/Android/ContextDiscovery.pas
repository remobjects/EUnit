namespace RemObjects.Elements.EUnit;

interface

uses
  android.content,
  RemObjects.Elements.EUnit.Reflections;

type
  ContextDiscovery = assembly class (TypeDiscovery)
  private
    class method ReadPackage(Path: String): array of NativeType;
  public
    constructor(Instance: Context);
  end;

implementation

class method ContextDiscovery.ReadPackage(Path: String): array of NativeType;
begin
  var Content := new dalvik.system.DexFile(Path):entries;

  if Content = nil then
    exit nil;

  var List := new List<NativeType>;

  for Item: String in Content do begin
    if (Item <> nil) and (not Item.contains("%")) and (not Item.contains("$")) then
      List.Add(&Class.forName(Item));
  end;

  exit List.ToArray;
end;

constructor ContextDiscovery(Instance: Context);
begin
  ArgumentNilException.RaiseIfNil(Instance, "Instance");
  inherited constructor (ReadPackage(Instance.PackageCodePath));
end;

end.