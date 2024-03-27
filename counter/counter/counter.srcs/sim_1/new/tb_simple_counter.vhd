-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 6.3.2024 10:28:52 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_simple_counter is
end tb_simple_counter;

architecture tb of tb_simple_counter is

    component simple_counter
        generic(
            N: integer    
        );
        port (
            clk   : in std_logic;
            rst   : in std_logic;
            en    : in std_logic;
            count : out std_logic_vector (N-1 downto 0));
    end component;

    signal clk   : std_logic;
    signal rst   : std_logic;
    signal en    : std_logic;
    constant COUNTER_WIDTH : integer := 6; 
    signal count : std_logic_vector (COUNTER_WIDTH-1 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here; doba periodz hodinoveho signalu
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin
    --instanciace
    dut : simple_counter
    generic map (
        N => COUNTER_WIDTH
    )
    port map (clk   => clk,
              rst   => rst,
              en    => en,
              count => count);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        en <= '1';

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 65 * TbPeriod;
        en <= '0';
        wait for 30 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_simple_counter of tb_simple_counter is
    for tb
    end for;
end cfg_tb_simple_counter;