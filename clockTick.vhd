library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clockTick is 
    -- M = 5000000, N = 23 for 0.1 s
    -- M = 50000000, N = 26 for 1 s
    -- M = 500000000, N = 29 for 10 s
    
    generic (M : integer := 5;  -- generate tick after M clock cycle
                N : integer := 3); -- -- N bits required to count upto M i.e. 2**N >= M
    port(
        clk, reset: in std_logic;
        clkPulse: buffer std_logic --Quartus suggestion
    );
end clockTick;

architecture arch of clockTick is 
   
signal count_reg : unsigned(N-1 downto 0);

begin
process (clk, reset)
begin
if reset = '1' then
   clkPulse <= '0';
   count_reg <= (others => '0');
elsif (clk'event and clk = '1') then
     if count_reg = (M/2)-1 then
        clkPulse <= not clkPulse;
        count_reg <= (others => '0');
     else 
        clkPulse <= clkPulse;
        count_reg <= count_reg+1;
     end if; 
end if;
end process;
              
end arch;

--count_next <= "1" when count_reg = "0" else
--              (others => '0') when ((count_reg <= (M/2)-1) or count_reg = M) else
--              (count_reg+1) when (count_reg >= (M/2) and count_reg < M);
  
--signal count_reg, count_next : unsigned(N-1 downto 0);
--signal clk_next : std_logic := '0';

--begin
--    process(clk, reset)
--    begin
--        if reset = '1' then 
--            count_reg <= (others=>'0');
--            clkPulse <= '0';
--        elsif   clk'event and clk='1' then
--            count_reg <= count_next;
--            clkPulse <= clk_next;
--        end if;
--    end process;
    
    -- set count_next to 0 when maximum count is reached i.e. (M-1)
    -- otherwise increase the count
    --count_next <= (others=>'0') when count_reg=(M-1) else (count_reg+1);
--    count_next <= (others=>'0') when count_reg=(M) else (count_reg+1);
    
    -- Generate 'tick' on each maximum count
    --clkPulse <= '1' when count_reg = (M-1) else '0';
--    clk_next <= not clk_next when count_reg = (M-1);

--end arch;

