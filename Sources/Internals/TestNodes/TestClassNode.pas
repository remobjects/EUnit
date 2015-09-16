namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections;

type
  TestClassNode = assembly class (TestSuiteNode)
  private
    TestType: TypeReference;
  public
    constructor(aType: TypeReference);

    method &Add(Item: ITest); override;

    property &Type: NativeType read TestType.NativeType; override;
    property Kind: TestKind read TestKind.Test; override;
  end;

implementation

constructor TestClassNode(aType: TypeReference);
begin
  ArgumentNilException.RaiseIfNil(aType, "Type");
  inherited constructor(aType.Name);
  TestType := aType;
  Id := IdGenerator.ForClass(self);
end;

method TestClassNode.Add(Item: ITest);
begin
  if Item.Kind <> TestKind.Testcase then
    raise new ArgumentException("Item", "Unable to add item. You can only add testcases to a test class.");

  inherited &Add(Item);
end;

end.