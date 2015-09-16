namespace RemObjects.Elements.EUnit;

interface

type
  IAwaitToken = public interface
    method Run(Action: AssertAction);
    method WaitFor;
  end;

implementation
end.