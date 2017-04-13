namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections;

type
  IdGenerator = assembly static class
  public
    method ForName(Value: String): String;
    method ForClass(Value: ITest): String;
    method ForTestcase(Value: ITest): String;
    method ForNode(Value: ITest): String;
  end;

implementation

class method IdGenerator.ForName(Value: String): String;
begin
  ArgumentNilException.RaiseIfNil(Value, "Value");
  exit Hasher.IntToHex(Hasher.HashString(Value));
end;

class method IdGenerator.ForClass(Value: ITest): String;
begin
  ArgumentNilException.RaiseIfNil(Value, "Value");
  exit ForName(new TypeReference(Value.Type).Name);
end;

class method IdGenerator.ForTestcase(Value: ITest): String;
begin
  ArgumentNilException.RaiseIfNil(Value, "Value");
  var TypeRef := new TypeReference(Value.Type);
  exit ForName(TypeRef.Name + "." + new MethodReference(TypeRef, Value.Method).Name);
end;

class method IdGenerator.ForNode(Value: ITest): String;
begin
  ArgumentNilException.RaiseIfNil(Value, "Value");
  case Value.Kind of
    TestKind.Suite: exit ForName(Value.Name);
    TestKind.Test: exit ForClass(Value);
    TestKind.Testcase: exit ForTestcase(Value);
  end;
end;

end.