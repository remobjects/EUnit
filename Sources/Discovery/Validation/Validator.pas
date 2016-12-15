namespace RemObjects.Elements.EUnit.Validation;

interface

uses
  RemObjects.Elements.EUnit;

type
  Validator<T> = public class (IValidator<T>)
  protected
    property Predicate: Predicate<T> read write; readonly;
  public
    constructor(aPredicate: Predicate<T>);
    method IsValid(Item: T): Boolean; virtual;
  end;

implementation

constructor Validator<T>(aPredicate: Predicate<T>);
begin
  ArgumentNilException.RaiseIfNil(aPredicate, "Predicate");
  Predicate := aPredicate;
end;

method Validator<T>.IsValid(Item: T): Boolean;
begin
  exit Predicate(Item);
end;

end.