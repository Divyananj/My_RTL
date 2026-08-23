
library ieee;
use ieee.std_logic_1164.all;

entity d_ff_tb is
end entity;

----------Architecture------------
architecture test of d_ff_tb is

component d_ff is 
	port ( clk: in std_logic; --do not use inout change to some internal signal in my 
	    		           --architecture which can be used as both in or out
	       d: in std_logic;
	       reset: in std_logic;
	       q: out std_logic
	      );
end component d_ff;

---signal declarations---
signal d_tb: std_logic;
signal reset_tb:  std_logic;
signal q_tb:  std_logic;
signal clk_tb: std_logic;

constant clk_period : time := 6 ns;
	
begin
	d_ff_1: d_ff
		port map(
			d => d_tb,
			reset => reset_tb,
			q => q_tb,
			clk => clk_tb
			);

	-- Clock process definition
	clk_process: process ----naming the process 
	begin
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
-------------------------to stop the simulation--------
		wait for 3 ns;
	end process;

	d_ff_process:process
		begin
			d_tb <= '1'; reset_tb <= '0';
			wait for 6 ns;
			d_tb <= '0'; reset_tb <= '1';
			wait for 6 ns;
			d_tb <= '1'; reset_tb <= '0';
			wait for 6 ns;
			d_tb <= '0'; reset_tb <= '1';
			wait for 6 ns;

			wait for 6 ns;
		end process;
end test;




 