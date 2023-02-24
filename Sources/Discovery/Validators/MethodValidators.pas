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
  fValidator := new Validator<MethodReference>(item -> item.IsVoid or item.IsAsync);
  //Overriden
  fValidator := fValidator.AndNot(item -> item.IsOverriden);
  //Void
  fValidator := fValidator.AndNot(item -> item.HasParameters);
  //Name
  fValidator := fValidator.AndNot(item -> item.Name.Equals("SetupTest") or item.Name.Equals("TeardownTest") or
     item.Name.Equals("Setup") or item.Name.Equals("Teardown"));
  //Prefix
  fValidator := fValidator.AndNot(item -> item.Name.StartsWith("."));
end;

end.