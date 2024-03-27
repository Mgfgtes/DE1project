----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2024 12:05:30 PM
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
    Port ( SW : in STD_LOGIC_VECTOR (3 downto 0);
           LED : out STD_LOGIC_VECTOR (3 downto 0);
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           BTNC : in STD_LOGIC);
end top_level;

architecture Behavioral of top_level is


component bin2seg
Port ( clear : in STD_LOGIC;
       bin : in STD_LOGIC_VECTOR (3 downto 0);
       seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

begin

    U1 : bin2seg
    port map (
       clear => BTNC,
       bin => SW,
       seg(6) => CA,
       seg(5) => CB,
       seg(4) => CC,
       seg(3) => CD,
       seg(2) => CE,
       seg(1) => CF,
       seg(0) => CG 
    );

    DP <= '1';
    LED <= SW;
    AN <= b"1111_1110";


end Behavioral;
