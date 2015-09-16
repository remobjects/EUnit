namespace RemObjects.Elements.EUnit;

interface

type
  NativeMethod = {$IF COOPER}java.lang.reflect.Method{$ELSEIF ECHOES}System.Reflection.MethodInfo{$ELSEIF NOUGAT}rtl.Method{$ENDIF};
  NativeType = {$IF COOPER}java.lang.Class{$ELSEIF ECHOES}System.Type{$ELSEIF NOUGAT}&Class{$ENDIF};

implementation
end.