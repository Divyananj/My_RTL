library ieee;
use ieee.std_logic_1164.all;

entity d_ff is
	port ( clk: in std_logic;
	       d: in std_logic;
	       reset: in std_logic;
	       q: out std_logic
	      );
end d_ff;

architecture beh_d_ff of d_ff is
begin 
	-- d flipflop definition
	d_ff_process: process (clk, reset)
	begin
		if reset = '1' then
			q <= '0';
		elsif rising_edge(clk) then
			q <= d;
		end if;
	end process;
end beh_d_ff;

		
