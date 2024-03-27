----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2024 11:57:28 AM
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
    Port ( SW_B : in STD_LOGIC_VECTOR (3 downto 0);
           SW_A : in STD_LOGIC_VECTOR (3 downto 0);
           LED_B : out STD_LOGIC_VECTOR (3 downto 0);
           LED_A : out STD_LOGIC_VECTOR (3 downto 0);
           LED_RED : out STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC;
           BTNC : in STD_LOGIC);
end top_level;

architecture Behavioral of top_level is

--component declaration for adder_4bit
component adder_4bit is
    Port ( 
           c_in : in STD_LOGIC;
           b : in STD_LOGIC_VECTOR (3 downto 0);
           a : in STD_LOGIC_VECTOR (3 downto 0);
           c_out : out STD_LOGIC;
           result : out STD_LOGIC_VECTOR (3 downto 0));
end component;

--component declaration for bin2seg
component bin2seg is
    port (
      clear : in    std_logic;
      bin   : in    std_logic_vector(3 downto 0);
      seg   : out   std_logic_vector(6 downto 0)
    );
  end component;

  signal sig_c0 : std_logic;
  signal sig_c1 : std_logic;
  signal sig_c2 : std_logic;

signal sig_temp : std_logic_vector(3 downto 0);

begin

--instantiation adder_4bit

adder: component adder_4bit
    port map(
              c_in  => '0',
              b     => SW_B,
              a     => SW_A,
              c_out => LED_RED,
              result   => sig_temp
            );
        
--instantiation for bin2seg
subtractor: bin2seg
    port map (
          clear  => BTNC,
          bin    => sig_temp,
          seg(6) => CA,
          seg(5) => CB,
          seg(4) => CC,
          seg(3) => CD,
          seg(2) => CE,
          seg(1) => CF,
          seg(0) => CG
        );


end Behavioral;
