----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.01.2024 16:46:53
-- Design Name: 
-- Module Name: tekenen_balletje - Behavioral
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

entity tekenen is
    Port ( 
        pixelklok : in STD_LOGIC;
        pixel_value_i : in STD_LOGIC;
        pixel_x : in STD_LOGIC_VECTOR (9 downto 0);
        pixel_y : in STD_LOGIC_VECTOR (9 downto 0);
        pos_x : in STD_LOGIC_VECTOR (9 downto 0);
        pos_y : in STD_LOGIC_VECTOR (9 downto 0);
        size_x : in STD_LOGIC_VECTOR (9 downto 0);
        size_y : in STD_LOGIC_VECTOR (9 downto 0);
        pixel_value_o : out STD_LOGIC
    );
end tekenen;

architecture Behavioral of tekenen is

begin
    pixel_value_o <= '1' when (pixel_x >= pos_x AND pixel_x <= pos_x + size_x AND pixel_y >= pos_y AND pixel_y <= pos_y + size_y) else pixel_value_i;
    
end Behavioral;
