namespace RemObjects.Elements.EUnit;

interface

type
  ICancelationToken = public interface
    property Canceled: Boolean read;

    method Cancel;
  end;

implementation
end.