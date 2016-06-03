-- main.adb

pragma Profile(Ravenscar);
with System;
with Model; pragma Unreferenced(Model);

procedure Main
  with Priority => System.Priority'First is
begin
  loop
    null;
  end loop;
end Main;
