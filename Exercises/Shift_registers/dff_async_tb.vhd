
library ieee;
use ieee.std_logic_1164.all;

entity d_ff_async_tb is
end entity;

----------Architecture------------
architecture test of d_ff_sync_tb is

component d_ff_async is 
	port ( clk: in std_logic; --do not use inout change to some internal signal in my 
	    		           --architecture which can be used as both in or out
	       d: in std_logic;
	       reset: in std_logic;
	       q: out std_logic;
	       qn: out std_logic;
	       ce: in std_logic
	      );
end component d_ff_async;

---signal declarations---
signal d_tb: std_logic := '0';
signal reset_tb:  std_logic:= '1';
signal q_tb:  std_logic := '0';
signal clk_tb: std_logic := '0';
signal ce_tb: std_logic := '0';
signal qn_tb: std_logic := '1';

constant clk_period : time := 10 ns;
	
begin
	d_ff_1: d_ff_async
		port map(
			d => d_tb,
			reset => reset_tb,
			q => q_tb,
			clk => clk_tb,
			ce => ce_tb,
			qn => qn_tb
			);

	-- Clock process definition
	clk_process: process ----naming the process 
	begin
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
		
	end process;

	d_ff_process:process
		begin
			d_tb <= '0'; reset_tb <= '1';ce_tb <= '0';
			wait for 20 ns;
			d_tb <= '0'; reset_tb <= '0';ce_tb <= '1';
			wait for 20 ns;
			d_tb <= '1'; reset_tb <= '0';ce_tb <= '1';
			wait for 20 ns;
			d_tb <= '0'; reset_tb <= '0';ce_tb <= '1';
			wait for 20 ns;
			d_tb <= '1'; reset_tb <= '1';ce_tb <= '1';
			wait for 20 ns;

			wait ;
		end process;
end test;