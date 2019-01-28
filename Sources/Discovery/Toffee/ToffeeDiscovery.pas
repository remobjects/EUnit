namespace RemObjects.Elements.EUnit;

{$IF TOFFEE}

type
  Discovery = public partial static class
  public

    method FromModule: ITest;
    begin
      exit new CocoaModuleDiscovery().Discover;
    end;

    method FromModuleAsync(OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
    begin
      new CocoaModuleDiscovery().DiscoverAsync(OnCompleted, Token);
    end;

  end;

{$ENDIF}

end.