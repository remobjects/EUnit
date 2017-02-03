namespace RemObjects.Elements.EUnit;

type
  {$IF COOPER}
  NativeMethod = java.lang.reflect.Method;
  NativeType = java.lang.Class;
  {$ELSEIF ECHOES}
  NativeMethod = System.Reflection.MethodInfo;
  NativeType = System.Type;
  {$ELSEIF ISLAND}
  NativeMethod = RemObjects.Elements.System.MethodInfo;
  NativeType = RemObjects.Elements.System.Type;
  {$ELSEIF TOFFEE}
  NativeMethod = rtl.Method;
  NativeType = &Class;
  {$ENDIF}

end.