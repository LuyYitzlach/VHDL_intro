--this instantiates the seperate sorter instead of calling the function
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.array_setup.all;

entity sep_median is
generic (
	   numSize : integer := 33;
	   buffSize : integer := 6
		); 
port 	(
		inBuff : in buffArray(buffSize-1 downto 0)(numSize-1 downto 0);
		clock  : in std_logic;
		outBuff : out buffArray(buffSize-1 downto 0)(numSize-1 downto 0);
		median : out std_logic_vector (numSize-1 downto 0)
		); 
end sep_median;