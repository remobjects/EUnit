namespace RemObjects.Elements.EUnit;

interface

type  
  Hasher = public static class
  assembly
    const FNVPrime: UInt64 = $100000001b3;
  public
    method HashBytes(Value: array of Byte): UInt64;
    method HashString(Value: String): UInt64;
    method ArrayToHex(Data: array of Byte): String;
    method IntToHex(Data: UInt64): String;
  end;

implementation

class method Hasher.HashBytes(Value: array of Byte): UInt64;
begin
  if Value = nil then
    raise new ArgumentNilException("Value");

  //FNV-1a (64bit)
  Result := UInt64($cbf29ce484222325);

  for i: Integer := 0 to Value.Length - 1 do begin
    Result := Result xor Value[i];
    Result := Result * FNVPrime;
  end;
end;

class method Hasher.HashString(Value: String): UInt64;
begin
  if Value = nil then
    raise new ArgumentNilException("Value");
  
  exit HashBytes(Encoding.UTF8.GetBytes(Value));
end;

class method Hasher.ArrayToHex(Data: array of Byte): String;
begin
  if Data = nil then
    raise new ArgumentNilException("Data");

  if Data.Length = 0 then
    exit "";

  var Chars := new Char[Data.Length * 2];
  var Num: Integer;

  for i: Integer := 0 to Data.Length - 1 do begin
    Num := Data[i] shr 4;
    Chars[i * 2] := chr(55 + Num + (((Num - 10) shr 31) and -7));
    Num := Data[i] and $F;
    Chars[i * 2 + 1] := chr(55 + Num + (((Num - 10) shr 31) and -7));
  end;

  exit new String(Chars);
end;

class method Hasher.IntToHex(Data: UInt64): String;
begin
  var Buffer: array of Byte := new Byte[8];

  Buffer[0] := Byte((Data and $ff) shr 0);
  Buffer[1] := Byte((Data and $ff00) shr $8);
  Buffer[2] := Byte((Data and $ff0000) shr $10);
  Buffer[3] := Byte((Data and $ff000000) shr $18);
  Buffer[4] := Byte((Data and $ff00000000) shr $20);
  Buffer[5] := Byte((Data and $ff0000000000) shr $28);
  Buffer[6] := Byte((Data and $ff000000000000) shr $30);
  Buffer[7] := Byte(Data shr $38);

  exit ArrayToHex(Buffer);
end;

end.