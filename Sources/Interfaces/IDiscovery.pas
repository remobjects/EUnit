namespace RemObjects.Elements.EUnit;

interface

uses
  Sugar.Collections;

type
  IDiscovery = public interface
    method Discover: ITest;
    method DiscoverAsync(OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
  end;

implementation
end.