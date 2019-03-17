-- Escola Politecnica da Universidade de Sao Paulo
-- Laboratorio Digital A - Experiencia 4
--
-- Functional description of 4-bit binary counter on VHDL 
-- 
-- Author: Lucas Penna Saraiva and Stefan R. Raposo
-- 
-- >> Design requirements:
-- 
-- The Clear signal is asynchronous
-- The Load signal is syncrhonous
-- Enable signal

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Counter_4_bit is

	Port ( Clear          : in STD_LOGIC;
			 Clock          : in STD_LOGIC;
			 Load           : in STD_LOGIC;
			 Enable         : in STD_LOGIC;
			 Up             : in STD_LOGIC; -- 'UP = 1 // Down = 0'
			 Counter_Input  : in STD_LOGIC_VECTOR (3 downto 0);
			 RCO            : out STD_LOGIC;
			 Counter_Output : out STD_LOGIC_VECTOR (3 downto 0));

end Counter_4_bit;

architecture Behaviour of Counter_4_bit is

	signal Count : STD_LOGIC_VECTOR(3 downto 0);

	begin
	
	-- Process Count
	
	process(Clock, Count)
	begin	

	if Clear = '1' then
		Count <= "0000";
		
	-- Up counter
	elsif rising_edge(clock) and Enable ='1' then
	
		-- Verifying the count initial condition
		
		if Load = '1' then
		
			Count <= Counter_Input;
			
		else
		
		-- Up counting
		
			if Up = '1' then
			
				if Count = "1111" then
				
				Count <= "0000";
					
				else
				
					Count <= Count + '1';
				
				end if;
			
				-- Verify RCO condition
		
				if Count = "1111" then
					
					RCO <= '1';
				
				else
				
					RCO <= '0';
				
				end if;
				
			-- Down Couting
			
			else
			
				if Count = "0000" then
				
					Count <= "1111";
				
				else
				
					Count <= Count - '1';
				
				end if;
				
				
				-- Verify RCO condition
				
				if Count = "0000" then
				
					RCO <= '1';
					
				else
				
					RCO <= '0';
					
				end if;
			end if;
		end if;
	end if;
	
	end process;
		
	Counter_Output <= Count;
		
end Behaviour;	