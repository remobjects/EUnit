namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections;

type
  InitializeMethodAction = assembly class (InitializeTypeAction)
  protected
    method DoExecute(Context: RunContext); override;
  end;

implementation

method InitializeMethodAction.DoExecute(Context: RunContext);
begin
  if Context.Type = nil then
    inherited DoExecute(Context);

  if Context.Test.Method = nil then
    raise new RunnerException(String.Format("Method is missing in the <{0}> test.", Context.Test.Name));
    
  var lMethod := new MethodReference(Context.Type, Context.Test.Method);

  if not MethodValidators.Validator.IsValid(lMethod) then
    raise new RunnerException(String.Format("Method <{0}> is not a valid test method", lMethod.Name));
  
  Context.Method := lMethod;
end;

end.