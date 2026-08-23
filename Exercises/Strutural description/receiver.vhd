library IEEE;
use ieee.std_logic_1164.all;

entity receiver is
  port(
    data_in, start_stop, clk, rst : in  std_logic;
    q                             : out std_logic_vector(3 downto 0);
    valid_stream                  : out std_logic
    );
end entity;

architecture BEHAVIOUR of receiver is


  component shiftreg_gen is
    generic(size_reg : natural := 4);
    port(
      clk, rst, ce, data_in : in  std_logic;
      q, qn                 : out std_logic_vector(size_reg-1 downto 0)
      );
  end component;


  component fsm_error_detec is
    port(
      data_in, start_stop, clk, rst : in  std_logic;
      valid_stream, ce              : out std_logic
      );
  end component;

  signal reg_en               : std_logic;
  signal valid_stream_delayed : std_logic;
  signal valid_stream_current : std_logic;

begin

 I_shiftregister: shiftreg_gen
      	port map(
	   clk => clk,
	   rst => rst,
	   ce => reg_en,
           data_in => data_in,
	   q => q
	);

 I_FSM: fsm_error_detec
	port map(
           data_in => data_in,
           start_stop => start_stop,
           clk => clk,
	   rst => rst,
	   valid_stream => valid_stream_current,
	   ce => reg_en
        );	     


  process(clk, rst)  
	begin
	   if rst= '0' then
	      valid_stream_delayed <= '0';
	   elsif rising_edge(clk) then
               valid_stream_delayed <= valid_stream_current;
	   end if;	      
  end process;
  valid_stream <= valid_stream_delayed;
end architecture;

