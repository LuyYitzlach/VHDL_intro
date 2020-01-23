--having trouble using the function because i can't seem to see it's variables in simulation and don't know what is the problem.
--going to try to use a seperate entity instead of the function
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.array_setup.all;

entity sep_sorter is
generic (
	   numSize : integer := 33;
	   buffSize : integer := 6
		); 
port 	(
		inBuff : in buffArray(buffSize-1 downto 0)(numSize-1 downto 0);
		clock  : in std_logic;
		outBuff : out buffArray(buffSize-1 downto 0)(numSize-1 downto 0);
		s_median : out std_logic_vector (numSize-1 downto 0)
		);
end sep_sorter;

architecture arch of sep_sorter is
signal ii,jj,kk : integer := 0;
signal temp_array : buffArray(buffSize-1 downto 0)(numSize-1 downto 0);
signal temp : std_logic_vector(numSize-1 downto 0) := (others => '0');
constant half : integer := buffSize/2;

begin
process (clock) --do this as synch?
begin
if (clock = '1') then
temp_array <= inBuff;
	for k  in  3 downto 1 loop --for k  in  half downto 1 loop
	kk <= k;
		for i  in 0 to 5 loop --for i  in 0 to buffSize loop
			ii <= i;
			jj <= ii+kk;
			if (jj < buffSize-1) then
				if (temp_array(ii) > temp_array(jj)) then
					--temp <= temp_array(ii);
					--wait for 10 ns; --add?
					--temp_array(ii) <= temp_array(jj);
					--temp_array(jj) <= temp; 
				temp_array(ii) <= temp_array(jj);
				temp_array(jj) <= temp_array(ii);
				end if;
			end if;
				
		end loop;
	end loop;
outBuff <= temp_array;	
s_median <= temp_array(half);
end if;
end process;
end arch;

