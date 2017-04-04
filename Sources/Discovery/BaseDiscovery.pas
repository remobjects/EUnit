namespace RemObjects.Elements.EUnit;

interface

type
  BaseDiscovery = assembly abstract class (IDiscovery)
  protected
    method AppendList(Node: ITest; List: List<ITest>);
    property Token: ICancelationToken read write;
  public
    method Discover: ITest; virtual;
    {$IF NOT ISLAND}
    method DiscoverAsync(OnCompleted: Action<IAsyncResult<ITest>>; aToken: ICancelationToken := nil); virtual;
    {$ENDIF}
    method Filter: List<ITest>; virtual; abstract;
  end;

implementation

method BaseDiscovery.Discover: ITest;
begin
  if Token:Canceled then
    exit nil;

  var Filtered := Filter;

  if Filtered.Count = 1 then
    exit Filtered[0];

  var Node := new TestSuiteNode(String.Format("Test suite ({0} tests)", Filtered.Count));
  AppendList(Node, Filtered);
  exit Node;
end;

method BaseDiscovery.AppendList(Node: ITest; List: List<ITest>);
begin
  var SuiteNode := TestSuiteNode(Node);

  for item: ITest in List do
    SuiteNode.Add(item);
end;

{$IF NOT ISLAND}
method BaseDiscovery.DiscoverAsync(OnCompleted: Action<IAsyncResult<ITest>>; aToken: ICancelationToken);
begin
  ArgumentNilException.RaiseIfNil(OnCompleted, "OnCompleted");
  self.Token := aToken;

  async begin
    try
      var RetVal := Discover;

      if Token:Canceled then
        exit;

      OnCompleted(AsyncResult<ITest>.Completed(RetVal));
    except
      on E: Exception do
        OnCompleted(AsyncResult<ITest>.Failed<ITest>(E));
    end;
  end;
end;
{$ENDIF}

end.