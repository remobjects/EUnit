﻿namespace EUnit.Tests;

interface

uses
  RemObjects.Elements.EUnit;

type
  DiscoveryTest = public class (Test) 
  public
    method DiscoverObject;
    method DiscoverType;
    method DiscoverObjectAsync;
    method Methods;
    method ITest;
  end;

implementation

method DiscoveryTest.DiscoverObject;
begin
  var Actual := Discovery.FromObject(new DiscoveryTest);
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Kind, TestKind.Test);
  Assert.AreEqual(Actual.Name, "DiscoveryTest");

  var Items: array of Object := [new DiscoveryTest, new _EmptyTest];
  
  Actual := Discovery.FromObjects(Items);
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Kind, TestKind.Suite);
  var Number: Integer := 0;
  for item in Actual.Children do
    inc(Number);
 Assert.AreEqual(Number, 2);

  Items := [new DiscoveryTest]; 
  Actual := Discovery.FromObjects(Items);
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Kind, TestKind.Test);
  Assert.AreEqual(Actual.Name, "DiscoveryTest");

  Actual := Discovery.FromObject(new CodeObject(1));
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Kind, TestKind.Suite);
  Number := 0;
  for item in Actual.Children do
    inc(Number);
  Assert.AreEqual(Number, 0);

  Assert.Throws(->begin
                    var Obj: Object := nil;
                    Discovery.FromObject(Obj);
                  end, typeOf(ArgumentNilException));
end;

method DiscoveryTest.DiscoverType;
begin
  var Actual := Discovery.FromType(typeOf(DiscoveryTest));
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Kind, TestKind.Test);
  Assert.AreEqual(Actual.Name, "DiscoveryTest");

  
  Actual := Discovery.FromTypes([typeOf(DiscoveryTest), typeOf(_EmptyTest)]);
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Kind, TestKind.Suite);
  var Number: Integer := 0;
  for item in Actual.Children do
    inc(Number);
  Assert.AreEqual(Number, 2);

  Actual := Discovery.FromTypes([typeOf(DiscoveryTest)]);
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Kind, TestKind.Test);
  Assert.AreEqual(Actual.Name, "DiscoveryTest");

  Actual := Discovery.FromType(typeOf(CodeObject));
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Kind, TestKind.Suite);
  Number := 0;
  for item in Actual.Children do
    inc(Number);
  Assert.AreEqual(Number, 0);

  Assert.Throws(->begin
                    var lType := typeOf(Object);
                    lType := nil;
                    Discovery.FromType(lType);
                  end, typeOf(ArgumentNilException));
end;

method DiscoveryTest.DiscoverObjectAsync;
begin
  var Token := TokenProvider.CreateAwaitToken;
  var WasExecuted: Boolean := false;

  Discovery.FromObjectAsync(new DiscoveryTest, completed -> begin
      Token.Run(->begin 
        Assert.IsNotNil(completed);
        Assert.AreEqual(completed.State, AsyncState.Completed);
        Assert.IsNotNil(completed.Result); 
        Assert.AreEqual(completed.Result.Kind, TestKind.Test); 
        Assert.AreEqual(completed.Result.Name, "DiscoveryTest");
        WasExecuted := true;
      end);  
  end);

  Token.WaitFor;
  Assert.IsTrue(WasExecuted);
  WasExecuted := false;
  Token := TokenProvider.CreateAwaitToken;

  var Items: array of Object := [new DiscoveryTest, new _EmptyTest];
  Discovery.FromObjectsAsync(Items, completed -> begin
      Token.Run(->begin
        Assert.IsNotNil(completed);
        Assert.AreEqual(completed.State, AsyncState.Completed);
        Assert.IsNotNil(completed.Result);
        Assert.IsNotNil(completed.Result);
        Assert.AreEqual(completed.Result.Kind, TestKind.Suite);
        var Number: Integer := 0;
        for item in completed.Result.Children do
          inc(Number);
       Assert.AreEqual(Number, 2);
       WasExecuted := true;
      end); 
  end);   

  Token.WaitFor;
  Assert.IsTrue(WasExecuted);
  
  Assert.Throws(->begin
                    var Obj: Object := nil;
                    Discovery.FromObjectAsync(Obj, x ->begin end);
                  end, typeOf(ArgumentNilException));
  
  Assert.Throws(->Discovery.FromObjectAsync(new DiscoveryTest, nil), typeOf(ArgumentNilException));
end;

method DiscoveryTest.Methods;
begin
  var Actual := Discovery.FromObject(new _EmptyTest);
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Kind, TestKind.Test);
  Assert.AreEqual(Actual.Name, "_EmptyTest");

  var Number: Integer := 0;
  var Expected := new Sugar.Collections.List<String>;
  Expected.AddRange(["Public1", "Public5"]); 
  for item in Actual.Children do begin
    inc(Number);
    Assert.Contains(item.Name, Expected);
  end;
  Assert.AreEqual(Number, 2);

  Actual := Discovery.FromObject(new _SecondEmptyTest);
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Kind, TestKind.Test);
  Assert.AreEqual(Actual.Name, "_SecondEmptyTest");

  Number := 0;
  for item: ITest in Actual.Children do begin
    inc(Number);
    Assert.AreEqual(item.Name, "Public6");
  end;
  Assert.AreEqual(Number, 1);
end;

method DiscoveryTest.ITest;
begin
  var Actual := Discovery.FromType(typeOf(_EmptyTest));
  Assert.IsNotNil(Actual);
  Assert.AreEqual(Actual.Name, "_EmptyTest");
  Assert.AreEqual(Actual.Skip, false);
  Assert.AreEqual(Actual.Kind, TestKind.Test);
  Assert.AreEqual(Actual.DisplayName, Actual.Name);
  Assert.AreEqual(Actual.Id, "D762A834F821EB94");

  var Number: Integer := 0;
  var Expected := new Sugar.Collections.List<String>;
  Expected.AddRange(["Public1", "Public5"]); 
  for item in Actual.Children do begin
    inc(Number);
    Assert.Contains(item.Name, Expected);
  end;
  Assert.AreEqual(Number, 2);
end;

end.    