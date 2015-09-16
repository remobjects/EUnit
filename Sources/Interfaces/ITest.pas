namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections,
  Sugar;

type
  ITest = public interface
    property Id: String read;
    property Name: String read;
    property DisplayName: String read write;
    property Kind: TestKind read;
    property &Skip: Boolean read write;
    property &Type: NativeType read;
    property &Method: NativeMethod read;
    property Children: sequence of ITest read;
  end;

implementation
end.