----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2024 11:08:46 AM
-- Design Name: 
-- Module Name: full_adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity full_adder is
    Port ( c_in : in STD_LOGIC;
           b : in STD_LOGIC;
           a : in STD_LOGIC;
           c_out : out STD_LOGIC;
           sum : out STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is

 signal sig_sum0_a1 : std_logic;  -- From sum0 to a1
 signal sig_carry0  : std_logic;
 signal sig_carry1  : std_logic;


  signal sig_c0 : std_logic;
  signal sig_c1 : std_logic;
  signal sig_c2 : std_logic;

begin

--half_adder0 : entity work.half_adder
--    port map (
--     a     => a,
--     b     => b,
--     sum   => sig_sum0_a1,
--     carry => sig_carry0
--    );

  --------------------------------------------------------
  -- Instance (copy) of the second half adder
--  half_adder1 : entity work.half_adder
--    port map (
--      a     => sig_sum0_a1,
--      b     => c_in,
--      sum   => sum,
--      carry => sig_carry1
--    );

  -- Output carry
-- carry <= sig_carry0 or sig_carry1;



end architecture behavioral;

--end Behavioral;
