namespace RemObjects.Elements.EUnit;

uses
  Sugar;

type
  BaseException = public class({$IF NOUGAT}Foundation.NSException{$ELSE}Exception{$ENDIF})
  public
  
    constructor (aMessage: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
    begin
      {$IF NOUGAT}
      inherited initWithName('SugarTestException') reason(aMessage) userInfo(nil);
      {$ELSE}
      inherited constructor(aMessage);
      {$ENDIF}
      ParsableMessage := String.Format("TEST-FAILED,{0},{1},{2}.{3},{4}", aFile, if aLine > 0 then aLine else "", aClass:Trim, aMethod:Trim, Message);
    end;
    
    {$IF NOUGAT}
    property Message: String read reason;
    {$ENDIF}
    property ParsableMessage: String; readonly;
    
  end;

end.