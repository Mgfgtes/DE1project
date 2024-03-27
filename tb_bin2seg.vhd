-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 21.2.2024 10:39:24 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_bin2seg is
end tb_bin2seg;

architecture tb of tb_bin2seg is

    component bin2seg
        port (clear : in std_logic;
              bin   : in std_logic_vector (3 downto 0);
              seg   : out std_logic_vector (6 downto 0));
    end component;

    signal clear : std_logic;
    signal bin   : std_logic_vector (3 downto 0);
    signal seg   : std_logic_vector (6 downto 0);

begin

    dut : bin2seg
    port map (clear => clear,
              bin   => bin,
              seg   => seg);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        clear <= '0';
        bin <= (others => '0');


    -- Disable clear
    clear <= '0';
    
    -- Test case 1: Input binary value 0000
    bin <= x"0";
    wait for 50 ns;
    assert seg = "0000001"
    report "0 does not map to 0000001"
    severity error;
    
    bin <= x"1";
    wait for 50 ns;
    assert seg = "1001111"
    report "0 does not map to 0000001"
    severity error;
    
    bin <= x"2";
    wait for 50 ns;
    assert seg = "0010010"
    report "0 does not map to 0000001"
    severity error;
    
    bin <= x"3";
    wait for 50 ns;
    assert seg = "0000001"
    report "0 does not map to 0000001"
    severity error;
    
    bin <= x"4";
    wait for 50 ns;
    assert seg = "0000001"
    report "0 does not map to 0000001"
    severity error;
    
    bin <= x"5";
    wait for 50 ns;
    assert seg = "0000001"
    report "0 does not map to 0000001"
    severity error;
    
    bin <= x"6";
    wait for 50 ns;
    assert seg = "0000001"
    report "0 does not map to 0000001"
    severity error;
    
    bin <= x"7";
    wait for 50 ns;
    assert seg = "0000001"
    report "0 does not map to 0000001"
    severity error;
    
    bin <= x"8";
    wait for 50 ns;
    assert seg = "0000001"
    report "0 does not map to 0000001"
    severity error;
    
    bin <= x"9";
    wait for 50 ns;
    assert seg = "0000001"
    report "0 does not map to 0000001"
    severity error;
    
    bin <= x"A";
    wait for 50 ns;
    assert seg = "0000001"
    report "0 does not map to 0000001"
    severity error;
    
    bin <= x"b";
    wait for 50 ns;
    assert seg = "0000001"
    report "0 does not map to 0000001"
    severity error;
    
    bin <= x"C";
    wait for 50 ns;
    assert seg = "0000001"
    report "0 does not map to 0000001"
    severity error;
    
    bin <= x"d";
    wait for 50 ns;
    assert seg = "0000001"
    report "0 does not map to 0000001"
    severity error;
    
    bin <= x"E";
    wait for 50 ns;
    assert seg = "0000001"
    report "0 does not map to 0000001"
    severity error;
        -- EDIT Add stimuli here

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_bin2seg of tb_bin2seg is
    for tb
    end for;
end cfg_tb_bin2seg;