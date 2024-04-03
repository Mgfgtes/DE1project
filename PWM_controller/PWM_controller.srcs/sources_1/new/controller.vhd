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
        count	: in STD_LOGIC_VECTOR(10 downto 0);
    	pwm		: out STD_LOGIC;
    	ovfl	: out STD_LOGIC
        
    );
end PWM_controller;



architecture behavioral of PWM_controller is 
	signal sig_width : integer range 0 to 1999; 

begin

    process(clk)
    begin
        if(rst = '1') then
          sig_width <= 100;
        elsif(up = '1' and count < 200) then
          sig_width <= sig_width + 10;
        elsif(dwn = '1' and count > 100) then
          sig_width <= sig_width - 10;
        elsif(count = 1999) then
          ovfl <= '1';
        end if;
    
        if (rising_edge(clk) and en = '1') then
            if (rst = '1') then  
                pwm <= '0';
             elsif (count = 0) then	
                pwm <= '1';
                ovfl <= '0';
             elsif(sig_width < count) then
                pwm <= '0';
             end if;
        end if;
    
        
  end process;    
  

end architecture behavioral;