namespace RemObjects.Elements.EUnit;

interface

type
  AsyncState = public enum (Failed, Completed);

  IAsyncResult<T> = public interface
    property State: AsyncState read;
    property Exception: Exception read;
    property &Result: T read;
  end;

implementation
end.