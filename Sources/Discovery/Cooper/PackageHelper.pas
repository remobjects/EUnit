namespace RemObjects.Elements.EUnit;

interface

uses
  java.util.jar;

type
  PackageHelper = assembly static class
  private
    class method ListClasses(Path: String; PackageName: String): List<NativeType>;
  public    
    class method LoadClasses(PackageName: String): List<NativeType>;
    class method LoadClasses(Package: Package): List<NativeType>;
    class method LoadAllClasses: List<NativeType>;
  end;

implementation

method PackageHelper.ListClasses(Path: String; PackageName: String): List<NativeType>;
begin
  var File := new JarFile(Path);
  var List := new List<NativeType>;

  for entry: JarEntry in File.entries do begin
    var ClassName: String := nil;

    if entry.Name.endsWith(".class") then
      ClassName := entry.Name.replace("/", ".").replace("\\", ".").replace(".class", "");

    if (ClassName <> nil) and (not ClassName.contains("$")) then
      List.Add(&Class.forName(ClassName));
  end;

  exit List;
end;

method PackageHelper.LoadClasses(PackageName: String): List<NativeType>;
begin
  PackageName := PackageName.replace(".", "/");

  var Loader := Thread.currentThread.ContextClassLoader;
  var Res := Loader.getResources(PackageName);
  var List := new List<NativeType>;

  while Res.hasMoreElements do begin
    var Item := Res.nextElement;
    var DecodedPath  := java.net.URLDecoder.decode(Item.Path, "utf-8");
    var Path := DecodedPath.replaceFirst("[.]jar[!].*", ".jar").replaceFirst("file:", "");
    List.Add(ListClasses(Path, PackageName));
  end;

  exit List;
end;

method PackageHelper.LoadClasses(Package: Package): List<NativeType>;
begin
  ArgumentNilException.RaiseIfNil(Package, "Package");
  exit LoadClasses(Package.Name);
end;

method PackageHelper.LoadAllClasses: List<NativeType>;
begin
  var lTypes := new List<NativeType>;
  var Packages := Package.GetPackages();

  for i: Int32 := 0 to Packages.length-1 do begin
    var lPackage := Packages[i];

    if lPackage.ImplementationVendor <> "Oracle Corporation" then
      lTypes.Add(LoadClasses(lPackage));
  end;    

  exit lTypes;
end;

end.
