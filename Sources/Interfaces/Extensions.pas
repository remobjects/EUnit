namespace RemObjects.Elements.EUnit;

interface

extension method ITestResult.ToSequence: sequence of ITestResult;
extension method ITestResult.Where(Predicate: Predicate<ITestResult>): sequence of ITestResult;
extension method sequence of ITestResult.First(Predicate: Predicate<ITestResult>): ITestResult;
extension method sequence of ITestResult.All(Predicate: Predicate<ITestResult>): Boolean;
extension method sequence of ITestResult.Any(Predicate: Predicate<ITestResult>): Boolean;

implementation

extension method ITestResult.ToSequence: sequence of ITestResult;
var
  List: List<ITestResult> := new List<ITestResult>;

  method Update(Item: ITestResult);
  begin
    List.Add(Item);
    for child in Item.Children do
      Update(child);
  end;

begin
  Update(self);
  exit List.ToArray;
end;

extension method ITestResult.Where(Predicate: Predicate<ITestResult>): sequence of ITestResult;
begin
  ArgumentNilException.RaiseIfNil(Predicate, "Predicate");
  var List := new List<ITestResult>;

  for item in self.ToSequence do
    if Predicate(item) then
      List.Add(item);

  exit List.ToArray;
end;

extension method sequence of ITestResult.First(Predicate: Predicate<ITestResult>): ITestResult;
begin
  ArgumentNilException.RaiseIfNil(Predicate, "Predicate");

  for item in self do
    if Predicate(item) then
      exit item;

  exit nil;
end;

extension method sequence of ITestResult.All(Predicate: Predicate<ITestResult>): Boolean;
begin
  ArgumentNilException.RaiseIfNil(Predicate, "Predicate");

  for item in self do
    if not Predicate(item) then
      exit false;

  exit true;
end;

extension method sequence of ITestResult.Any(Predicate: Predicate<ITestResult>): Boolean;
begin
  ArgumentNilException.RaiseIfNil(Predicate, "Predicate");

  for item in self do
    if Predicate(item) then
      exit true;

  exit false;
end;

end.