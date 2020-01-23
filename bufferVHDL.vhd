--copying buffer module from verilog to vhdl

library ieee;
use ieee.std_logic_1164.all; --for std_logic and std_logic_vector
use ieee.numeric_std.all; --for signed and unsigned
use work.array_setup.all;

entity bufferVHDL is
generic (
   numSize : integer := 33;
   buffSize : integer := 6
         );
port (
   clock    : in std_logic;
   reset   : in std_logic;
   i_Buff   : in std_logic_vector (numSize-1 downto 0);
   o_median : out std_logic_vector (numSize-1 downto 0)
      ); --separate by ; but no ; on last item in () –omit in tb
end bufferVHDL;

architecture arch_name of bufferVHDL is
--declarations (type, signal, record, constants, components)
--wants me to use the package array instead?
--**
--signal tempInBuff, tempOutBuff : buffArray(numSize-1 downto 0)(buffSize-1 downto 0);
--** 
signal tempInBuff, tempOutBuff : buffArray(buffSize-1 downto 0)(numSize-1 downto 0);
--type Buff is array (numSize-1 downto 0) of std_logic_vector (numSize-1 downto 0);
--signal tempInBuff, tempOutBuff : Buff;
signal median : std_logic_vector (numSize-1 downto 0);
--signal median, outWire : std_logic_vector (numSize-1 downto 0);
signal count : integer := 0; --reg signed [numSize-1:0] count; 
signal sortnow : std_logic;

--***
begin

--instantiation of median sorter
MSB: entity work.median_sort_VHDL
generic map(
	   numSize => numSize, buffSize => buffSize)
port map ( 
		inBuff => tempInBuff,
		clock  => clock,
		outBuff => tempOutBuff,
		median => median
		); --separate by ; but no ; on last item in () –omit in tb

--processes
fillBuff : process (clock, reset)
begin
	if (reset = '1') then
		count <= 0;
	elsif (clock = '1') then
		if (count < buffSize-1) then
			tempInBuff(count) <= i_Buff;
			count <= count +1;
		elsif (count < buffSize) then
			tempInBuff(count) <= i_Buff;
			count <= 0;
		end if;
	end if;
end process;

enable : process
begin
	if (count = 0) then
		sortnow <= '1';
	else
		sortnow <= '0';
	end if;
wait for 10 ns; --it's warning me of possible infinite loop
end process;

set_output : process
begin
--outWire <= tempOutBuff(count);
--o_median <= median;
median <= tempInBuff(buffSize/2);
o_median <= median;
wait for 10 ns; --it's warning me of possible infinite loop
end process;

--combinatorial expressions
end arch_name;


