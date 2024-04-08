----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2024 16:23:09
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
    Port ( BTNU : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           CLK100MHZ : in STD_LOGIC;
           JA : out STD_LOGIC_VECTOR (1 to 10));
end top_level;

architecture Behavioral of top_level is

    -- Component declaration for clock enable
    component clock_enable
        generic(
               PERIOD : integer
        );
        port ( clk      : in    STD_LOGIC;
               rst      : in    STD_LOGIC;
               pulse    : out   STD_LOGIC);
    end component;

    -- Component declaration for simple counter
    component simple_counter is
        generic (
            NBIT : integer
        );
        port (
            clk   : in    STD_LOGIC;
            rst   : in    STD_LOGIC;
            en    : in    STD_LOGIC;
            count : out   STD_LOGIC_VECTOR(NBIT - 1 downto 0));
    end component;
    
    -- Component declaration for debounce
    component debounce is
        Port ( 
             clk        : in    STD_LOGIC;
             rst        : in    STD_LOGIC;
             en         : in    STD_LOGIC;
             bouncey    : in    STD_LOGIC;
             pos_edge   : out   STD_LOGIC;
             neg_edge   : out   STD_LOGIC;
             clean      : out   STD_LOGIC);
    end component;
    
    component PWM_controller
        Port ( 
            clk		: in STD_LOGIC;
            en		: in STD_LOGIC;
            rst 	: in STD_LOGIC;
            up		: in STD_LOGIC;
            dwn		: in STD_LOGIC;
            count	: in STD_LOGIC_VECTOR(10 downto 0);
            pwm		: out STD_LOGIC;
            ovfl	: out STD_LOGIC);
    end component;
    
    signal sig_en_10us   : std_logic;
    signal sig_en_2ms   : std_logic;
    signal sig_up   : std_logic;
    signal sig_dwn   : std_logic;
    signal sig_count_11bit   : std_logic_vector(10 downto 0);
    
begin
    
    -- Component instantiation of clock enable for 10 us
    clk_en0 : component clock_enable
        generic map (
            PERIOD => 1000
        )
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            pulse => sig_en_10us
        );
        
    -- Component instantiation of clock enable for 2 ms   
    clk_en1 : component clock_enable
        generic map (
            PERIOD => 200_000
        )
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            pulse => sig_en_2ms
        );
        
    dbnc0 : component debounce
        port map(
            clk   => CLK100MHZ,
            rst   => BTNC,
            en    => sig_en_2ms,
            bouncey   => BTNU,
            pos_edge  => sig_up,
            neg_edge  => open,
            clean     => open
        );
    
    dbnc1 : component debounce
        port map(
            clk   => CLK100MHZ,
            rst   => BTNC,
            en    => sig_en_2ms,
            bouncey   => BTND,
            pos_edge  => sig_dwn,
            neg_edge  => open,
            clean     => open
        );
    
    -- Component instantiation of 11-bit simple counter
    counter0 : component simple_counter
        generic map (
            NBIT => 11
        )
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            en    => sig_en_10us,
            count => sig_count_11bit
        );
        
    pwm0 : component PWM_controller
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            en    => sig_en_10us,
            up    => sig_up,
            dwn   => sig_dwn,
            count => sig_count_11bit,
            pwm   => JA(1)
        );    

end Behavioral;
