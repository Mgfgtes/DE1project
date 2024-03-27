----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2024 11:06:02 AM
-- Design Name: 
-- Module Name: simple_counter - Behavioral
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
use ieee.std_logic_unsigned.all; --tuhle knihovnu potrebujeme pro aritmeticke operace

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simple_counter is
    generic(
        N: integer := 4    
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (N-1 downto 0));
end simple_counter;

architecture Behavioral of simple_counter is

    signal sig_count : std_logic_vector(N-1 downto 0);

begin

--proces se spousti pouze pri zmene signalu v zavorce process()
        process (clk)
        begin
           if rising_edge(clk) then
              if rst='1' then
                 sig_count <= (others => '0'); 
              elsif en='1' then
                 sig_count <= sig_count + 1; --k tomuhle je treba ta knihovna 
              end if;
           end if;
        end process;

count <= sig_count;

end Behavioral;
