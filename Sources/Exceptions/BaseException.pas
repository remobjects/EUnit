namespace RemObjects.Elements.EUnit;

type
  BaseException = public class({$IF NOUGAT}Foundation.NSException{$ELSE}Exception{$ENDIF})
  public

    constructor (aMessage: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName(); aType: String := "TEST");
    begin
      var lPlainMessage := aMessage;
      if assigned(aFile) and (aLine > 0) then
        lPlainMessage := String.Format("{0} ({1} line {2})", lPlainMessage, Path.GetFileName(aFile), aLine);
      {$IF NOUGAT}
      inherited initWithName('EUnitTestException') reason(lPlainMessage) userInfo(nil);
      {$ELSE}
      inherited constructor(lPlainMessage);
      {$ENDIF}
      ParsableMessage := String.Format("{0}-FAILED,{1},{2},{3}.{4},{5}", aType, aFile, if aLine > 0 then aLine else "", aClass:Trim, aMethod:Trim, aMessage.Replace(#10,"\n").Replace(#13,"\r"));
    end;

    {$IF NOUGAT}
    property Message: String read reason;
    {$ENDIF}
    property ParsableMessage: String; readonly;

  end;

end.