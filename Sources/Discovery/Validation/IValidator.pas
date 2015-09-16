namespace RemObjects.Elements.EUnit.Validation;

interface

type
  IValidator<T> = public interface
    method IsValid(Item: T): Boolean;
  end;

implementation
end.