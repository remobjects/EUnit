namespace RemObjects.Elements.EUnit;

interface

type
  SequenceHelper = public static class
  public
    method &Equals<T>(Actual, Expected: sequence of T): String; {$IF NOUGAT}where T is class;{$ENDIF}
    method Same<T>(Actual, Expected: sequence of T): String; {$IF NOUGAT}where T is class;{$ENDIF}
    method &Contains<T>(Item: T; Data: sequence of T): String; {$IF NOUGAT}where T is class;{$ENDIF}
    method Count<T>(Value: sequence of T): Integer; {$IF NOUGAT}where T is class;{$ENDIF}
    method ToList<T>(Value: sequence of T): List<T>; {$IF NOUGAT}where T is class;{$ENDIF}
  end;

implementation

class method SequenceHelper.Equals<T>(Actual: sequence of T; Expected: sequence of T): String;
begin
  if (Actual = nil) and (Expected = nil) then
    exit nil;

  if (Expected = nil) and (Actual <> nil) then
    exit AssertMessages.SequenceUnexpected;

  if (Actual = nil) and (Expected <> nil) then
    exit AssertMessages.SequenceExpected;

  var ExpectedList := ToList(Expected);
  var ActualList := ToList(Actual);

  if ExpectedList.Count <> ActualList.Count then
    exit String.Format(AssertMessages.SequenceLengthDiffers, ExpectedList.Count, ActualList.Count);

  for i: Integer := 0 to ExpectedList.Count - 1 do begin
    var Item := ExpectedList[i];
    if ((Item = nil) and (ActualList[i] <> nil)) or ((Item <> nil) and (not Item.Equals(ActualList[i]))) then
      exit String.Format(AssertMessages.SequenceElementMissing, Item);
  end;

  exit nil;
end;

class method SequenceHelper.Same<T>(Actual: sequence of T; Expected: sequence of T): String;
begin
  if (Actual = nil) and (Expected = nil) then
    exit nil;

  if (Expected = nil) and (Actual <> nil) then
    exit AssertMessages.SequenceUnexpected;

  if (Actual = nil) and (Expected <> nil) then
    exit AssertMessages.SequenceExpected;

  var List := new List<T>;

  for item in Actual do
    List.Add(item);

  var lCount := 0;

  for item in Expected do begin
    if not List.Contains(item) then
      exit String.Format(AssertMessages.SequenceElementMissing, item);
    inc(lCount);
  end;

  if lCount <> List.Count then
    exit String.Format(AssertMessages.SequenceLengthDiffers, lCount, List.Count);

  exit nil;
end;

class method SequenceHelper.Contains<T>(Item: T; Data: sequence of T): String;
begin
  ArgumentNilException.RaiseIfNil(Data, "Data");

  if ToList(Data).Contains(Item) then
    exit nil;

  exit String.Format(AssertMessages.SequenceElementMissing, Item);
end;

class method SequenceHelper.Count<T>(Value: sequence of T): Integer;
begin
  ArgumentNilException.RaiseIfNil(Value, "Value");
  result := 0;

  for item in Value do
    inc(result);
end;

class method SequenceHelper.ToList<T>(Value: sequence of T): List<T>;
begin
  result := new List<T>;

  for item in Value do
    {$IF NOUGAT}
    if item = Foundation.NSNull.null then
      result.Add(nil)
    else
      result.Add(item);
    {$ELSE}
      result.Add(item);
    {$ENDIF}
end;

end.