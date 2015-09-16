namespace RemObjects.Elements.EUnit;

interface


type
  ExceptionHelper = public static class
  public
    method CatchException(Action: AssertAction): Exception;
  end;

implementation

class method ExceptionHelper.CatchException(Action: AssertAction): Exception;
begin
  ArgumentNilException.RaiseIfNil(Action, "Action");

  try
    Action();
  except
    on E: Exception do
      result := E;
  end;
end;

end.
