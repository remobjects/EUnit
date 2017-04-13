namespace RemObjects.Elements.EUnit;

interface

type
  AsyncResult<T> = public class (IAsyncResult<T>)
  private
    constructor withException(anException: Exception);
    constructor(aResult: T);
  public
    property State: AsyncState read write; readonly;
    property Exception: Exception read write; readonly;
    property &Result: T read write; readonly;

    class method Failed<T>(anException: Exception): AsyncResult<T>;
    class method Completed<T>(aResult: T): AsyncResult<T>;
  end;

implementation

constructor AsyncResult<T> withException(anException: Exception);
begin
  State := AsyncState.Failed;
  self.Exception := anException;
end;

constructor AsyncResult<T>(aResult: T);
begin
  State := AsyncState.Completed;
  self.Result := aResult;
end;

class method AsyncResult<T>.Failed<T>(anException: Exception): AsyncResult<T>;
begin
  exit new AsyncResult<T> withException(anException);
end;

class method AsyncResult<T>.Completed<T>(aResult: T): AsyncResult<T>;
begin
  exit new AsyncResult<T>(aResult);
end;

end.