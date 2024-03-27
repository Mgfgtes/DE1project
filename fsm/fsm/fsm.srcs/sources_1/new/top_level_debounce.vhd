----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2024 12:21:39 PM
-- Design Name: 
-- Module Name: top_level_debounce - Behavioral
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

entity top_level_debounce is
    Port ( 
        BTNC : in STD_LOGIC;
        BTNR : in STD_LOGIC;
        CLK100MHZ : in STD_LOGIC;
        LED : out STD_LOGIC_VECTOR(3 downto 0);
        LED16_B : out STD_LOGIC
        );
end top_level_debounce;

architecture Behavioral of top_level_debounce is
    -- Component declaration for debounce
            component debounce 
                port (
                      clk : in STD_LOGIC;
                      rst : in STD_LOGIC;
                      en : in STD_LOGIC;
                      bouncey : in STD_LOGIC;
                      pos_edge : out STD_LOGIC;
                      neg_edge : out STD_LOGIC;
                      clean : out STD_LOGIC
                      );
            end component;
            
    -- Component declaration for clock enable
            component clock_enable 
                generic(
                   PERIOD : integer := 6
                    );
                port (
                      clk : in STD_LOGIC;
                      rst : in STD_LOGIC;
                      pulse : out STD_LOGIC
                      );
            end component;
            
    -- Component declaration for simple_counter
              component simple_counter 
                generic(
                        N: integer := 4);
                Port ( 
                       clk : in STD_LOGIC;
                       rst : in STD_LOGIC;
                       en : in STD_LOGIC;
                       count : out STD_LOGIC_VECTOR (N-1 downto 0)
                      );
            end component;

    signal sig_en_2ms : std_logic;
    signal sig_event : std_logic;

begin

-- Component instantiation of clock enable for 2 ms
    cl_en : clock_enable
         generic map (
            PERIOD => 200_000
         )
         port map (
           clk => CLK100MHZ,
           rst => BTNC,
           pulse => sig_en_2ms
        );

-- Component instantiation of debounce
    debouncer : debounce
    port map (
        clk => CLK100MHZ,
        rst => BTNC,
        bouncey => BTNR,
        en => sig_en_2ms,
        pos_edge => open,
        neg_edge => sig_event,
        clean => LED16_B
    );
    
 -- Component instantiation of simple counter
    counter : simple_counter
    port map (
        clk => CLK100MHZ,
        rst => BTNC,
        en => sig_event,
        count => LED
    );

end Behavioral;
