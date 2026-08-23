library IEEE;
use ieee.std_logic_1164.all;


entity shiftreg_gen is
  generic(size_reg : natural := 4);
  port(
    clk, rst, ce, data_in : in  std_logic;
    q, qn                 : out std_logic_vector(3 downto 0)
    );
end entity;
architecture BEHAVIOUR of shiftreg_gen is

component D_FF
  port (
    clk : in  std_logic;
    rst : in  std_logic;
    ce  : in  std_logic;
    d   : in  std_logic;
    q   : out std_logic;
    qn  : out std_logic
    );
end component;

  signal q_intern : std_logic_vector(3 downto 0);
begin
D_FF_G: for k in 0 to size_reg-1 generate
	Logic1: if k=0 generate
  	  D_0: D_FF
          port map(
            clk => clk ,
   	    rst => rst,
    	    ce  => ce,
    	    d   => data_in,
    	    q   => q_intern(0),
    	    qn  => qn(0)
    	   );
	  end generate;
 	Logic2: if k > 0 and k <= size_reg generate
	  D_k: D_FF
          port map(
            clk => clk ,
   	    rst => rst,
    	    ce  => ce,
    	    d   => q_intern(2*(k-1)),
    	    q   => q_intern(2*k-1),
    	    qn  => qn(k)
    	   );
	  end generate;
     end generate;
end architecture;

configuration config_shift_ref of shiftreg_gen is
  for BEHAVIOUR
     for D_FF_G
	for logic1
	  for D_0: D_FF use
	    entity work.D_FF(DELAYED_2_3ns);
	  end for;
        end for;
	for Logic2
	   for D_k: D_FF use
             entity work.D_FF(DELAYED_2_3ns);
	   end for;
        end for;
      end for;
   end for;
end configuration;
