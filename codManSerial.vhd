-- Polytechnic School of the University of Sao Paulo
-- Department of Digital Systems and Computater Engineering
-- Digital Laboratory A - Exp.6 - Manchester Serial Encoder IEEE 802.3
-- Lucas Penna Saraiva and Stefan R. Raposo


--> VERIFICAR DIVISOR DE CLOCK

library ieee;
use ieee.std_logic_1164.all;


entity codManSerial is
	
	generic( g_data_size: natural := 7);	--! Size of the register
	
	port (
	
		parallel_input  :  in std_logic_vector (g_data_size-1 downto 0);
	   load            :  in std_logic;
		serial_output   :  out std_logic;
		enable          :  in std_logic;
		reset_n         :  in std_logic;
		clock           :  in std_logic
		
		);
		
end entity;

architecture Structural of codManSerial is

	-- Components
	
	--> Creating the Shift Register
	
	component shift_register is
	
		generic( N : natural := 7);
			
		port ( Reset			 : in std_logic;
				 Clock		    : in std_logic;
				 Parallel_Input :	in std_logic_vector (N-1 downto 0);
				 Serial_Output  : out std_logic
				);

	end component;


	
	--> Creating the Manchester Encoder
	
	component Manchester_Serial_Encoder is
	
		port ( Serial_Input  : in std_logic;
				 Clock         : in std_logic;
				 Serial_Output : out std_logic
			  );
			 
	end component;

	
	
	--> Creating the Clock Divider 50MHz to 3kHz

	
	component divisor_16666 is
	
		port(
				clock, enc: in std_logic;
				sec: out std_logic
			  );
		
	end component;
	
	
	--> Auxiliar signals
	
	signal serial_aux               : std_logic;
	
	signal clock_divided            : std_logic;
	
	signal serial_output_manchester : std_logic;
	
	begin
	
		--> Calling the Clock Divider
		
		clock_divider: divisor_16666 port map(clock, enable, clock_divided); 
	
		--> Calling the Shift Register
		
		shifte_register: shift_register port map(not(reset_n), clock_divided, parallel_input, serial_aux);
	
		--> Calling the Manchester Encoder
		
		manchester_encoder: Manchester_Serial_Encoder port map(serial_aux, clock_divided, serial_output_manchester);
	
		--> Combinational Logic
	
		serial_output <= enable and serial_output_manchester;

		
end Structural;
