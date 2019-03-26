-- Polytechnic School of the University of Sao Paulo
-- Digital System and Computer Engineering Department
-- Digital Laboratory A - Experience 5
-- Authors: Lucas Penna Saraiva and Stefan R. Raposo

entity hamming_error_top_level is

    Port( input_binary:   in bit_vector(3 downto 0);
            
            flip:             in bit_vector(2 downto 0);    
            output_binary:  out bit_vector(3 downto 0);
            error_output:   out bit
            );
end entity;

architecture Behaviour of hamming_error_top_level is

-- Components

    -- Creating the Hamming Encoder component

    component Hamming_Encoder74 is
    
        port( binary: in bit_vector(3 downto 0);

                hamming: out bit_vector(6 downto 0)
             );
    
    end component;
    
    -- Creating the Hamming Decoder component

    component decHamming is
    
        port ( hamming: in bit_vector(6 downto 0);
                 
                 binary: out bit_vector(3 downto 0); 
               
                 error: out bit 
              
              );
                 
    end component;
    
-- Signals

    signal hamming_correct: bit_vector(6 downto 0);

    signal hamming_error: bit_vector(6 downto 0);
    
    
-- Architecture

    begin 
    
	 -- Encoding the binary_input
	 
    encoder: Hamming_Encoder74 port map(input_binary, hamming_correct);
    
    -- Inversion logic
	 
	 hamming_error(0) <= ( not(flip(2)) and not(flip(1)) and not(flip(0))) xor (hamming_correct(0));
	 hamming_error(1) <= ( not(flip(2)) and not(flip(1)) and not(flip(0))) xor (hamming_correct(1));
	 hamming_error(2) <= ( not(flip(2)) and not(flip(1)) and not(flip(0))) xor (hamming_correct(2));
	 hamming_error(3) <= ( not(flip(2)) and not(flip(1)) and not(flip(0))) xor (hamming_correct(3));
	 hamming_error(4) <= ( not(flip(2)) and not(flip(1)) and not(flip(0))) xor (hamming_correct(4));
	 hamming_error(5) <= ( not(flip(2)) and not(flip(1)) and not(flip(0))) xor (hamming_correct(5));
	 hamming_error(6) <= ( not(flip(2)) and not(flip(1)) and not(flip(0))) xor (hamming_correct(6));
	 
    -- Decoding the Hamming Code and attributting to the data output
    
	 decoder: decHamming port map(hamming_error, output_binary, error_output);
            
end Behaviour;