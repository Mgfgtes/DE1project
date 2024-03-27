library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;

entity top_level_lfsr is
    Port ( 
           BTNC : in STD_LOGIC;
           BTND : in STD_LOGIC_VECTOR (3 downto 0);
           SW : in STD_LOGIC;
           CLK100MHZ : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           LED : out STD_LOGIC_VECTOR (3 downto 0);
           LED16_B : out STD_LOGIC
           );
end top_level_lfsr;


architecture behavioral of top_level_lfsr is
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

    -- Component declaration for LFSR counter
        component lfsr
            generic (
                NBIT : integer
                );
            Port ( 
               clk : in STD_LOGIC;
               en : in STD_LOGIC;
               load_enable : in STD_LOGIC;
               load_data : in STD_LOGIC_VECTOR (NBIT-1 downto 0);
               done : out std_logic;
               count : out STD_LOGIC_VECTOR (NBIT-1 downto 0)
               );
        end component;

    -- Component declaration for bin2seg
        component bin2seg 
            port (
                  clear : in STD_LOGIC;
                  bin : in STD_LOGIC_VECTOR (3 downto 0);
                  seg : out STD_LOGIC_VECTOR (6 downto 0)
                  );
        end component;

    -- Local signals for a counter: 4-bit @ 500 ms
        signal sig_en_500ms : std_logic;
        signal sig_count : std_logic_vector (3 downto 0);

begin

--<instance_name> : <component_name>
--generic map (
--   <generic_name> => <value>,

    -- Component instantiation of clock enable for 500 ms
    cl_en : clock_enable
         generic map (
            PERIOD => 50_000_000
         )
         port map (
           clk => CLK100MHZ,
           rst => BTNC,
           pulse => sig_en_500ms
        );

    -- Component instantiation of 4-bit LFSR counter
    lfsr_counter : lfsr
    generic map (
        NBIT = 4
    )
    port map (
        clk => CLK100MHZ,
        en => sig_en_500ms,
        load_enable => BTND,
        load_data => SW,
        done => LED16_B,
        count => sig_count
    );

    -- Component instantiation of bin2seg
    display : bin2seg
        port map (
          clear  => BTNC,
          bin    => sig_count,
          seg(6) => CA,
          seg(5) => CB,
          seg(4) => CC,
          seg(3) => CD,
          seg(2) => CE,
          seg(1) => CF,
          seg(0) => CG
        );


    -- Turn off decimal point
       DP<='1';

    -- Set display position
       AN <=  b"1111_1110";

    -- Set output LEDs (green)
       LED <= sig_count;
       LED16_B <= done;
       
end architecture behavioral;