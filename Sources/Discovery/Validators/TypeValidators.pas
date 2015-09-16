namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections,
  RemObjects.Elements.EUnit.Validation;

type
  TypeValidators = assembly static class
  private
    TestReference: TypeReference := new TypeReference(typeOf(Test));
    fValidator: IValidator<TypeReference>;

    method RegisterValidators;
    method GetValidator: IValidator<TypeReference>;
  public
    property Validator: IValidator<TypeReference> read GetValidator;
  end;

implementation

method TypeValidators.RegisterValidators;
begin
  //Test type
  fValidator := new Validator<TypeReference>(item -> item.DescendsFrom(TestReference));
end;

method TypeValidators.GetValidator: IValidator<TypeReference>;
begin
  if fValidator = nil then
    RegisterValidators;

  exit fValidator;
end;

end.