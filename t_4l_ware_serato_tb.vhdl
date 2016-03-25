--SERATO, Mike Edward C.
--WARE, Angelica P.
--CMSC 132 T-4L

library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_alarm_system is
	constant MAX_COMB: integer := 64;
	constant DELAY: time := 10 ns;
end entity tb_alarm_system;

architecture tb of tb_alarm_system is

	signal alarm: std_logic;
	signal i: std_logic_vector(5 downto 0);
	
	component alarm_system is
			port (
				alarm: out std_logic;
				i: in std_logic_vector(5 downto 0));
	end component alarm_system;
	
begin --architecture

	UUT: component alarm_system port map(alarm, i);
	main: process is
	
			variable temp: unsigned(5 downto 0);
			variable expected_alarm: std_logic;
			variable error_count: integer := 0;
			
	begin --process
	
		report "start simulation";
		
		for count in 0 to 63 loop
			temp := TO_UNSIGNED(count, 6);
			i(5) <= std_logic(temp(5));
			i(4) <= std_logic(temp(4));
			i(3) <= std_logic(temp(3));
			i(2) <= std_logic(temp(2));
			i(1) <= std_logic(temp(1));
			i(0) <= std_logic(temp(0));
			
			if(count<9 or count mod 8=0) then
				expected_alarm := '0';
			else
				expected_alarm := '1';
			end if;
			
			wait for DELAY;
			
			assert((expected_alarm = alarm))
				report "ERROR: Expected alarm " &
					std_logic'image(expected_alarm) &
					" at time " & time'image(now);
				
			if  (expected_alarm /= alarm)
				then error_count := error_count + 1;
			end if;
		end loop;
		
		wait for DELAY;

		assert (error_count = 0)
			report "ERROR: There were " &
				integer'image(error_count) & " errors!";
			if(error_count = 0)
				then report "Simulation completed with NO errors.";
			end if;
		wait;
	end process;
end architecture tb;
