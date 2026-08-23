library ieee;
use ieee.std_logic_1164.all;

entity sr_async_tb is 
end entity;

architecture structure_test of sr_async_tb is 
component sr_async is
	port( d: in std_logic;
	      ce: in std_logic;
	      reset: in std_logic;
	      clk: in std_logic;
	      q: out std_logic_vector (3 downto 0);
	      qn: out std_logic_vector (3 downto 0)
	     );
end component;

signal d_tb: std_logic;
signal ce_tb: std_logic;
signal rst_tb: std_logic;
signal clk_tb: std_logic;
signal q_tb: std_logic_vector (3 downto 0);
signal qn_tb: std_logic_vector (3 downto 0);


constant clk_period : time := 10 ns;
	
begin
	SR_0: sr_async
		port map(clk => clk_tb,
			 ce =>ce_tb,
			 reset => rst_tb,
			 d => d_tb,
			 q => q_tb,
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
	
	SR_process: process
	begin
		ce_tb <= '1'; rst_tb <= '0'; d_tb <= '1';	
		wait for clk_period/2;	
		ce_tb <= '1'; rst_tb <= '0'; d_tb <= '0';	
		wait for clk_period/2;	
		ce_tb <= '1'; rst_tb <= '1'; d_tb <= '0';
		wait for clk_period/2;		
		ce_tb <= '1'; rst_tb <= '0'; d_tb <= '0';	
		wait for clk_period/2;

		ce_tb <= '1'; rst_tb <= '0'; d_tb <= '1';	
		wait for clk_period/2;	
		ce_tb <= '1'; rst_tb <= '0'; d_tb <= '1';	
		wait for clk_period/2;	
		ce_tb <= '1'; rst_tb <= '1'; d_tb <= '1';	
		wait for clk_period/2;	
		ce_tb <= '1'; rst_tb <= '0'; d_tb <= '0';	
		wait for clk_period/2;			
			
	end process;

end structure_test;

