namespace RemObjects.Elements.EUnit;

interface

type
  AssertMessages = public static class
  public
    const Unknown = 'Unknown failure';
    const Unknown2 = 'Unknown failure, expected "{1}" but got "{0}", ';

    const NoException = 'Action does not throw an exception';
    const UnexpectedException = 'Unexpected exception: "{0}"';

    const NotTrue = 'Expected condition to be true, but it was false';
    const NotFalse = 'Expected condition to be false, but it was true';
    const NotEqual = 'EUNIT_REPLACE:Expected "{1}" but got "{0}"';
    const Equal = 'EUNIT_REPLACE:Actual value expected to be different from "{1}"';

    const XCNotEqual = 'Expected "{1}" but got "{0}"';
    const XCEqual = 'Actual value expected to be different from "{1}"';
    const XCFailed = 'Test Failed.';

    const LessExpected = 'EUNIT_REPLACE:Value expected to be less than "{1}" but was "{0}"';
    const LessOrEqualExpected = 'EUNIT_REPLACE:Value expected to be less than or equal to "{1}" but was "{0}"';
    const GreaterExpected = 'EUNIT_REPLACE:Value expected to be greater than "{1}", but was "{0}"';
    const GreaterOrEqualExpected = 'EUNIT_REPLACE:Value expected to be greater than or equal to "{1}" but was "{0}"';

    const StringPrefixMissing = 'EUNIT_REPLACE:String "{1}" does not starts with "{0}"';
    const StringSufixMissing = 'EUNIT_REPLACE:String "{1}" does not ends with "{0}"';

    const UnexpectedContains = 'EUNIT_REPLACE:{1} contains unexpected element: "{0}"';
    const DoesNotContains = 'EUNIT_REPLACE:{1} does not contains element: "{0}"';

    const ObjectIsNil = 'Value is nil';
    const ObjectIsNotNil = 'Value is not nil';
    const ValueIsNaN = 'Value is NaN';
    const ValueIsNotNaN = 'EUNIT_REPLACE:Expected NaN but got "{0}"';
    const ValueIsInf = 'Value is infinity';
    const ValueIsNotInf = 'EUNIT_REPLACE:Infinity but got "{0}"';

    const IsNotEmpty = 'EUNIT_REPLACE:"{1}" is not empty';
    const IsEmpty = 'EUNIT_REPLACE:"{1}" is empty';

    //sequences
    const SequenceExpected = '[Sequence] expected but got (nil)';
    const SequenceUnexpected = '(nil) expected but got [Sequence]';
    const SequenceLengthDiffers = 'Element count differs. Expected "{0}" but got "{1}"';
    const SequenceElementMissing = 'Expected element "{0}" is missing from actual sequence';
    const SequenceEquals = 'Sequence equals but expected to be different';
  end;

implementation
end.