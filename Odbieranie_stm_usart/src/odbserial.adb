-- odbserial.adb

with Ada; use Ada;
with GNAT; use GNAT;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Streams;
with GNAT.Serial_Communications; use GNAT.Serial_Communications;
with Ada.Numerics.Float_Random;
use Ada.Numerics.Float_Random;
with Ada.Real_Time;
use Ada.Real_Time;

procedure OdbSerial is
   SP1 : aliased Serial_Port;
   Nazwa : String := "usbserial";
   Buf :  Streams.Stream_Element_Array(1..2);
   BufS : String(1..2);
   Las : Streams.Stream_Element_Offset;

   Nastepny : Ada.Real_Time.Time;
   Okres   : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(1200);
   debug : Boolean := False;
begin
   if(debug) Text_IO.Put_Line("Otwieram urza…dzenie : tty." & Nazwa );
   Open(Port => SP1, Name =>  Name(3) );
   Set(Port => SP1,  Rate=> B115200);

   Text_IO.Put_Line("Czekam na dane ...");
   String'Read( SP1'Access, BufS);
   Nastepny := Ada.Real_Time.Clock;
  begin
  Text_IO.Put_Line("Buf S=" & BufS ) ;
    loop
         --Text_IO.Put_Line("hello from the loop inside");
         Serial_Communications.Read(SP1, Buf, Las);
         exit when Integer(Las) = 168;

         Text_IO.Put_Line("Wczytalem : " & Las'Img & " znaki" );
         for i in 1..Las loop
            --Text_IO.Put( Buf(i)'Img & " : " );
            Text_IO.Put( Character'Val(Buf(i)) & "");
         end loop;
         Text_IO.Put_Line(" # end");
         Nastepny := Nastepny + Okres;
         delay until Nastepny;
         --Text_IO.New_Line;
  end loop;
  end;
  Text_IO.Put_Line("Koncze" );
  Close(SP1);
end OdbSerial;
