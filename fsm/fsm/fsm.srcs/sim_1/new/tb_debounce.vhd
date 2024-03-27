-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 20.3.2024 10:41:22 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_debounce is
end tb_debounce;

architecture tb of tb_debounce is

    component debounce
        port (clk     : in std_logic;
              rst     : in std_logic;
              en      : in std_logic;
              bouncey : in std_logic;
              pos_edge : out STD_LOGIC;
              neg_edge : out STD_LOGIC;
              clean   : out std_logic);
    end component;

    signal clk     : std_logic;
    signal rst     : std_logic;
    signal en      : std_logic;
    signal bouncey : std_logic;
    signal clean   : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : debounce
    port map (clk     => clk,
              rst     => rst,
              en      => en,
              bouncey => bouncey,
              clean   => clean);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        en <= '1';
        bouncey <= '0';

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for 22 ns;
        rst <= '0';
        wait for 4 ns;

        -- EDIT Add stimuli here
        bouncey <= '1';
        wait for 2 * TbPeriod;
        bouncey <= '0';
        wait for 10 * TbPeriod;
        bouncey <= '1';
        wait for 4 * TbPeriod;
        
        bouncey <= '0';
        wait for 2 * TbPeriod;
        bouncey <= '1';
        wait for 20 * TbPeriod;
        bouncey <= '0';
        wait for 2 * TbPeriod;
        

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_debounce of tb_debounce is
    for tb
    end for;
end cfg_tb_debounce;