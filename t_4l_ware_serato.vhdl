--SERATO, Mike Edward C.
--WARE, Angelica P.
--CMSC 132 T-4L

library IEEE;
use IEEE.std_logic_1164.all;

entity alarm_system is
	port(
		alarm: out std_logic; 
	    i: in std_logic_vector(5 downto 0));
end entity alarm_system;

architecture behav of alarm_system is
begin
	process (i(5), i(4), i(3), i(2), i(1), i(0)) is 
	begin
		if((i(5)='1' or i(4)='1' or i(3)='1') and
			(i(2)='1' or i(1)='1' or i(0)='1'))
			then alarm <= '1';
		else
			alarm <= '0';
		end if;
	end process;
end architecture behav;