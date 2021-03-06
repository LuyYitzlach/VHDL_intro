--template cheat sheeet

--Part to always include:
--1. Libraries
--2. Entity (first generics. then ports. if it's TB then no ports)
--3. Architecture
--  (3a). Declarations before the 'begin' (type,signal,record,constants)
--	begin
--  (3b). Combinatorial processes
--  (3c). Sequential processes
--  (3d). Instantiations/components
--  (3e). combinatorial expressions outside of processes

--------------------------------
library ieee;
use ieee.std_logic_1164.all; --for std_logic and std_logic_vector
use ieee.numeric_std.all; --for signed and unsigned
--textio --for read write line text... non synthesizable
--------------------------------
entity example_module is

  generic (
      J: integer := 3; -- define more generics here
      M: std_logic := '1' 
  );

  port (
    clk : in std_logic;
    port_1 : in std_logic;
    port_2 : in std_logic_vector (J-1 downto 0);
    port_3 : out integer range 0 to 5 --no ; by last one 
--  port_4 : signed 
--  port_5 : unsigned
--  port_5 : natural
--  port_6 : time
--  port_7 : string
--  port_8 : bit
--  port_9 : boolean 
  );
end example_module;
--------------------------------
--name the architecture (example arch_1) because there can be more than one architecture
architecture arch_1 of example_module is 

--**************--
  --before the "begin" you can declare types, signals, constants,
  --signals are used as 'wires' between the ports
  --no variables here unless they are defined as a 'shared variable'

  --simulator (not compiler) throws an error if integer not in range
  type example_integer_type is range 10 downto 0; 
  signal int1, int2 : example_integer_type := 0;

  type example_enumerated_type is (state1, state2, state3);
  signal state_reg, state_next : example_enumerated_type;

  type newArray is array (0 to 1) of std_logic; -- create Array for list of same data type
  signal arrValue : newArray; -- signal of Array type
  --access the individual elements in an array like this: arrValue(0) <= a;
    
  type newRecord is -- create Record for list of different data types
  record
        d1, d2 : std_logic;
        v1, v2: std_logic_vector(1 downto 0);
  end record; 
  signal recordSample : newRecord; -- signal of Record type
  --access elements in an array like this: recordSample.d1 <= a;

--**************--
  -- assign zero to constant 'a' i.e a = 0000
  constant a : std_logic_vector(3 downto 0) := (others => '0');

  --constant to remove hard literal
  constant N : integer := 3;  -- define constant
  signal x : std_logic_vector(N downto 0); -- use constant
  signal y : std_logic_vector(2**N downto 0); -- use constant

  -- assign signal 'b' = "0011"
  -- position 0 or 1 = 1, rest 0
  signal b : std_logic_vector(3 downto 0) := (0|1=>'1', others => '0');

  -- assign signal 'c' = "11110000"
  -- position 7 downto 4 = 1, rest 0
  signal c_1 : std_logic_vector(7 downto 0) := (7 downto 4 =>'1', others => '0'); 
  -- or
  signal c_2 : std_logic_vector(7 downto 0) := (4 to 7 =>'1', others => '0');
  -- (7 downto 0) means 7th bit is MSB
  -- (0 to 7) means the 0th bit is the MSB

  -- assign signal 'd' = "01000"
  -- note that d starts from 1 and ends at 5, hence position 2 will be 1.
  signal d : std_logic_vector(1 to 5) := (2=>'1', others => '0');

  signal e : std_logic := '0'; --to define starting value
  signal f : std_logic; --declare without starting value

--**************--

begin
  --can have expressions outside a process. can use signals outside but not variables
  port_3 <= to_integer(unsigned(d));

--**************--
--can instantiate another module either using the component or else using work.name
--	example using component


--	example using work.name:
--      compare4bit: entity work.genericEx
--        generic map (N => 4) -- generic mapping for 4 bit
--        port map (a=>x, b=>y, eq=>z); -- port mapping



--**************--
  --can have comb or seq processes
  process(clk) --sensitivity list in the ()
  
  --if using a variable in the process, define it before the begin
  variable v : std_logic := '0';

  begin
    if(clk'event and clk='1') then

      state_reg <= state1;
      f <= '1';
      e <= f; -- e will be '1' in the next clock cycle because f is signal (reg)

      

    else
      state_reg <= state2;
      v := '1';
      e <= v; -- e will be '1' immediately because v is a variable (wire)
    end if;

  end process;
--**************--
end arch_1;


--------------------------------
--NOTES:
-- 7 logical boolean operators:  not, and, nand, or, nor, xor, xnor
-- 6 relational operators: = , > , < , >= , <= , and /= (i.e. not equal to)
-- concatination is done with the ampersand &
-- 3 assignment operators are: 
--	<= (assign value to signal), 
--	:= (assign value to variable -or- assign initial value to signal or variable
--	=> assign values using 'others'   ??and map ports and ??
-- arithmetic operators are: + , - , * , / , ** (to power of), abs, rem (sign of 1st), mod (sign of 2nd)
-- 	arithmetic must be done on same data type. use type casting if needed.
-- SLL (shift left logic) and SRL (shift right logic) can only be used with bit vector

--*-*-*-*-*-type casting-*-*-*-*-*--
-- unsigned(a) .... if originally signed or std_logic_vector
-- signed(a) .... if originally unsigned or std_logic_vector
-- std_logic_vector(a) .... if originally signed or unsigned
-- to_integer(a) .... if originally signed, unsigned
-- to_signed(a, size_number_of_bits) .... if originally integer
-- to_unsigned(a, size_number_of_bits) .... if originally natural
--*-*-*-*-*-             -*-*-*-*-*--
-- natural and positive are subtypes of integer and all three can do mod arithmetic
-- might have to type cast twice if no direct conversion available

-- Attribute ?event? is set to ?1? whenever there is any change in the signal
-- Attribute ?image? is used for string representation of integers, natural and std_logic_vector etc.
-- Attribute ?range? can be used for iterating over all the test-data using for-loop in the testbenches.
-- predefined attributes available in VHDL e.g. 'low', 'high', 'active','length' and 'reverse range' etc.
-- we can create custom attribute as well.

-- for sequential: if, case, loop, wait
--	if s = "00" then    y <= i0; elsif s = "01" then y <= i1; ... end if;
--	case s is   when "00" =>   y <= i0; when "01" =>   y <= i1; ... end case;
--	caution with loops
--	'wait until' waits for condition to be met (synth), ...
--		'wait on' waits for the signal to change (synth), ...
--		'wait for' waits for specified time (not synth)

-- for combinatorial: when-else, with-select, generate
--	 y <= i0 when s = "00" else ...
--	 with s select     y <=  i0 when "00", i1 when "01", ... unaffected when others;
--	 caution with generate

-- delays: delta delay and 'after' ==not synthesizable though

-- to prevent unintended latches follow these rules:
--	Include all the input signals related to combinational designs in the sensitivity list of process statement.
--	Always define the ?else? block in ?if statement? and ?others? block in ?case? statement.
--	Assign all outputs inside every block of statements e.g define all outputs inside every 'elseif'
--	block of ?if-else? statement and inside every ?when? block of ?case? statement etc.
