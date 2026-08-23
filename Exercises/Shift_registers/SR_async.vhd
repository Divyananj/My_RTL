library ieee;
use ieee.std_logic_1164.all;

--Declaring ports of Shift register
entity sr_async is
	port( d: in std_logic;
	      ce: in std_logic;
	      reset: in std_logic;
	      clk: in std_logic;
	      q: out std_logic_vector (3 downto 0);
	      qn: out std_logic_vector (3 downto 0)
	     );
end entity;

architecture structure of sr_async is
---I am initiating d_ff component (from d_ff vhdl file here)
component d_ff_async is
	port( d: in std_logic;
	      ce: in std_logic;
	      reset: in std_logic;
	      clk: in std_logic;
	      q: out std_logic;
	      qn: out std_logic
	     );
end component;
signal s: std_logic_vector(3 downto 0);

-------------mapping all ports and signals as required to dff component-------
begin
	d_ff_0: d_ff_async
		port map(clk => clk,
			 ce =>ce,
			 reset => reset,
			 d => d,
			 q => s(3),
			 qn => qn(3)	
			);
	d_ff_1: d_ff_async
		port map(clk => clk,
			 ce =>ce,
			 reset => reset,
			 d => s(3),
			 q => s(2),
			 qn => qn(2)
			);
	d_ff_2: d_ff_async
		port map(clk => clk,
			 ce =>ce,
			 reset => reset,
			 d => s(2),
			 q => s(1),
			 qn => qn(1)
			);
	d_ff_3: d_ff_async
		port map(clk => clk,
			 ce =>ce,
			 reset => reset,
			 d => s(1),
			 q => s(0),
			 qn => qn(0)	
			);
	q <= s;
end structure;

