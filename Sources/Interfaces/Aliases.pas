namespace RemObjects.Elements.EUnit;

type
  {$IF COOPER}
  NativeMethod = public java.lang.reflect.Method;
  NativeType = public java.lang.Class;
  {$ELSEIF ECHOES}
  NativeMethod = public System.Reflection.MethodInfo;
  NativeType = public System.Type;
  {$ELSEIF ISLAND}
  NativeMethod = public RemObjects.Elements.System.MethodInfo;
  NativeType = public RemObjects.Elements.System.Type;
  {$ELSEIF TOFFEE}
  NativeMethod = public rtl.Method;
  NativeType = public &Class;
  {$ENDIF}

end.