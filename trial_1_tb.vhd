library ieee;
use ieee.std_logic_1164.all; --for std_logic and std_logic_vector
use ieee.numeric_std.all; --for signed and unsigned


entity trial_1_tb is
--generic ()_;
--port (); 
end trial_1_tb;


architecture tb of trial_1_tb is

--declarations (type, signal, record, constants, components)
signal reg_select : std_logic_vector (2 downto 0);
signal reg_clock : std_logic;
signal wire_out : std_logic;
signal period : time := 20 ns;
--component selector
--port (
--    in_select : in std_logic_vector (2 downto 0);
--    clock : in std_logic;
--    out_data : out std_logic);
--end component;

-----
begin
-----
UUT : entity work.selector
  port map (in_select => reg_select,
            clock => reg_clock,
           out_data => wire_out);
-----
timer : process
--constant period : time := 20 ns;
    begin
        reg_clock <= '0';
        wait for period/2;
        reg_clock <= '1';
        wait for period/2;
    end process;

functionality : process
   --constant period : time := 20 ns;

--   UUT : selector 
--   port map (in_select => reg_select,
--             clock => reg_clock,
--             out_data => wire_out);
-----
begin
-----
--prints message if condition is false
reg_select <= "001";
wait for period;
assert ((reg_select = "001") and (wire_out = '1'))
report "test failed for input 001" severity error;
-----
reg_select <= "010";
wait for period;
assert ((reg_select = "010") and (wire_out = '1'))
report "test failed for input 010" severity error;
-----
reg_select <= "000";
wait for period;
assert ((reg_select = "000") and (wire_out = '1'))
report "test passed for test" severity error;
-----
reg_select <= "101";
wait for period;
assert ((reg_select = "101") and (wire_out = '1'))
report "test failed for input 101" severity error;

wait;
end process;
end tb;


