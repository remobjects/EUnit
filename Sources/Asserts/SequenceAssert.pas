namespace RemObjects.Elements.EUnit;

interface

type
  BaseAsserts = public partial abstract class
  public
    method AreEqual<T>(Actual, Expected : sequence of T; IgnoreOrder: Boolean := false; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); {$IF NOUGAT}where T is class;{$ENDIF}
    method AreNotEqual<T>(Actual, Expected: sequence of T; IgnoreOrder: Boolean := false; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); {$IF NOUGAT}where T is class;{$ENDIF}

    method Contains<T>(Item: T; InSequence: sequence of T; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); {$IF NOUGAT}where T is class;{$ENDIF}
    method DoesNotContains<T>(Item: T; InSequence: sequence of T; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); {$IF NOUGAT}where T is class;{$ENDIF}

    method IsEmpty<T>(Actual: sequence of T; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); {$IF NOUGAT}where T is class;{$ENDIF}
    method IsNotEmpty<T>(Actual: sequence of T; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName()); {$IF NOUGAT}where T is class;{$ENDIF}
  end;

implementation

method BaseAsserts.AreEqual<T>(Actual: sequence of T; Expected: sequence of T; IgnoreOrder: Boolean; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  var Error := if IgnoreOrder then SequenceHelper.Same(Actual, Expected) else SequenceHelper.Equals(Actual, Expected);

  FailIfNot(Error = nil, coalesce(Message, Error), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.AreNotEqual<T>(Actual: sequence of T; Expected: sequence of T; IgnoreOrder: Boolean; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  var Error := if IgnoreOrder then
    SequenceHelper.Same(Actual, Expected)
  else
    SequenceHelper.Equals(Actual, Expected);

  FailIf(Error = nil, coalesce(Message, AssertMessages.SequenceEquals), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.Contains<T>(Item: T; InSequence: sequence of T; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  ArgumentNilException.RaiseIfNil(InSequence, "InSequence", aFile, aLine, aClass, aMethod);
  var Error := SequenceHelper.Contains(Item, InSequence);

  FailComparisonIfNot(Error = nil, Item, "Sequence", coalesce(Message, AssertMessages.DoesNotContains), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.DoesNotContains<T>(Item: T; InSequence: sequence of T; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  ArgumentNilException.RaiseIfNil(InSequence, "InSequence", aFile, aLine, aClass, aMethod);
  var Error := SequenceHelper.Contains(Item, InSequence);

  FailComparisonIf(Error = nil, Item, "Sequence", coalesce(Message, AssertMessages.UnexpectedContains), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.IsEmpty<T>(Actual: sequence of T; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  ArgumentNilException.RaiseIfNil(Actual, "Actual", aFile, aLine, aClass, aMethod);

  var Count := SequenceHelper.Count(Actual);
  FailComparisonIfNot(Count = 0, Count, "Sequence", coalesce(Message, AssertMessages.IsNotEmpty), aFile, aLine, aClass, aMethod);
end;

method BaseAsserts.IsNotEmpty<T>(Actual: sequence of T; Message: String := nil; aFile: String := currentFileName(); aLine: Integer := currentLineNumber(); aClass: String := currentClassName(); aMethod: String := currentMethodName());
begin
  ArgumentNilException.RaiseIfNil(Actual, "Actual", aFile, aLine, aClass, aMethod);

  var Count := SequenceHelper.Count(Actual);
  FailComparisonIf(Count = 0, Count, "Sequence", coalesce(Message, AssertMessages.IsEmpty), aFile, aLine, aClass, aMethod);
end;

end.