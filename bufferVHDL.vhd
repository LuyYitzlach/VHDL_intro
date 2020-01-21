--copying buffer module from verilog to vhdl

library ieee;
use ieee.std_logic_1164.all; --for std_logic and std_logic_vector
use ieee.numeric_std.all; --for signed and unsigned

entity bufferVHDL is
generic (
   numSize : integer := 33;
   buffSize : integer := 6
         );
port (
   clock    : in std_logic;
   reset   : in std_logic;
   inBuff   : in std_logic_vector (numSize-1 downto 0);
   o_median : out std_logic_vector (numSize-1 downto 0)
      ); --separate by ; but no ; on last item in () –omit in tb
end bufferVHDL;

architecture arch_name of bufferVHDL is
--declarations (type, signal, record, constants, components)
type Buff is array (numSize-1 downto 0) of std_logic_vector (numSize-1 downto 0);
signal tempInBuff, tempOutBuff : Buff;

signal median, outWire : std_logic_vector (numSize-1 downto 0);
signal count : integer; --reg signed [numSize-1:0] count; 
signal sortnow : std_logic;

--procedures and functions
begin
--processes, with their (local) variables
--instantiation/components (these could also be in declaration section)
-- MSB: entity work.median_sort_VHDL
-- generic map (module_M=>current_entity_M, module_N=>current_entity_N)
-- port map (clk=>clk, reset=>reset, complete_tick=>clkPulse);

fillBuff : process (clock, reset)
begin
	if (reset) then
		count <= 0;
	elsif (count < (buffSize-1)) then
		tempInBuff(count) <= inBuff;
		count <= count +1;
	elsif (count < buffSize) then
		tempInBuff(count) <= inBuff;
		count <= 0;
	end if;
end process;

enable : process
begin
	if (count = 0) then
		sortnow <= '1';
	else
		sortnow <= '0';
	end if;
end process;

set_output : process
begin
outWire <= tempOutBuff(count);
o_median <= median;
end process;

--combinatorial expressions
end arch_name;


