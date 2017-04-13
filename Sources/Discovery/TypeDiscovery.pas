namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections,
  RemObjects.Elements.EUnit.Validation;

type
  TypeDiscovery = assembly class (BaseDiscovery)
  private
    Items: sequence of NativeType;

    method ProcessType(Item: NativeType): ITest;
  public
    constructor(aTypes: sequence of NativeType);

    method Filter: List<ITest>; override;
  end;

implementation

constructor TypeDiscovery(aTypes: sequence of NativeType);
begin
  ArgumentNilException.RaiseIfNil(aTypes, "Types");
  Items := aTypes;
end;

method TypeDiscovery.Filter: List<ITest>;
begin
  result := new List<ITest>;

  for item in Items do begin

    if Token:Canceled then
      exit;

    var Node := ProcessType(item);

    if Node <> nil then
      result.Add(Node);
  end;
end;

method TypeDiscovery.ProcessType(Item: NativeType): ITest;
begin
  if Item = nil then
    exit nil;

  var lType := new TypeReference(Item);

  //if not TypeValidators.Validator.IsValid(lType) then
  //  exit nil;

  var Node := new TestClassNode(lType);

  if lType.IsAbstract then
    Node.Skip := true;

  var Methods := lType.GetMethods;

  for lMethod: MethodReference in Methods do
    if MethodValidators.Validator.IsValid(lMethod) then
      Node.Add(new TestcaseNode(lMethod));

  exit Node;
end;

end.