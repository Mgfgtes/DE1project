----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2024 11:09:05 AM
-- Design Name: 
-- Module Name: lfsr - Behavioral
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

entity lfsr is
    generic (
        NBIT : integer := 4
    
    );
    Port ( 
           clk : in STD_LOGIC;
           en : in STD_LOGIC;
           load_enable : in STD_LOGIC;
           load_data : in STD_LOGIC_VECTOR (NBIT-1 downto 0);
           done : out std_logic;
           count : out STD_LOGIC_VECTOR (NBIT-1 downto 0)
          );
end lfsr;

architecture Behavioral of lfsr is
    signal sig_reg : std_logic_vector (NBIT-1 downto 0);
    signal sig_feedback : std_logic;
begin


       -- Define a temporary signal that is of type std_logic_vector(<width>-1 downto 0).
       -- Where width is the number of bits to shift
        process (clk)
        begin
           if rising_edge(clk) then
              if load_enable = '1' then
                 sig_reg <= load_data;
              elsif en = '1' then
                 sig_reg <= sig_reg(NBIT-2 downto 0) & sig_feedback;
              end if;
           end if;
        end process;
        
        --NBIT=4
        nbit4 : if NBIT = 4 generate
        sig_feedback <= sig_reg(3) xnor sig_reg(2);
        end generate nbit4;
        
        --NBIT=5
        nbit5 : if NBIT = 5 generate
        sig_feedback <= sig_reg(4) xnor sig_reg(2);
        end generate nbit5;
        
        --NBIT=6
        nbit6 : if NBIT = 6 generate
        sig_feedback <= sig_reg(5) xnor sig_reg(4);
        end generate nbit6;
        
        --NBIT=8
        nbit8 : if NBIT = 8 generate
        sig_feedback <= sig_reg(7) xnor
                        sig_reg(5) xnor 
                        sig_reg(4) xnor
                        sig_reg(3);
        end generate nbit8;
        
        done <= '1' when sig_reg = load_data else '0';
        count <= sig_reg;
        
end Behavioral;
