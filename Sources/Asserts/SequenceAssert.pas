namespace RemObjects.Elements.EUnit;

interface

type
  Assert = public partial static class {$IF NOUGAT}mapped to Object{$ENDIF}
  public
    method AreEqual<T>(Actual, Expected : sequence of T; IgnoreOrder: Boolean := false; Message: String := nil); {$IF NOUGAT}where T is class;{$ENDIF}
    method AreNotEqual<T>(Actual, Expected: sequence of T; IgnoreOrder: Boolean := false; Message: String := nil); {$IF NOUGAT}where T is class;{$ENDIF}

    method Contains<T>(Item: T; InSequence: sequence of T; Message: String := nil); {$IF NOUGAT}where T is class;{$ENDIF} 
    method DoesNotContains<T>(Item: T; InSequence: sequence of T; Message: String := nil); {$IF NOUGAT}where T is class;{$ENDIF}

    method IsEmpty<T>(Actual: sequence of T; Message: String := nil); {$IF NOUGAT}where T is class;{$ENDIF}
    method IsNotEmpty<T>(Actual: sequence of T; Message: String := nil); {$IF NOUGAT}where T is class;{$ENDIF}
  end;

implementation

class method Assert.AreEqual<T>(Actual: sequence of T; Expected: sequence of T; IgnoreOrder: Boolean; Message: String := nil);
begin
  var Error := if IgnoreOrder then SequenceHelper.Same(Actual, Expected) else SequenceHelper.Equals(Actual, Expected);

  FailIfNot(Error = nil, coalesce(Message, Error));
end;

class method Assert.AreNotEqual<T>(Actual: sequence of T; Expected: sequence of T; IgnoreOrder: Boolean; Message: String := nil);
begin
  var Error := if IgnoreOrder then SequenceHelper.Same(Actual, Expected) else SequenceHelper.Equals(Actual, Expected);

  FailIf(Error = nil, coalesce(Message, AssertMessages.SequenceEquals));
end;

class method Assert.Contains<T>(Item: T; InSequence: sequence of T; Message: String := nil);
begin
  ArgumentNilException.RaiseIfNil(InSequence, "InSequence"); 
  var Error := SequenceHelper.Contains(Item, InSequence);

  FailIfNot(Error = nil, Item, "Sequence", coalesce(Message, AssertMessages.DoesNotContains));
end;

class method Assert.DoesNotContains<T>(Item: T; InSequence: sequence of T; Message: String := nil);
begin
  ArgumentNilException.RaiseIfNil(InSequence, "InSequence"); 
  var Error := SequenceHelper.Contains(Item, InSequence);

  FailIf(Error = nil, Item, "Sequence", coalesce(Message, AssertMessages.UnexpectedContains));
end;

class method Assert.IsEmpty<T>(Actual: sequence of T; Message: String := nil);
begin
  ArgumentNilException.RaiseIfNil(Actual, "Actual"); 

  var Count := SequenceHelper.Count(Actual);
  FailIfNot(Count = 0, Count, "Sequence", coalesce(Message, AssertMessages.IsNotEmpty));
end;

class method Assert.IsNotEmpty<T>(Actual: sequence of T; Message: String := nil);
begin
  ArgumentNilException.RaiseIfNil(Actual, "Actual"); 

  var Count := SequenceHelper.Count(Actual);
  FailIf(Count = 0, Count, "Sequence", coalesce(Message, AssertMessages.IsEmpty));
end;

end.