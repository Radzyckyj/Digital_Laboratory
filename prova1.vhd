-- Escola Politécnica da Universidade de São Paulo
-- PCS 3351 - Laboratório Digital A
-- Avaliação n° 1 - Professor Pedro Luis Pizzigatti Corrêa
-- Autores: Lucas Penna Saraiva e Stefan Radzyckyj Raposo


--Objetivo: monte um transmissor de um byte.

---> Entra-se com um byte nas chaves;

---> Enable em uma das chaves (baixo);

---> Ao acionar a chave correspodente ao Enable,
--os 8 bits das chaves deverão ser transmitidos através da saída
--serial, alocada no GPIO; 


library ieee;
use ieee.numeric_bit.all;

entity prova1 is

	port (
	
		parallel_input   :  in   bit_vector(7 downto 0);
		serial_output    :  out  bit;
		enable           :  in   bit;
		reset_n			  :  in   bit;
		clock            :  in   bit;
		botao            :  in   bit; 
		led_count        :  out  bit_vector(7 downto 0)
		);
		
end entity;

architecture Behaviour of prova1 is

-- Components:

	--Hamming Encoder Component

	component Hamming_Encoder74 is
	
		port(	binary  : in  bit_vector(3 downto 0);
				hamming : out bit_vector(6 downto 0)
			 );
			 
	end component;
	

	-- Manchester Serial Encoder Component
	
	component codManSerial is

		generic( g_data_size: natural := 14);	--! Size of the register
	
		port (

			parallel_input  :  in  bit_vector (g_data_size-1 downto 0);
			load            :  in  bit;
			serial_output   :  out bit;
			enable          :  in  bit;
			reset_n         :  in  bit;
			clock           :  in  bit
			);
			
	end component;

	-- Internal signals
	
	signal count : integer:= 0;
	
	signal parallel_input_auxiliar : bit_vector(7 downto 0);
	
	signal hamming_output1    : bit_vector(6 downto 0);

	signal hamming_input1     : bit_vector(3 downto 0);	
	
	signal hamming_output2    : bit_vector(6 downto 0);
	
	signal hamming_input2     : bit_vector(3 downto 0);
	
	signal codManSerial_input : bit_vector(13 downto 0);
	
	-- Structure
	
	begin 
	
	-- Hamming Encoder 1 attribution
	
	hamming_input1(0) <= parallel_input_auxiliar(0);
	hamming_input1(1) <= parallel_input_auxiliar(1);
	hamming_input1(2) <= parallel_input_auxiliar(2);
	hamming_input1(3) <= parallel_input_auxiliar(3);
	
	-- Hamming Encoder 2 attribution
	
	hamming_input2(0) <= parallel_input_auxiliar(4);
	hamming_input2(1) <= parallel_input_auxiliar(5);
	hamming_input2(2) <= parallel_input_auxiliar(6);
	hamming_input2(3) <= parallel_input_auxiliar(7);
	
	-- Connecting to Hamming Encoder 1 module: 
		
	Hamming_Encoder1: Hamming_Encoder74 port map(hamming_input1, hamming_output1);

	-- Connecting to Hamming Encoder 2 module:

	Hamming_Encoder2: Hamming_Encoder74 port map(hamming_input2, hamming_output2);
	
	-- codManSerial_input attribution
	
	codManSerial_input(0)  <= hamming_output2(0);
	codManSerial_input(1)  <= hamming_output2(1);
	codManSerial_input(2)  <= hamming_output2(2);
	codManSerial_input(3)  <= hamming_output2(3);
	codManSerial_input(4)  <= hamming_output2(4);
	codManSerial_input(5)  <= hamming_output2(5);
	codManSerial_input(6)  <= hamming_output2(6);
	codManSerial_input(7)  <= hamming_output1(0);
	codManSerial_input(8)  <= hamming_output1(1);	
	codManSerial_input(9)  <= hamming_output1(2);
	codManSerial_input(10) <= hamming_output1(3);
	codManSerial_input(11) <= hamming_output1(4);
	codManSerial_input(12) <= hamming_output1(5);
	codManSerial_input(13) <= hamming_output1(6);
	
	-- Connecting to codManSerial:

	Manchester_Encoder: codManSerial port map(codManSerial_input, '0', serial_output, enable, reset_n, clock);
	
	led_count <= bit_vector(to_unsigned(count,8));
	
	process(enable, botao)
	
	begin
		if reset_n = '0' then
			count <= 0;
			
		elsif falling_edge(botao) and enable ='0' then
			count <= count + 1;	
		end if;

		if enable = '1' then
			parallel_input_auxiliar <= bit_vector(to_unsigned(count,8));
		end if;
		
		
		
	end process;
	
end Behaviour;
	
	
	




		
