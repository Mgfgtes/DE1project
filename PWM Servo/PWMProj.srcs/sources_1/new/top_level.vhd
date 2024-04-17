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
           SW   : in STD_LOGIC_VECTOR (0 to 3);
           CLK100MHZ : in STD_LOGIC;
           JA : out STD_LOGIC_VECTOR (1 to 4);
           LED : out STD_LOGIC_VECTOR (0 to 9)
           );
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
            chng_en : in STD_LOGIC;
            count	: in STD_LOGIC_VECTOR(10 downto 0);
            pwm		: out STD_LOGIC;
            ovfl	: out STD_LOGIC;
            led_out : out STD_LOGIC_VECTOR(9 downto 0));
    end component;
    
    signal sig_en_10us   : std_logic;
    signal sig_en_2ms   : std_logic;
    --signal sig_up   : std_logic;
    --signal sig_dwn   : std_logic;
    signal sig_count_11bit   : std_logic_vector(10 downto 0);
    signal sig_ovfl   : std_logic;
    
    signal sig_en_100ms   : std_logic;
    signal cnt_up   : std_logic;
    signal cnt_dwn   : std_logic;
    signal sig_up_cln   : std_logic;
    signal sig_dwn_cln   : std_logic;
    
    
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
        
    -- Component instantiation of clock enable for 100 ms   
    clk_en2 : component clock_enable
        generic map (
            PERIOD => 10_000_000
        )
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            pulse => sig_en_100ms
        );    
        
    dbnc0 : component debounce
        port map(
            clk   => CLK100MHZ,
            rst   => BTNC,
            en    => sig_en_2ms,
            bouncey   => BTNU,
            pos_edge  => open,
            neg_edge  => open,
            clean     => sig_up_cln
        );
    
    dbnc1 : component debounce
        port map(
            clk   => CLK100MHZ,
            rst   => BTNC,
            en    => sig_en_2ms,
            bouncey   => BTND,
            pos_edge  => open,
            neg_edge  => open,
            clean     => sig_dwn_cln
        );
    
    -- Component instantiation of 11-bit simple counter
    counter0 : component simple_counter
        generic map (
            NBIT => 11
        )
        port map (
            clk   => CLK100MHZ,
            rst   => '0',
            en    => sig_en_10us,
            count => sig_count_11bit
        );
        
    
        
    pwm0 : component PWM_controller
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            en    => sig_en_10us,
            up    => cnt_up,
            dwn   => cnt_dwn,
            chng_en => SW(0),
            count => sig_count_11bit,
            pwm   => JA(1),
            ovfl  => sig_ovfl,
            led_out => LED
        );
        
    pwm1 : component PWM_controller
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            en    => sig_en_10us,
            up    => cnt_up,
            dwn   => cnt_dwn,
            chng_en => SW(1),
            count => sig_count_11bit,
            pwm   => JA(2),
            ovfl  => open,
            led_out => open
        );        
    
    pwm2 : component PWM_controller
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            en    => sig_en_10us,
            up    => cnt_up,
            dwn   => cnt_dwn,
            chng_en => SW(2),
            count => sig_count_11bit,
            pwm   => JA(3),
            ovfl  => open,
            led_out => open
        );
        
    cnt_up <= sig_en_100ms and sig_up_cln;
    cnt_dwn <= sig_en_100ms and sig_dwn_cln; 
    
end Behavioral;
