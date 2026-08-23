library IEEE;
use ieee.std_logic_1164.all;


entity D_FF is
  port(
    clk : in  std_logic;
    rst : in  std_logic;
    ce  : in  std_logic;
    d   : in  std_logic;
    q   : out std_logic;
    qn  : out std_logic
    );
end entity;


architecture DELAYED_2_3ns of D_FF is
  signal q_intern : std_logic;
begin
  process (clk, rst)
  begin
    if (rst = '0') then
      q_intern <= '0';
    elsif (rising_edge(clk)) then
      if (ce = '1') then
        q_intern <= d;
      end if;
    end if;
  end process;

  process (q_intern)
  begin
    q  <= q_intern     after 2 ns;
    qn <= not q_intern after 3 ns;
  end process;
end architecture;


architecture UNIT_DELAY of D_FF is
  signal q_intern : std_logic;
begin
  process (clk, rst)
  begin
    if (rst = '0') then
      q_intern <= '0';
    elsif (rising_edge(clk)) then
      if (ce = '1') then
        q_intern <= d;
      end if;
    end if;
  end process;

  process (q_intern)
  begin
    q  <= q_intern     after 2.5 ns;
    qn <= not q_intern after 2.5 ns;
  end process;
end architecture;
