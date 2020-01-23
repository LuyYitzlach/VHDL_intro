--test bench for bufferVHDL and median_sort_VHDL entities

library ieee;
use ieee.std_logic_1164.all; --for std_logic and std_logic_vector
use ieee.numeric_std.all; --for signed and unsigned

entity median_tb_VHDL is
end median_tb_VHDL;

architecture arch_name of median_tb_VHDL is
--declarations (type, signal, record, constants, components)
constant T : time := 20 ns;
constant numSize : integer := 33;
constant buffSize : integer := 6;
signal clock, reset : std_logic;
signal inVec, o_median : std_logic_vector (numSize-1 downto 0) := (others => '0');

--procedures and functions
begin
--processes, with their (local) variables
continuous_clock : process
    begin
        clock <= '0';
        wait for T/2;
        clock <= '1';
        wait for T/2;
    end process;
	
inputs : process
begin
inVec <= std_logic_vector(to_unsigned(3,33)); --want to use integer and pass to std_logic_vector
--inVec <= "000000000000000000000000000000001";
--wait for T;
inVec <= std_logic_vector(to_unsigned(9,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(2,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(7,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(10,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(52,33));
wait for T;
--assert (o_median = 
inVec <= std_logic_vector(to_unsigned(4,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(7,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(1,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(6,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(11,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(11,33));
wait for T;
--assert (o_median = 
inVec <= std_logic_vector(to_unsigned(3,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(9,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(2,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(7,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(10,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(52,33));
wait for T;
--assert (o_median = 
inVec <= std_logic_vector(to_unsigned(4,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(7,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(1,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(6,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(11,33));
wait for T;
inVec <= std_logic_vector(to_unsigned(11,33));
wait for T;
--assert (o_median = 

end process;

--instantiation/components (these could also be in declaration section)
tb_instance : entity work.bufferVHDL
generic map (numSize => numSize, buffSize => buffSize)
port map (
   clock  	=> clock,
   reset   	=> reset,
   i_Buff  	=> inVec,
   o_median => o_median
);
--combinatorial expressions
reset <= '1', '0' after T/2;

end arch_name;
