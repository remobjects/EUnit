namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections;

type
  TestcaseNode = assembly class (TestNode)
  private
    TestMethod: MethodReference;
  public
    constructor(aMethod: MethodReference);

    property Kind: TestKind read TestKind.Testcase; override;
    property Children: sequence of ITest read []; override;
    property &Type: NativeType read TestMethod.Type.NativeType; override;
    property &Method: NativeMethod read TestMethod.NativeMethod; override;
  end;

implementation

constructor TestcaseNode(aMethod: MethodReference);
begin
  ArgumentNilException.RaiseIfNil(aMethod, "Method");
  inherited constructor (aMethod.Name);
  TestMethod := aMethod;
  Id := IdGenerator.ForTestcase(self);
end;

end.