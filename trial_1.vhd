library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity selector is
generic (
    N : integer := 2 );
port (
    in_select : in std_logic_vector (N downto 0);
    clock : in std_logic;
    out_data : out std_logic);
end selector;

architecture arch_sel of selector is


begin

synchronousProc : process(clock)
begin
    if (clock'event and clock = '1') then
       if (in_select = "001") then out_data <= '1';
         elsif (in_select = "010") then out_data <= '1';
         elsif (in_select = "101") then out_data <= '1';
         elsif (in_select = "111") then out_data <= '1';
         else out_data <= '0';
       end if;
    end if;
end process;

end arch_sel;

--procedure or function?

--signal out_reg, out_next : std_logic := '0';

--synchronousProc : process(clock)
--begin
--    if (clock'event and clock = '1') then
--       out_reg <= out_next;
--    end if;
--end process;

--out_next <= '1' when in_select = "001";
--out_next <= '1' when in_select = "010";
--out_next <= '1' when in_select = "101";
--out_next <= '1' when in_select = "111";
--out_next <= '0' when in_select = "000";
--out_next <= '0' when in_select = "011";
--out_next <= '0' when in_select = "100";
--out_next <= '0' when in_select = "110";

           

--combinatorialProc : process() --in_select
--begin
--    out_next <= 
--               '1' when in_select = "001" -- ("001" | "010" | "101" | "111")
--    else       '0';
--end process;


--Illegal concurrent statement.
--case to_integer(unsigned(in_select)) is
--when "001" => out_next <= '1';
--when "010" => out_next <= '1';
--when "101" => out_next <= '1';
--when "111" => out_next <= '1';
--when others => out_next <= '0';
--end case;


--Choice in selected signal assignment must be locally static.
--with in_select select
--out_next <= '1' when in_select "001",
--            '1' when in_select "010",
--            '1' when in_select "101",
--            '1' when in_select "111",
--            '0' when others;

--if (in_select = "001") then
--out_next <= '1';
--else
--out_next <= '0';
--end if;
    
--out_data <= out_reg;


