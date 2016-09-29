namespace RemObjects.Elements.EUnit;

interface

uses
  Sugar;

type
  Runner_DefaultListener = public extension class(Runner)
  private

    class method GetDefaultListener: IEventListener;
    begin
      if ConsoleTestListener.EmitParseableMessages then
        exit new ConsoleTestListener();
        
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
