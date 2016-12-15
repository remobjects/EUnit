namespace RemObjects.Elements.EUnit.Validation;

interface

uses
  RemObjects.Elements.EUnit;

extension method IValidator<T>.And(Other: IValidator<T>): IValidator<T>;
extension method IValidator<T>.AndNot(Other: IValidator<T>): IValidator<T>;
extension method IValidator<T>.Or(Other: IValidator<T>): IValidator<T>;
extension method IValidator<T>.OrNot(Other: IValidator<T>): IValidator<T>;

implementation

extension method IValidator<T>.And(Other: IValidator<T>): IValidator<T>;
begin
  ArgumentNilException.RaiseIfNil(Other, "Other");
  exit new Validator<T>(x -> self.IsValid(x) and Other.IsValid(x));
end;

extension method IValidator<T>.AndNot(Other: IValidator<T>): IValidator<T>;
begin
  ArgumentNilException.RaiseIfNil(Other, "Other");
  exit new Validator<T>(x -> self.IsValid(x) and (not Other.IsValid(x)));
end;

extension method IValidator<T>.Or(Other: IValidator<T>): IValidator<T>;
begin
  ArgumentNilException.RaiseIfNil(Other, "Other");
  exit new Validator<T>(x -> self.IsValid(x) or Other.IsValid(x));
end;

extension method IValidator<T>.OrNot(Other: IValidator<T>): IValidator<T>;
begin
  ArgumentNilException.RaiseIfNil(Other, "Other");
  exit new Validator<T>(x -> self.IsValid(x) or (not Other.IsValid(x)));
end;

end.