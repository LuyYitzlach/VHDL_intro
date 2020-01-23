library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity variable_vs_signal_tb is
end variable_vs_signal_tb;
 
architecture behave of variable_vs_signal_tb is
 
  constant c_CLK_PERIOD : time := 10 ns;
 
  signal r_Clock    : std_logic := '0';
  signal w_Var_Done : std_logic;
  signal w_Sig_Done : std_logic;
 
  component variable_vs_signal is
    port (
      i_clk      : in  std_logic;
      o_var_done : out std_logic;
      o_sig_done : out std_logic
      );
  end component variable_vs_signal;
   
begin
 
  r_Clock <= not r_Clock after c_CLK_PERIOD/2;
   
  variable_vs_signal_inst : variable_vs_signal
    port map (
      i_clk      => r_Clock,
      o_var_done => w_Var_Done,
      o_sig_done => w_Sig_Done
      );
   
end behave;