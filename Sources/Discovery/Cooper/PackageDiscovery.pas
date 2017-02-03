namespace RemObjects.Elements.EUnit;

interface

uses
  java.util.jar,
  RemObjects.Elements.EUnit.Reflections;

type
  PackageDiscovery = assembly class (TypeDiscovery)
  private
    class method ListClasses(Path: String; PackageName: String): List<NativeType>;
    class method ReadPackage(PackageName: String): array of NativeType;
  public
    constructor(Instance: Package);
  end;

implementation

class method PackageDiscovery.ListClasses(Path: String; PackageName: String): List<NativeType>;
begin
  var File := new JarFile(Path);
  var List := new List<NativeType>;

  for entry: JarEntry in File.entries do begin
    var ClassName: String := nil;

    if entry.Name.endsWith(".class") then //and entry.Name.startsWith(PackageName) {and (entry.Name.length > (PackageName.length + 1))}) then
      ClassName := entry.Name.replace("/", ".").replace("\\", ".").replace(".class", "");

    if (ClassName <> nil) and (not ClassName.contains("$")) then
      List.Add(&Class.forName(ClassName));
  end;

  exit List;
end;

constructor PackageDiscovery(Instance: Package);
begin
  ArgumentNilException.RaiseIfNil(Instance, "Instance");
  inherited constructor (ReadPackage(Instance.Name));
end;

class method PackageDiscovery.ReadPackage(PackageName: String): array of NativeType;
begin
  PackageName := PackageName.replace(".", "/");

  var Loader := java.lang.Thread.currentThread.ContextClassLoader;
  var Res := Loader.getResources(PackageName);
  var List := new List<NativeType>;

  while Res.hasMoreElements do begin
    var Item := Res.nextElement;
    var DecodedPath  := java.net.URLDecoder.decode(Item.Path, "utf-8");
    var Path := DecodedPath.replaceFirst("[.]jar[!].*", ".jar").replaceFirst("file:", "");
    List.Add(ListClasses(Path, PackageName));
  end;

  exit List.ToArray;
end;

end.