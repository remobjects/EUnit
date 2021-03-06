﻿namespace RemObjects.Elements.EUnit;

interface

type
  Lock = public class (AbstractLock)
  protected
    {$IF COOPER}
    fEvent: Object := new Object; readonly;
    fOpen: Boolean := false;
    {$ELSEIF ECHOES}
    fEvent: System.Threading.AutoResetEvent := new System.Threading.AutoResetEvent(false);
    {$ELSEIF NOUGAT}
    fEvent: Foundation.NSCondition := new Foundation.NSCondition;
    fOpen: Boolean := false;
    {$ENDIF}
  public
    method Signal; override;
    method Reset; override;
    method WaitFor; override;
    method WaitFor(Timeout: Integer): Boolean; override;
  end;

implementation

method Lock.Signal;
begin
  {$IF COOPER}
  locking fEvent do begin
    fOpen := true;
    fEvent.notify;
  end;
  {$ELSEIF ECHOES}
  locking fEvent do
    fEvent.Set;
  {$ELSEIF NOUGAT}
  locking fEvent do begin
    fOpen := true;
    fEvent.broadcast;
  end;
  {$ENDIF}
end;

method Lock.Reset;
begin
  {$IF COOPER}
  locking fEvent do
    fOpen := false;
  {$ELSEIF ECHOES}
  locking fEvent do
    fEvent.Reset;
  {$ELSEIF NOUGAT}
  locking fEvent do
    fOpen := false;
  {$ENDIF}
end;

method Lock.WaitFor;
begin
  {$IF COOPER}
  locking fEvent do
    while not fOpen do
      fEvent.wait;
  {$ELSEIF ECHOES}
  fEvent.WaitOne(System.Threading.Timeout.Infinite);
  {$ELSEIF NOUGAT}
  fEvent.lock;
  try
    while not fOpen do
      fEvent.wait;
  finally
    fEvent.unlock;
  end;
  {$ENDIF}
end;

method Lock.WaitFor(Timeout: Integer): Boolean;
begin
  if Timeout = -1 then begin
    WaitFor;
    exit true;
  end;

  if Timeout < 0 then
    raise new ArgumentException("Timeout", "Timeout can not be negative");

  {$IF COOPER}
  locking fEvent do begin
    var t := System.currentTimeMillis;
    while not fOpen do begin
      fEvent.wait(Timeout);

      if System.currentTimeMillis - t >= Timeout then
        exit false;
    end;

    fOpen := false;
    exit true;
  end;
  {$ELSEIF ECHOES}
  result := fEvent.WaitOne(Timeout);
  {$ELSEIF NOUGAT}
  var Sec: Double := Timeout / 1000;
  fEvent.lock;
  try
    while not fOpen do
      result := fEvent.waitUntilDate(new Foundation.NSDate withTimeIntervalSinceNow(Sec));
  finally
    fEvent.unlock;
  end;
  {$ENDIF}
end;

end.