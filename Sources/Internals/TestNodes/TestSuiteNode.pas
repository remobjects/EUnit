namespace RemObjects.Elements.EUnit;

interface

uses
  Sugar.Collections;

type
  TestSuiteNode = assembly class (TestNode)
  private
    List: List<ITest> := new List<ITest>;
  public
    method &Add(Item: ITest); virtual;

    property Kind: TestKind read TestKind.Suite; override;
    property Children: sequence of ITest read List.ToArray; override;
  end;

implementation

method TestSuiteNode.Add(Item: ITest);
begin
  ArgumentNilException.RaiseIfNil(Item, "Item");
  List.Add(Item);
end;

end.