----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.01.2024 15:49:43
-- Design Name: 
-- Module Name: positie_balletje - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity positie_balletje is
    generic ( 
        -- size        : integer := 8;
        step        : integer := 1;
        x_value     : integer := 640;
        y_value     : integer := 480
    );
    Port ( 
        clk_slow            : in STD_LOGIC;
        angle_index         : in STD_LOGIC_VECTOR (1 downto 0);
        running             : in STD_LOGIC;
        peddel_touch        : in STD_LOGIC;
        side_touch          : in STD_LOGIC;
        top_bottom_touch    : in STD_LOGIC;
        pos_x_out           : out STD_LOGIC_VECTOR (9 downto 0);
        pos_y_out           : out STD_LOGIC_VECTOR (9 downto 0)
    );
end positie_balletje;

architecture Behavioral of positie_balletje is
    -- Direction of the ball
    type x_direction is (left, right);
    type y_direction is (up, down);
    signal x_dir : x_direction := right;
    signal y_dir : y_direction := down;
    
    -- Start position
    signal x_start : unsigned(9 downto 0) := to_unsigned(x_value, 10) / to_unsigned(2, 10);
    signal y_start : unsigned(9 downto 0) := to_unsigned(y_value, 10) / to_unsigned(3, 10);
    
    -- Position of the ball storage
    signal x_pos : unsigned(9 downto 0) := x_start;
    signal y_pos : unsigned(9 downto 0) := y_start;
    
    -- Size of the ball
--    signal ball_size : unsigned(3 downto 0) := to_unsigned(size, 4) / to_unsigned(2, 4);

    -- Angle of the ball
    signal angle            : unsigned(9 downto 0) := (others => '0');
    signal angle_counter    : unsigned(9 downto 0) := (others => '0');

begin
    -- Angle of the ball
    angle_LUT : process(angle_index)
    begin
        case angle_index is
            when "00" => angle <= to_unsigned(0, 10);
            when "01" => angle <= to_unsigned(5, 10);
            when "10" => angle <= to_unsigned(10, 10);
            when "11" => angle <= to_unsigned(20, 10);
            when others => angle <= to_unsigned(0, 10);
        end case;
    end process;

    process(clk_slow)
    begin
        if rising_edge(clk_slow) then
            if running = '1' then
                    ------------------
                    --- Direction ----
                    ------------------
                -- check if the ball is touching the peddel, flip the x
                if peddel_touch = '1' OR side_touch = '1' then
                    if x_dir = right then
                        x_dir <= left;
                    else
                        x_dir <= right;
                    end if;
                end if;
                
                -- check if the ball is touching the top or bottom, flip the y
                if top_bottom_touch = '1' OR side_touch = '1'  then
                    if y_dir = up then
                        y_dir <= down;
                    else
                        y_dir <= up;
                    end if;
                end if;

                    ---------------
                    --- Outputs ---
                    ---------------
                -- check if the ball is touching the top or bottom else add the step
                if side_touch = '1' then
                    x_pos <= x_start;
                elsif x_dir = right then
                    x_pos <=  x_pos + step;
                else
                    x_pos <=  x_pos - step;
                end if;

                -- check if the ball is touching the top or bottom else add the step based on the angle
                if side_touch = '1' then
                    y_pos <= y_start;
                    angle_counter <= (others => '0');
                elsif angle_counter >= angle AND angle /= 0 then
                    if y_dir = up then
                        y_pos <= y_pos - step;
                        angle_counter <= (others => '0');
                    else
                        y_pos <= y_pos + step;
                        angle_counter <= (others => '0');
                    end if;
                else
                    if angle /= 0 then
                        angle_counter <= angle_counter + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    pos_x_out <= std_logic_vector(x_pos);
    pos_y_out <= std_logic_vector(y_pos);


end Behavioral;
