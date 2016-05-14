namespace RemObjects.Elements.EUnit;

interface

type
  AssertMessages = public static class
  public
    const Unknown = 'Unknown failure';
    const Unknown2 = 'Unknown failure, got "{0}", expected "{1}"';
    
    const NoException = 'Action does not throw an exception';
    const UnexpectedException = 'Unexpected exception: "{0}"';

    const NotEqual = 'Expected: "{1}" but was: "{0}"';
    const Equal = 'Actual value expected to be different from "{1}"';

    const LessExpected = 'Value expected to be less than "{1}", but was: "{0}"';
    const LessOrEqualExpected = 'Value expected to be less than or equal to "{1}", but was: "{0}"';
    const GreaterExpected = 'Value expected to be greater than "{1}", but was: "{0}"';
    const GreaterOrEqualExpected = 'Value expected to be greater than or equal to "{1}", but was: "{0}"';

    const StringPrefixMissing = 'String "{1}" does not starts with "{0}"';
    const StringSufixMissing = 'String "{1}" does not ends with "{0}"';
    
    const UnexpectedContains = '{1} contains unexpected element: "{0}"';
    const DoesNotContains = '{1} does not contains element: "{0}"';

    const ObjectIsNil = 'Object is nil';
    const ValueIsNaN = 'Value is NaN';
    const ValueIsNotNaN = 'NaN expected but was: "{0}"';
    const ValueIsInf = 'Value is infinity';
    const ValueIsNotInf = 'Infinity expected but was: "{0}"';

    const IsNotEmpty = '{1} is not empty';
    const IsEmpty = '{1} is empty';

    //sequences
    const SequenceExpected = '[Sequence] expected but got (nil)';
    const SequenceUnexpected = '(nil) expected but got [Sequence]';
    const SequenceLengthDiffers = 'Element count differs. Expected: "{0}" but was: "{1}"';
    const SequenceElementMissing = 'Expected element "{0}" is missing from actual sequence';
    const SequenceEquals = 'Sequence equals but expected to be different';
  end;

implementation
end.