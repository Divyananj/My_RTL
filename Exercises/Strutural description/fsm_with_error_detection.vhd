LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_error_detec is
  port(
    data_in,start_stop,clk,rst: in std_logic;
    valid_stream,ce: out std_logic
  );
end entity;


architecture BEHAVIOUR of fsm_error_detec is
	type state_fsm is (idle,zero, less_eight1, less_eight2, max_nine,eight1,eight2,twelve,greater_nine);
signal current_state, next_state: state_fsm;
begin
  sync: process(clk,rst)
  begin
	if rst = '1' then
	  current_state <= idle;
	elsif rising_edge(clk) then
	  current_state <= next_state;
	end if;
  end process;
   
  next_logic:process(current_state, next_state, data_in)
  begin
    next_state <= current_state;
    if current_state /= idle and start_stop = '1' then
	next_state <= idle;
    else
       case current_state is
           when idle =>
             if start_stop = '1' then
		next_state <= zero;
	     else 
		next_state <= idle;
	     end if;
	    when zero =>
             if data_in= '0' then
		next_state <= less_eight1;
	     else 
		next_state <= eight1;
	     end if;
	    when less_eight1 =>
		next_state <= less_eight2;
	    when less_eight2 =>
		next_state <= max_nine;
	    when eight1 =>
             if data_in= '0' then
		next_state <= eight2;
	     else 
		next_state <= twelve;
	     end if;
	    when eight2 =>
             if data_in= '0' then
		next_state <= max_nine;
	     else 
		next_state <= greater_nine;
	     end if;
	    when twelve =>
	        next_state <= greater_nine;
	    when max_nine =>
	        next_state <= zero;
	    when greater_nine =>
	        next_state <= zero;
	   		   		
       end case;
     end if;
    end process;
    
  out_gen:process(current_state,start_stop)
  begin
  	valid_stream <= '0';
	ce <= '0';
  if current_state /= idle and start_stop = '1' then
  	valid_stream <= '0';
	ce <= '0';
  else
    case current_state is
	when idle =>  	     valid_stream <= '0';ce <= '0';      
	when zero =>         valid_stream <= '0';ce <= '1';  
	when less_eight1 =>  valid_stream <= '0';ce <= '1';
	when less_eight2 =>  valid_stream <= '0';ce <= '1';
	when max_nine =>     valid_stream <= '1';ce <= '1';
	when eight1 =>       valid_stream <= '0';ce <= '1';
	when eight2 =>       valid_stream <= '0';ce <= '1';
        when twelve =>       valid_stream <= '0'; ce <= '0';
        when greater_nine => valid_stream <= '0'; ce <= '0';
    end case;
   end if;
  end process;
end architecture;   
