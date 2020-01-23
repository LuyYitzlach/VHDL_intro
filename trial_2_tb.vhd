library ieee;
use ieee.std_logic_1164.all; --for std_logic and std_logic_vector
use ieee.numeric_std.all; --for signed and unsigned

entity vend_tb is
end vend_tb;

architecture arch_vend of vend_tb is

--declarations
constant period : time := 20 ns;
signal clock_50 : std_logic :='0';
signal reset : std_logic;
signal add_one : std_logic := '0';
signal add_five : std_logic := '0';
signal choose_soda : std_logic := '0';
signal choose_chips : std_logic := '0';
signal get_change : std_logic := '0';
signal ready2vend : std_logic;
signal ready4money : std_logic;
signal too_much : std_logic;
signal HEX5, HEX4, HEX3, HEX2, HEX1, HEX0 : std_logic_vector (6 downto 0);
signal error : std_logic;
signal decimal : std_logic;

begin
vend_instance : entity work.vending
port map( 
      clock_50 => clock_50,
      reset => reset,
      add_one => add_one,
      add_five => add_five,
      choose_soda => choose_soda,
      choose_chips => choose_chips,
      get_change => get_change,
      ready2vend => ready2vend,
      ready4money => ready4money,
      too_much => too_much ,
      HEX5 => HEX5,
      HEX4 => HEX4,
      HEX3 => HEX3,
      HEX2 => HEX2,
      HEX1 => HEX1,
      HEX0 => HEX0,
      error => error,
      decimal => decimal
      );

----------------------------------
trial : process
begin
wait for period;
add_one <= '1';
wait for period;
wait for period; --$2
add_one <= '0';
wait for period;
--**
assert (ready2vend = '1')
report "test failed for add_one input" severity note;
--**

add_five <= '1';
wait for period; --$7
wait for period; --$12 too much
add_five <= '0';
wait for period;
--**
assert (too_much = '1')
report "test failed for add_one input" severity note;
--**

choose_soda <= '1';
wait for period; --$7

choose_soda <= '0';
choose_chips <= '1';
wait for period; --$5

choose_chips <= '0';

wait for period;

get_change <= '1';
wait for period; --$0

get_change <= '0';
wait for period; --$0
--**
assert (ready2vend = '0')
report "test failed for get_change input" severity note;
--**

end process;

---------------------------------------
clock : process
begin
clock_50 <= not clock_50;
wait for period/2;
end process;
---------------------------------------
reset <= '1', '0' after period;

end arch_vend;


