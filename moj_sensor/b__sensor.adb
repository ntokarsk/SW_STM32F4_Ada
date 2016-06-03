pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__sensor.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__sensor.adb");
pragma Suppress (Overflow_Check);
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E072 : Short_Integer; pragma Import (Ada, E072, "system__os_lib_E");
   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links_E");
   E207 : Short_Integer; pragma Import (Ada, E207, "system__fat_llf_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exception_table_E");
   E046 : Short_Integer; pragma Import (Ada, E046, "ada__io_exceptions_E");
   E100 : Short_Integer; pragma Import (Ada, E100, "ada__numerics_E");
   E151 : Short_Integer; pragma Import (Ada, E151, "ada__strings_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "ada__strings__maps_E");
   E048 : Short_Integer; pragma Import (Ada, E048, "ada__tags_E");
   E045 : Short_Integer; pragma Import (Ada, E045, "ada__streams_E");
   E070 : Short_Integer; pragma Import (Ada, E070, "interfaces__c_E");
   E126 : Short_Integer; pragma Import (Ada, E126, "interfaces__c__strings_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exceptions_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "system__file_control_block_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "ada__streams__stream_io_E");
   E064 : Short_Integer; pragma Import (Ada, E064, "system__file_io_E");
   E068 : Short_Integer; pragma Import (Ada, E068, "system__finalization_root_E");
   E066 : Short_Integer; pragma Import (Ada, E066, "ada__finalization_E");
   E177 : Short_Integer; pragma Import (Ada, E177, "system__storage_pools_E");
   E173 : Short_Integer; pragma Import (Ada, E173, "system__finalization_masters_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "system__storage_pools__subpools_E");
   E136 : Short_Integer; pragma Import (Ada, E136, "system__task_info_E");
   E110 : Short_Integer; pragma Import (Ada, E110, "ada__calendar_E");
   E193 : Short_Integer; pragma Import (Ada, E193, "system__pool_global_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "gnat__serial_communications_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "gnat__sockets_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "system__pool_size_E");
   E108 : Short_Integer; pragma Import (Ada, E108, "system__random_seed_E");
   E017 : Short_Integer; pragma Import (Ada, E017, "system__secondary_stack_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "ada__strings__unbounded_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "gnat__sockets__thin_common_E");
   E200 : Short_Integer; pragma Import (Ada, E200, "gnat__sockets__thin_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "system__strings__stream_ops_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "ada__real_time_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__text_io_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "system__tasking__restricted__stages_E");
   E077 : Short_Integer; pragma Import (Ada, E077, "sensor_pak_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E006 := E006 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "ada__text_io__finalize_spec");
      begin
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "gnat__sockets__finalize_body");
      begin
         E197 := E197 - 1;
         F2;
      end;
      E163 := E163 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "ada__strings__unbounded__finalize_spec");
      begin
         F3;
      end;
      E187 := E187 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "system__file_io__finalize_body");
      begin
         E064 := E064 - 1;
         F4;
      end;
      E173 := E173 - 1;
      E169 := E169 - 1;
      E204 := E204 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "system__pool_size__finalize_spec");
      begin
         F5;
      end;
      declare
         procedure F6;
         pragma Import (Ada, F6, "gnat__sockets__finalize_spec");
      begin
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "gnat__serial_communications__finalize_spec");
      begin
         F7;
      end;
      E193 := E193 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "system__pool_global__finalize_spec");
      begin
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "system__storage_pools__subpools__finalize_spec");
      begin
         F9;
      end;
      declare
         procedure F10;
         pragma Import (Ada, F10, "system__finalization_masters__finalize_spec");
      begin
         F10;
      end;
      E214 := E214 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "ada__streams__stream_io__finalize_spec");
      begin
         F11;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := 0;
      Time_Slice_Value := 0;
      WC_Encoding := 'b';
      Locking_Policy := 'C';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := 'F';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 1;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Fat_Llf'Elab_Spec;
      E207 := E207 + 1;
      System.Exception_Table'Elab_Body;
      E023 := E023 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E046 := E046 + 1;
      Ada.Numerics'Elab_Spec;
      E100 := E100 + 1;
      Ada.Strings'Elab_Spec;
      E151 := E151 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E045 := E045 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E025 := E025 + 1;
      System.File_Control_Block'Elab_Spec;
      E075 := E075 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E214 := E214 + 1;
      System.Finalization_Root'Elab_Spec;
      E068 := E068 + 1;
      Ada.Finalization'Elab_Spec;
      E066 := E066 + 1;
      System.Storage_Pools'Elab_Spec;
      E177 := E177 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Storage_Pools.Subpools'Elab_Spec;
      System.Task_Info'Elab_Spec;
      E136 := E136 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E110 := E110 + 1;
      System.Pool_Global'Elab_Spec;
      E193 := E193 + 1;
      Gnat.Serial_Communications'Elab_Spec;
      Gnat.Sockets'Elab_Spec;
      System.Pool_Size'Elab_Spec;
      E204 := E204 + 1;
      System.Random_Seed'Elab_Body;
      E108 := E108 + 1;
      E169 := E169 + 1;
      System.Finalization_Masters'Elab_Body;
      E173 := E173 + 1;
      System.File_Io'Elab_Body;
      E064 := E064 + 1;
      E126 := E126 + 1;
      E070 := E070 + 1;
      Ada.Tags'Elab_Body;
      E048 := E048 + 1;
      E155 := E155 + 1;
      System.Soft_Links'Elab_Body;
      E013 := E013 + 1;
      System.Os_Lib'Elab_Body;
      E072 := E072 + 1;
      System.Secondary_Stack'Elab_Body;
      E017 := E017 + 1;
      E187 := E187 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E163 := E163 + 1;
      Gnat.Sockets.Thin_Common'Elab_Spec;
      E202 := E202 + 1;
      Gnat.Sockets.Thin'Elab_Body;
      E200 := E200 + 1;
      Gnat.Sockets'Elab_Body;
      E197 := E197 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E212 := E212 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E118 := E118 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E006 := E006 + 1;
      System.Tasking.Restricted.Stages'Elab_Body;
      E216 := E216 + 1;
      Sensor_Pak'Elab_Spec;
      Sensor_Pak'Elab_Body;
      E077 := E077 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_sensor");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   C:\Users\Nikodem\Desktop\moj_sensor\sensor_pak.o
   --   C:\Users\Nikodem\Desktop\moj_sensor\sensor.o
   --   -LC:\Users\Nikodem\Desktop\moj_sensor\
   --   -LC:\Users\Nikodem\Desktop\moj_sensor\
   --   -LD:/gnat/2015/lib/gcc/i686-pc-mingw32/4.9.3/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -lws2_32
   --   -Xlinker
   --   --stack=0x200000,0x1000
   --   -mthreads
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
