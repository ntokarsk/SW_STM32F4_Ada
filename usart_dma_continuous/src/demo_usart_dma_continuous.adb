------------------------------------------------------------------------------
--                                                                          --
--                    Copyright (C) 2015, AdaCore                           --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--     1. Redistributions of source code must retain the above copyright    --
--        notice, this list of conditions and the following disclaimer.     --
--     2. Redistributions in binary form must reproduce the above copyright --
--        notice, this list of conditions and the following disclaimer in   --
--        the documentation and/or other materials provided with the        --
--        distribution.                                                     --
--     3. Neither the name of STMicroelectronics nor the names of its       --
--        contributors may be used to endorse or promote products derived   --
--        from this software without specific prior written permission.     --
--                                                                          --
--   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS    --
--   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT      --
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR  --
--   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT   --
--   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, --
--   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT       --
--   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  --
--   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  --
--   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    --
--   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE  --
--   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   --
--                                                                          --
------------------------------------------------------------------------------

--  The file declares the main procedure for the demonstration.

--  The main program uses the DMA controller to send a block of characters
--  to a USART. The characters are sent continuously as long as the program
--  executes. Note that all the LEDs flash initially, before any characters
--  are sent, as a confirmation of overall execution.

with STM32F4;           use STM32F4;
with STM32F4.DMA;       use STM32F4.DMA;
with STM32F4.GPIO;      use STM32F4.GPIO;
with STM32F4.USARTs;    use STM32F4.USARTs;
with STM32F4_Discovery; use STM32F4_Discovery;
with Ada.Real_Time;     use Ada.Real_Time;
with Peripherals;       use Peripherals;

procedure Demo_USART_DMA_Continuous is

   type Data is array (1 .. 6) of Character; -- arbitrary size, component type
   for Data'Component_Size use 8; -- confirming

   Bytes_To_Transfer  : constant := Data'Length;
   random_temperature : Integer  := 123456;

   -- dopisz procedure ktora wrzuci do tablicy Data naszego floata z cyferkami
   function dajStringa(X : String) return Data is
      tab : Data;
      tmp : constant String := X;
   begin
      for i in 1..6 loop
         tab(i) := tmp(i);
      end loop;
      random_temperature := random_temperature + 1;
   return tab;
  end dajStringa;

   Source_Block  : constant Data := dajStringa(Integer'Image(random_temperature));

   -------------------------------
   -- Initialize_GPIO_Port_Pins --
   -------------------------------

   procedure Initialize_GPIO_Port_Pins is
      Configuration : GPIO_Port_Configuration;
   begin
      Enable_Clock (IO_Port);

      Configuration.Mode := Mode_AF;
      Configuration.Speed := Speed_50MHz;
      Configuration.Output_Type := Push_Pull;
      Configuration.Resistors := Pull_Up;

      Configure_IO
        (Port   => IO_Port,
         Pins   => Rx_Pin & Tx_Pin,
         Config => Configuration);

      Configure_Alternate_Function
        (Port => IO_Port,
         Pins => Rx_Pin & Tx_Pin,
         AF   => Transceiver_AF);
   end Initialize_GPIO_Port_Pins;

   ----------------------
   -- Initialize_USART --
   ----------------------

   procedure Initialize_USART is
   begin
      Enable_Clock (Transceiver);

      Enable (Transceiver);

      Set_Baud_Rate    (Transceiver, 115_200);
      Set_Mode         (Transceiver, Tx_Mode);
      Set_Stop_Bits    (Transceiver, Stopbits_1);
      Set_Word_Length  (Transceiver, Word_Length_8);
      Set_Parity       (Transceiver, No_Parity);
      Set_Flow_Control (Transceiver, No_Flow_Control);
   end Initialize_USART;

   --------------------
   -- Initialize_DMA --
   --------------------

   procedure Initialize_DMA is
      Configuration : DMA_Stream_Configuration;
   begin
      Enable_Clock (Controller);

      Reset (Controller, Tx_Stream);

      Configuration.Channel                      := Tx_Channel;
      Configuration.Direction                    := Memory_To_Peripheral;
      Configuration.Increment_Peripheral_Address := False;
      Configuration.Increment_Memory_Address     := True;
      Configuration.Peripheral_Data_Format       := Bytes;
      Configuration.Memory_Data_Format           := Bytes;
      Configuration.Operation_Mode               := Circular_Mode;
      Configuration.Priority                     := Priority_Very_High;
      Configuration.FIFO_Enabled                 := True;
      Configuration.FIFO_Threshold               := FIFO_Threshold_Full_Configuration;
      Configuration.Memory_Burst_Size            := Memory_Burst_Inc4;
      Configuration.Peripheral_Burst_Size        := Peripheral_Burst_Inc4;

      Configure (Controller, Tx_Stream, Configuration);
      --  note the controller is disabled by the call to Configure
   end Initialize_DMA;

   ----------------
   -- Blink_LEDs --
   ----------------

   procedure Blink_LEDs is
   begin
      for K in 1 .. 3 loop
         All_LEDs_On;
         delay until Clock + Milliseconds (200);
         All_LEDs_Off;
         delay until Clock + Milliseconds (200);
      end loop;
   end Blink_LEDs;

begin
   Initialize_LEDs;

   Blink_LEDs; --  just to signal that we are indeed running...

   Initialize_GPIO_Port_Pins;
   Initialize_USART;
   Initialize_DMA;

   Enable (Transceiver);

   loop
      begin
         Start_Transfer
           (Controller,
            Tx_Stream,
            Source      => Source_Block'Address,
            Destination => Data_Register_Address (Transceiver),
            Data_Count  => Bytes_To_Transfer);
         --  also enables the stream

         Enable_DMA_Transmit_Requests (Transceiver);
         --  at this point the characters will be coming continuously from the USART

         Turn_On (Green);
   end;
   end loop;




end Demo_USART_DMA_Continuous;

