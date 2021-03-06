--test bench for the frequncy divider

library ieee;
use ieee.std_logic_1164.all; --for std_logic and std_logic_vector
use ieee.numeric_std.all; --for signed and unsigned

entity tick_tb is
end tick_tb;

architecture arch_tick_tb of tick_tb is
--declarations (type, signal, record, constants, components)
--constant M : integer := 50000000;
constant M : integer := 10;
constant N : integer := 26;
constant period : time := 20 ns; --50Hz

signal clk_50 : std_logic := '0';
signal clk_1 : std_logic; --set starting value for output?
signal reset : std_logic;

--procedures and functions
begin
--processes, with their (local) variables
--instantiation/components (these could also be in declaration section)
tick_test : entity work.clockTick
generic map (M => M, N => N)
port map ( clk => clk_50, reset => reset, clkPulse => clk_1);

sim_clock : process
begin
--wait for period/2;
--clk_50 <= not clk_50;
clk_50 <= '0';
wait for period/2;
clk_50 <= '1';
wait for period/2;
end process;

--combinatorial expressions
reset <= '1', '0' after period;

end arch_tick_tb;
