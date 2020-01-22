--this is the median sort shell
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.array_setup.all;


entity median_sort_VHDL is
generic (
	   numSize : integer := 33;
	   buffSize : integer := 6
		); --omit in tb
port 	(
		inBuff : in buffArray(numSize-1 downto 0)(buffSize-1 downto 0);
		clock  : in std_logic;
		outBuff : out buffArray(numSize-1 downto 0)(buffSize-1 downto 0);
		median : out std_logic_vector (numSize-1 downto 0)
		); --separate by ; but no ; on last item in () –omit in tb
end median_sort_VHDL;

architecture arch of median_sort_VHDL is
--declarations (type, signal, record, constants, components)


--procedures and functions
begin
process
procedure sorting (
		signal toSortArray : in buffArray(numSize-1 downto 0)(buffSize-1 downto 0);
		signal sortedArray : out buffArray(numSize-1 downto 0)(buffSize-1 downto 0)
		) is
--signals for use within procedure
signal i,j,k : integer;
signal temp : std_logic_vector(numSize-1 downto 0);
signal temp_array : buffArray(numSize-1 downto 0)(buffSize-1 downto 0); 
begin
--put instructions for procedure here

	for k in buffSize/2 downto 1 loop
		for i in 0 to buffSize loop
			j <= i+k;
			if (j < buffSize-1) then
				if (temp_array(i) > temp_array(j)) then
				temp <= temp_array(i);
				temp_array(i) <= temp_array(j);
				temp_array(j) <= temp; --how does this work if it's synchronous?
				--temp_array(i) <= temp_array(j);
				--temp_array(j) <= temp_array(i);
				end if;
			end if;
		i <= i+1;
		end loop;
	k <= k-1;
	exit when (k = 0);
	end loop;
sortedArray = temp_array;
end sorting; --procedure ends
end process;

--processes, with their (local) variables
--instantiation/components (these could also be in declaration section)
--combinatorial expressions
temp_array <= toSortArray;
sorting(toSortArray => inBuff, sortedArray => outBuff);
median <= outBuff(2); --should really use division and flooring to find middle...
end arch;
