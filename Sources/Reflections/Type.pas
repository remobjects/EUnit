namespace RemObjects.Elements.EUnit.Reflections;

interface

uses
  {$IF NETFX_CORE}System.Reflection,{$ENDIF}
  RemObjects.Elements.RTL,
  RemObjects.Elements.EUnit;

type
  TypeReference = public class
  private    
    Native: NativeType;
    method GetName: String;    
    method GetIsAbstract: Boolean;
  public
    constructor(&Type: NativeType);

    method DescendsFrom(OtherType: TypeReference): Boolean;
    method GetMethods: List<MethodReference>;
    method EqualsTo(OtherType: TypeReference): Boolean;
    method CreateInstance: Object;

    method {$IF NOUGAT}description: Foundation.NSString{$ELSEIF COOPER}ToString: java.lang.String{$ELSEIF ECHOES}ToString: System.String{$ENDIF}; override;

    property Name: String read GetName;
    property NativeType: NativeType read Native;
    property IsAbstract: Boolean read GetIsAbstract;
  end;

implementation

constructor TypeReference(&Type: NativeType); 
begin
  if &Type = nil then
    raise new ArgumentNilException("Type");

  Native := &Type;
end;

method TypeReference.DescendsFrom(OtherType: TypeReference): Boolean;
begin
  if OtherType = nil then
    exit false;
  
  {$IF COOPER}
  exit OtherType.Native.isAssignableFrom(Native) and (not EqualsTo(OtherType));
  {$ELSEIF NETFX_CORE}
  exit OtherType.Native.GetTypeInfo.IsAssignableFrom(Native.GetTypeInfo) and (not EqualsTo(OtherType));
  {$ELSEIF ECHOES}
  exit OtherType.Native.IsAssignableFrom(Native) and (not EqualsTo(OtherType));
  {$ELSEIF NOUGAT}
  var Super := class_getSuperclass(self.Native);
  while Super <> nil do begin
    if Super = OtherType.Native then
      exit true;

    Super := class_getSuperclass(Super);
  end;

  exit false;
  {$ENDIF}
end;

method TypeReference.GetMethods: List<MethodReference>;
begin
  result := new List<MethodReference>;
  {$IF COOPER}
  var lMethods := Native.getMethods;
  for lMethod in lMethods do
    result.Add(new MethodReference(self, lMethod));
  {$ELSEIF NETFX_CORE}
  var lMethods := Native.GetRuntimeMethods;
  for lMethod in lMethods do begin
    if lMethod.IsPublic and (not lMethod.IsStatic) then
      result.Add(new MethodReference(self, lMethod));
  end;
  {$ELSEIF ECHOES}
  var lMethods := Native.GetMethods(System.Reflection.BindingFlags.Public or System.Reflection.BindingFlags.Instance);
  for lMethod in lMethods do
    result.Add(new MethodReference(self, lMethod));
  {$ELSEIF NOUGAT}
  var lMethodsCount: UInt32 := 0;
  self.Native.description(); //workaround for #70325
  var lMethods := class_copyMethodList(self.Native, var lMethodsCount);
  

  for i: Integer := 0 to lMethodsCount - 1 do
    result.Add(new MethodReference(self, lMethods[i]));
  {$ENDIF}
end;

method TypeReference.GetName: String;
begin
  {$IF COOPER}
  exit Native.SimpleName;
  {$ELSEIF ECHOES}
  exit Native.Name;
  {$ELSEIF NOUGAT}
  exit Foundation.NSString.stringWithUTF8String(class_getName(self.Native));
  {$ENDIF}
end;

method TypeReference.EqualsTo(OtherType: TypeReference): Boolean;
begin
  if OtherType = nil then
    exit false;

  exit Native = OtherType.Native;
end;

method TypeReference.CreateInstance: Object;
begin
  {$IF COOPER}
  var ctor := Native.getConstructor([]);
  exit ctor.newInstance(nil);
  {$ELSEIF ECHOES}
  exit Activator.CreateInstance(Native);
  {$ELSEIF NOUGAT}
  exit Foundation.NSClassFromString(class_getName(self.Native)).alloc.init;
  {$ENDIF}
end;

method TypeReference.{$IF NOUGAT}description: Foundation.NSString{$ELSEIF COOPER}ToString: java.lang.String{$ELSEIF ECHOES}ToString: System.String{$ENDIF};
begin
  exit "Type: " + Name;
end;

method TypeReference.GetIsAbstract: Boolean;
begin
  {$IF COOPER}
  exit java.lang.reflect.Modifier.isAbstract(Native.GetModifiers);
  {$ELSEIF NETFX_CORE}
  exit Native.GetTypeInfo.IsAbstract;
  {$ELSEIF ECHOES}  
  exit Native.IsAbstract;
  {$ELSEIF NOUGAT}  
  exit false;
  {$ENDIF}
end;

end.