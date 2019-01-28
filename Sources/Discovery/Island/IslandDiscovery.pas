namespace RemObjects.Elements.EUnit;

type
  Discovery = public partial static class
  public

    method FromModule: ITest;
    begin
      exit new IslandModuleDiscovery().Discover;
    end;

    {$IF NOT ISLAND}
    method FromModuleAsync(OnCompleted: Action<IAsyncResult<ITest>>; Token: ICancelationToken := nil);
    begin
      new IslandModuleDiscovery().DiscoverAsync(OnCompleted, Token);
    end;
    {$ENDIF}

  end;

end.