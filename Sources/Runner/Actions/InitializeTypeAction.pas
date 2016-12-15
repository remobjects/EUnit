namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.RTL,
  RemObjects.Elements.EUnit.Reflections;

type
  InitializeTypeAction = assembly class (BaseAction)
  protected
    method DoExecute(Context: RunContext); override;
  end;

implementation

method InitializeTypeAction.DoExecute(Context: RunContext);
begin
  if Context.Test = nil then
    raise new RunnerException("Unable to initialize type. Test reference is missing.");

  if Context.Test.Type = nil then
    raise new RunnerException(String.Format("Type is missing in the <{0}> test.", Context.Test.Name));

  var lType := new TypeReference(Context.Test.Type);

  if not TypeValidators.Validator.IsValid(lType) then
    raise new RunnerException(String.Format("Class <{0}> is not a valid test class", lType.Name));

  Context.Type := lType;
end;

end.