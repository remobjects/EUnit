namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections,
  RemObjects.Elements.EUnit.Validation;

type
  MethodValidators = assembly static class
  private
    fValidator: IValidator<MethodReference>;

    method RegisterValidators;
    method GetValidator: IValidator<MethodReference>;
  public
    property Validator: IValidator<MethodReference> read GetValidator;
  end;

implementation

method MethodValidators.GetValidator: IValidator<MethodReference>;
begin
  if fValidator = nil then
    RegisterValidators;

  exit fValidator;
end;

method MethodValidators.RegisterValidators;
begin
  //Parameters
  fValidator := new Validator<MethodReference>(item -> item.IsVoid);
  //Overriden
  fValidator := fValidator.AndNot(item -> item.IsOverriden);
  //Void
  fValidator := fValidator.AndNot(item -> item.HasParameters);
  //Name
  fValidator := fValidator.AndNot(item -> Item.Name.Equals("SetupTest") or Item.Name.Equals("TeardownTest") or
     Item.Name.Equals("Setup") or Item.Name.Equals("Teardown"));
  //Prefix
  fValidator := fValidator.AndNot(item -> Item.Name.StartsWith("."));
end;

end.