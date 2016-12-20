namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections;

type
  TestNode = assembly abstract class (ITest)
  public
    constructor(aName: String);

    [ToString]
    method ToString: String; override;

    property Id: String read protected write;
    property Name: String read write; readonly;
    property DisplayName: String read write; 
    property Kind: TestKind read; virtual; abstract; 
    property &Skip: Boolean read write;
    property &Type: NativeType read nil; virtual;
    property &Method: NativeMethod read nil; virtual;
    property Children: sequence of ITest read; virtual; abstract;
  end;

implementation

constructor TestNode(aName: String);
begin
  ArgumentNilException.RaiseIfNil(aName, "Name");
  Name := aName;
  &Skip := false;
  DisplayName := aName;
  Id := IdGenerator.ForName(aName);
end;

method TestNode.ToString: String;
begin
  exit String.Format("[{0}] {1} Kind: {2}", Id, Name, case Kind of
      TestKind.Suite: "Suite";
      TestKind.Test: "Test";
      TestKind.Testcase: "Testcase";
    end);
end;

end.