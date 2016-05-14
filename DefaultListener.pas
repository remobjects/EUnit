namespace RemObjects.Elements.EUnit;

interface

uses
  Sugar;

type
  Runner_DefaultListener = public extension class(Runner)
  private

    class method GetDefaultListener: IEventListener;
    begin
      //if length(Environment.GetEnvironmentVariable(EUNIT_PARSABLE_MESSAGES)) > 0 then // E399 No overloaded method "length" with 1 parameter on type "not nullable Class"
      if RemObjects.Elements.System.length(Environment.GetEnvironmentVariable(EUNIT_PARSABLE_MESSAGES)) > 0 then
        exit new ConsoleTestListener(true);
        
      {$IF IOS}
      result := new TableViewTestListener();
      {$ELSE}
      result := new ConsoleTestListener();
      {$ENDIF}
    end;
  
  public

    const EUNIT_PARSABLE_MESSAGES = "EUNIT_PARSABLE_MESSAGES";
    class property DefaultListener: IEventListener read GetDefaultListener;

  end;

implementation

end.
