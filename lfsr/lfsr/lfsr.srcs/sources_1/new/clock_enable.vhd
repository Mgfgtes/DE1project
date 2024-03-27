----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2024 12:11:58 PM
-- Design Name: 
-- Module Name: clock_enable - Behavioral
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
use ieee.std_logic_unsigned.all; --umozni inkrementovat vektory
use ieee.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_enable is
    generic(
           PERIOD : integer := 6
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pulse : out STD_LOGIC);
end clock_enable;

architecture Behavioral of clock_enable is

    constant bits_needed : integer := integer(ceil(log2(real(PERIOD + 1))));
    signal sig_count : std_logic_vector(bits_needed-1 downto 0);

begin

--! Generate clock enable signal. By default, enable signal
    --! is low and generated pulse is always one clock long.
    p_clk_enable : process (clk) is
    begin

        -- Synchronous proces
        if (rising_edge(clk)) then
            -- if high-active reset then
            if (rst = '1') then
                -- Clear all bits of local counter
                sig_count <= (others => '0');
                -- Set output `pulse` to low
                pulse <= '0';

            -- elsif sig_count is PERIOD-1 then
            elsif (sig_count = PERIOD-1) then
                -- Clear all bits of local counter
                sig_count <= (others => '0');
                -- Set output `pulse` to high
                pulse <= '1';

            -- else
            else
                -- Increment local counter
                sig_count <= sig_count + 1;
                -- Set output `pulse` to low
                pulse <= '0';

            -- Each `if` must end by `end if`
            end if;
        end if;

    end process p_clk_enable;




end Behavioral;
