library ieee;
use ieee.std_logic_1164.all;

entity d_ff_async is
	port ( clk: in std_logic;
	       d: in std_logic;
	       reset: in std_logic;
	       q: out std_logic;
	       qn: out std_logic;
	       ce: in std_logic
	      );
end d_ff_async;

architecture beh_d_ff_async of d_ff_async is
begin 
	-- d flipflop definition
	d_ff_process: process (clk, reset)
		      begin
			if reset = '1' then			
				q <= '0';
				qn <= '1';
		        elsif ce = '1' or rising_edge(clk) then 
				q <= d;
				qn <= not d;
		    	end if;
		     end process;
end beh_d_ff_async;



