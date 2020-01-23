--this is the median sort shell
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.array_setup.all;


entity median_sort_VHDL is
generic (
	   numSize : integer := 33;
	   buffSize : integer := 6
		); --omit in tb
port 	(
		--inBuff : in buffArray(numSize-1 downto 0)(buffSize-1 downto 0);
		inBuff : in buffArray(buffSize-1 downto 0)(numSize-1 downto 0);
		clock  : in std_logic;
		--outBuff : out buffArray(numSize-1 downto 0)(buffSize-1 downto 0);
		outBuff : out buffArray(buffSize-1 downto 0)(numSize-1 downto 0);
		median : out std_logic_vector (numSize-1 downto 0)
		); --separate by ; but no ; on last item in () –omit in tb
end median_sort_VHDL;

architecture arch of median_sort_VHDL is
--declarations (type, signal, record, constants, components)
signal result_array : buffArray(buffSize-1 downto 0)(numSize-1 downto 0);  --variable or signal?
constant half : integer := buffSize/2;

--procedures and functions

function sorter ( --list input here
				signal inSort : in buffArray(buffSize-1 downto 0)(numSize-1 downto 0)
				)
		return buffArray is variable outSort : buffArray(buffSize-1 downto 0)(numSize-1 downto 0);

variable ii,jj,kk : integer := 0;
variable temp_array : buffArray(buffSize-1 downto 0)(numSize-1 downto 0);
variable temp : std_logic_vector(numSize-1 downto 0) := (others => '0');
constant half : integer := buffSize/2;

begin --sorter function
temp_array := inSort;
	for k  in  3 downto 1 loop --for k  in  half downto 1 loop
	kk := k;
		for i  in 0 to 5 loop --for i  in 0 to buffSize loop
			ii := i;
			jj := ii+kk;
			if (jj < buffSize-1) then
				if (temp_array(ii) > temp_array(jj)) then
					temp := temp_array(ii);
					--wait for 10 ns; --add?
					temp_array(ii) := temp_array(jj);
					temp_array(jj) := temp; 
				--temp_array(ii) <= temp_array(jj);
				--temp_array(jj) <= temp_array(ii);
				end if;
			end if;
				
		end loop;
	end loop;
outSort := temp_array;	
return outSort;
end sorter;

begin --begin architecture

function_call : process (clock)
begin
if (clock = '1') then
	result_array <= sorter(inSort => inBuff);
	median <= result_array(half);
	outBuff <= result_array;
end if;
end process;


end arch;










-- process (clock)
-- begin 
-- procedure sorting (
		-- signal toSortArray : in buffArray(numSize-1 downto 0)(buffSize-1 downto 0);
		-- signal sortedArray : out buffArray(numSize-1 downto 0)(buffSize-1 downto 0)
		-- ) is
--signals for use within procedure

--begin
----put instructions for procedure here
 

	-- for k  in  3 downto 1 loop --for k  in  half downto 1 loop
	-- kk <= k;
		-- for i  in 0 to 5 loop --for i  in 0 to buffSize loop
			-- ii <= i;
			-- jj <= ii+kk;
			-- if (jj < buffSize-1) then
				-- if (temp_array(ii) > temp_array(jj)) then
					-- temp <= temp_array(ii);
					-- wait for 10 ns; --add?
					-- temp_array(ii) <= temp_array(jj);
					-- temp_array(jj) <= temp; 
				-- temp_array(ii) <= temp_array(jj);
				-- temp_array(jj) <= temp_array(ii);
				-- end if;
			-- end if;
		--ii <= ii+1; --included in 0 to buffSize
		
		-- end loop;
	--kk <= kk-1; --included in half downto 1
	-- exit when (kk = 0);
	-- end loop;
	
	
--sortedArray = temp_array;
--end sorting; --procedure ends
-- end process;

-- fill_buffer : process (clock)
-- begin
	-- if (clock'event and clock = '1') then
		-- outBuff <= temp_array;
		-- median <= outBuff(half); --should really use division and flooring to find middle...
		-- temp_array <= inBuff;
	-- end if;
-- end process;


