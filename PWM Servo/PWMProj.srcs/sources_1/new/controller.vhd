-- Code your design here
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PWM_controller is
	
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
        led_out : out STD_LOGIC_VECTOR(9 downto 0)
    );
end PWM_controller;

architecture behavioral of PWM_controller is 
	signal sig_width : integer range 0 to 250; 

begin

    process(clk)
    begin
    if(rising_edge(clk)) then
        if(rst = '1') then
          sig_width <= 100;
          pwm <= '0';
          ovfl <= '1';
        elsif(chng_en = '1' and up = '1' and sig_width < 250) then
          sig_width <= sig_width + 2;
        elsif(chng_en = '1' and dwn = '1' and sig_width > 50) then
          sig_width <= sig_width - 2;
        elsif(count = 1998) then
          ovfl <= '1';
        end if;
    
        if (en = '1') then
          if (count = 0) then	
            pwm <= '1';
            ovfl <= '0';
          elsif(sig_width < count) then
            pwm <= '0';
          end if;
        end if;
        
        
        led_out <= (others => '1');
        
        --led_out(0) <= not(sig_width<115);
        --led_out(0) <= '0' when (sig_width<115) else
        --              '1';
        
        if(sig_width<55) then
            led_out(0) <= '0';
        end if;
        if(sig_width<75) then
            led_out(1) <= '0';
        end if;
        if(sig_width<95) then
            led_out(2) <= '0';
        end if;
        if(sig_width<115) then
            led_out(3) <= '0';
        end if;
        if(sig_width<135) then
            led_out(4) <= '0';
        end if;
        if(sig_width<155) then
            led_out(5) <= '0';
        end if;
        if(sig_width<175) then
            led_out(6) <= '0';
        end if;
        if(sig_width<195) then
            led_out(7) <= '0';
        end if;
        if(sig_width<215) then
            led_out(8) <= '0';
        end if;
        if(sig_width<235) then
            led_out(9) <= '0';
        end if;
     end if;
  end process;    
  

end architecture behavioral;