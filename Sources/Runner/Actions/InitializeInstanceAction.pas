namespace RemObjects.Elements.EUnit;

interface

uses
  RemObjects.Elements.EUnit.Reflections;

type
  InitializeInstanceAction = assembly class (BaseAction)
  protected
    method DoExecute(Context: RunContext); override;
  end;

implementation

method InitializeInstanceAction.DoExecute(Context: RunContext);
begin
  if Context.Type = nil then
    raise new RunnerException("Unable to create new instance. Type is missing.");

  if Context.Instance = nil then begin
    var Instance := Context.Type.CreateInstance;

    if Instance is Test then
      Context.Instance := Test(Instance)
    else
      raise new RunnerException(String.Format("Class <{0}> is not a test class.", Context.Type.Name));
  end;
end;

end.