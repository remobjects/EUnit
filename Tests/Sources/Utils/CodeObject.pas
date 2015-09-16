namespace EUnit.Tests;

interface

uses
  Sugar;

type
  CodeObject = public class {$IF NOUGAT}(Foundation.INSCopying){$ENDIF} //required for other tests
  public
    constructor(aCode: Integer);

    //we must override Object methods for each platform
    method {$IF NOUGAT}isEqual(obj: id){$ELSE}&Equals(Obj: Object){$ENDIF}: Boolean; override;
    method {$IF NOUGAT}description: Foundation.NSString{$ELSEIF COOPER}ToString: java.lang.String{$ELSEIF ECHOES}ToString: System.String{$ENDIF}; override;
    method {$IF NOUGAT}hash: Foundation.NSUInteger{$ELSEIF COOPER}hashCode: Integer{$ELSEIF ECHOES}GetHashCode: Integer{$ENDIF}; override;
    {$IF NOUGAT}method copyWithZone(zone: ^Foundation.NSZone): id;{$ENDIF}

    property Code: Integer read write;
  end;

implementation

constructor CodeObject(aCode: Integer);
begin
  Code := aCode;
end;

method CodeObject.{$IF NOUGAT}isEqual(obj: id){$ELSE}&Equals(Obj: Object){$ENDIF}: Boolean;
begin
  if (obj = nil) or (not (obj is CodeObject)) then
    exit false;
  
  exit self.Code = CodeObject(obj).Code;
end;

method CodeObject.{$IF NOUGAT}hash: Foundation.NSUInteger{$ELSEIF COOPER}hashCode: Integer{$ELSEIF ECHOES}GetHashCode: Integer{$ENDIF};
begin
  exit Code;
end;

method CodeObject.{$IF NOUGAT}description: Foundation.NSString{$ELSEIF COOPER}ToString: java.lang.String{$ELSEIF ECHOES}ToString: System.String{$ENDIF};
begin
  exit Code.ToString;
end;

{$IF NOUGAT}
method CodeObject.copyWithZone(zone: ^Foundation.NSZone): id;
begin
  exit new CodeObject(Code);
end;
{$ENDIF}

end.