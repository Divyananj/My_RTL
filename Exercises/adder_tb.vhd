library ieee;
use ieee.std_logic_1164.all;

entity adder_tb is
end adder_tb;

-- ------- Architecture ---------
architecture tst of adder_tb is
component ADDER is
	port( A: in std_logic_vector(3 downto 0);
	      B: in std_logic_vector(3 downto 0);
	      carry: out std_logic;
 	      sum: out std_logic_vector(3 downto 0)
	      );
end component ADDER;

--signal declarations
signal a: std_logic_vector(3 downto 0); 
signal b: std_logic_vector(3 downto 0);
signal s: std_logic_vector(3 downto 0);
signal c: std_logic;

begin 
	adder_1: ADDER 
		port map(   
		    A => a,   -- Port being assigned to my testbench signal
		    B => b,   -- <port> => <my_testbench signal>
		    sum => s,
		    carry => c
		);
        adder_process:process is
	        begin
	   	    a <= "1101"; b <= "1110";  --"" makes as std logic; if not treated as integer
	            wait for 1 ns;	       -- '' for sinle bit test value
		    a <= "1100"; b <= "0110"; 
		    wait for 1 ns;
		    a <= "0011"; b <= "1000";
	    	    wait for 1 ns;
		    a <= "0001"; b <= "1111";
		    wait for 1 ns;
		
--stop the simulatuon
	            
	        end process adder_process;
end tst;