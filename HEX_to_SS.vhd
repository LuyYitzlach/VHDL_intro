library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hexToSevenSegment is
    port(
        hexNumber : in std_logic_vector(7 downto 0); --8bit hex input
        --sevenSegmentActiveHigh : out std_logic_vector(6 downto 0);
        sevenSegmentActiveLow : out std_logic_vector(6 downto 0)
    );
end hexToSevenSegment;

architecture arch of hexToSevenSegment is 
    signal sevenSegment : std_logic_vector(6 downto 0);
begin
    with hexNumber select 
        sevenSegment <=       "1000000" when X"00", -- 0, active low i.e. 0:display & 1:no display
                              "1111001" when X"01", -- 1
                              "0100100" when X"02", -- 2
                              "0110000" when X"03", -- 3 
                              "0011001" when X"04", -- 4
                              "0010010" when X"05", -- 5
                              "0000010" when X"06", -- 6
                              "1111000" when X"07", -- 7
                              "0000000" when X"08", -- 8
                              "0010000" when X"09", -- 9
                              "0001000" when X"41", -- A
                              "0000011" when X"42", -- B
                              "1000110" when X"43", -- C
                              "0100001" when X"44", -- D
                              "0000110" when X"45", -- E
                              "0001110" when X"46", -- F
                              "0010000" when X"47", -- G
                              "0001001" when X"48", -- H
                              "1111001" when X"49", -- I
                              "1110001" when X"4A", -- J
                              "0001001" when X"4B", -- K
                              "1000111" when X"4C", -- L
                              "0001001" when X"4D", -- M
                              "0001001" when X"4E", -- N
                              "1000000" when X"4F", -- O
                              "0001100" when X"50", -- P
                              "0011000" when X"51", -- Q
                              "0101111" when X"52", -- R
                              "0010010" when X"53", -- S
                              "0000111" when X"54", -- T
                              "1000001" when X"55", -- U
                              "1100011" when X"56", -- V
                              "1001000" when X"57", -- W
                              "0001001" when X"58", -- X
                              "0010001" when X"59", -- Y
                              "0100100" when X"5A", -- Z
                              "0111111" when X"AA", -- dash
                              "1111111" when others; -- ALL OFF
    
    sevenSegmentActiveLow <= sevenSegment; -- Seven segment with Active Low
    --sevenSegmentActiveHigh <= not sevenSegment; -- Seven segment with Active High
end arch;                                            
