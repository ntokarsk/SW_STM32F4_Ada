-- sensor_pak.adb
-- materiały dydaktyczne
-- Jacek Piwowarczyk

with Ada.Text_IO;
use  Ada.Text_IO;
with Ada.Numerics.Float_Random;
use Ada.Numerics.Float_Random;
with Ada.Exceptions;
use Ada.Exceptions;
with GNAT.Sockets; use GNAT.Sockets;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Strings.Unbounded;
use Ada.Strings.unbounded;

--dodane w celu odbierania danych z stma
with Ada; use Ada;
with GNAT; use GNAT;
with Ada.Integer_Text_IO;
with Ada.Streams;
with GNAT.Serial_Communications; use GNAT.Serial_Communications;
with Ada.Strings.Fixed;

package body Sensor_Pak is
   Debug_mode : Boolean := False;
   licznik : Integer := 1;

   function dajStringa return String is
      SP1      : aliased Serial_Port;
      Nazwa    : String := "usbserial";
      Buf      : Streams.Stream_Element_Array(1..2);
      BufS     : String(1..2);
      Las      : Streams.Stream_Element_Offset;
      Nastepny : Ada.Real_Time.Time;
      Okres    : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(50);
      Temp_Unbounded_String   : Unbounded_String;
      flaga    : Integer := 0;
      Result   : String(1..2);
   begin
      if (Debug_mode) THEN
         Text_IO.Put_Line("Otwieram urzadzenie : tty." & Nazwa );
      end if;
      Open(Port => SP1, Name =>  Name(3) );
      Set(Port => SP1,  Rate=> B115200);

      if (Debug_mode) THEN
         Text_IO.Put_Line("Czekam na dane ...");
      end if;

      String'Read( SP1'Access, BufS);
      Nastepny := Ada.Real_Time.Clock;

      if (Debug_mode) THEN
         Text_IO.Put_Line("Buf S=" & BufS ) ;
      end if;

      for i in 1..licznik loop
         if (Debug_mode) THEN
            Text_IO.Put_Line("Licznik = " & Integer'Image(licznik));
         end if;

         Serial_Communications.Read(SP1, Buf, Las);
         --exit when Integer(Las) = 168;

         if (Debug_mode) THEN
            Text_IO.Put_Line("Wczytalem : " & Las'Img & " znaki" );
         end if;

         --wchodzimy dopiero kiedy iteracja dogoni licznik, w przeciwynym razie bedziemy oterzymywali te same dane za kazdym razem
         if (i = licznik) THEN
            for i in 1..Las loop
               if (Debug_mode) THEN
                  Text_IO.Put( Character'Val(Buf(i)) & "");
               end if;
               --flaga zapobiega wychodzeniu poza zakres string'a
               if (flaga) < 3 THEN
                  Append(Temp_Unbounded_String, Character'Val(Buf(i)));
               end if;
               flaga := flaga + 1;
            end loop;
            Ada.Strings.Fixed.Move(To_String(Temp_Unbounded_String), Result);
         end if;

         if (Debug_mode) THEN
            Text_IO.Put_Line(" # end");
            Text_IO.Put_Line("result = " & Result);
         end if;
         Nastepny := Nastepny + Okres;
         delay until Nastepny;
      end loop;

      Close(SP1); --zamkniecie serial_portu

      licznik := licznik + 1;
      if (licznik > 4) THEN
         licznik := 1;
      end if;

      return Result;
   end dajStringa;

  task body Sens is
      Nastepny : Ada.Real_Time.Time;
      Okres   : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(1200);
      G       : Generator;
      Address : Sock_Addr_Type;
      Socket  : Socket_Type;
      Channel : Stream_Access;
      FloatAsString : String(1..2);
      FloatFromString : Float := 0.0;
   begin
      Reset(G);
      Nastepny := Ada.Real_Time.Clock;
      Address.Addr := Addresses (Get_Host_By_Name (Host_Name), 1);
      Address.Port := 8888;
      Create_Socket (Socket);
      Set_Socket_Option (Socket, Socket_Level, (Reuse_Address, True));
      Connect_Socket (Socket, Address);
      loop
         FloatAsString := dajStringa;
         FloatFromString  := Float'Value(FloatAsString);

         if (Debug_mode) THEN
            Put_Line("Sensor: czekam okres ..." & FloatAsString);
            Put_Line("nowy float = " & Float'Image(FloatFromString));
         end if;

         delay until Nastepny;
         Channel := Stream (Socket);
         --Send message to kontroler
         Put_Line("Sensor: -> wysylam dane ..." & Float'Image(FloatFromString) );
         Float'Output (Channel, FloatFromString );
         --Receive and print message from Kontroler
         Put_Line ("Sensor: <-" & String'Input (Channel));
         Nastepny := Nastepny + Okres;
      end loop;
   exception
      when E:others =>
         Close_Socket (Socket);
         Put_Line("Error: Zadanie Sensor");
         Put_Line(Exception_Name (E) & ": " & Exception_Message (E));
   end Sens;

end Sensor_Pak;
