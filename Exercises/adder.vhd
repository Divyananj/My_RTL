
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; --for this (17)unsigned type change

entity ADDER is -- declaring all the inputs and outputs
	port( A: in std_logic_vector(3 downto 0);
	      B: in std_logic_vector(3 downto 0);
	      carry: out std_logic;
              sum: out std_logic_vector(3 downto 0) --cannot put semicolon after declaration of last port
	      );
end ADDER;

architecture behv of ADDER is
	signal result: std_logic_vector(4 downto 0); -- local to this vhdl code , not global
begin
	result <= std_logic_vector(unsigned('0' & A)+unsigned('0' & B));

		-- quotes must be'' this
		-- 5 bit because maximum sum will be 4 bit sum and 1 bit carry
		-- making concatination to A and B to match the result 5 bit
	
	sum <= result(3 downto 0);
	carry <= result(4);
end behv;