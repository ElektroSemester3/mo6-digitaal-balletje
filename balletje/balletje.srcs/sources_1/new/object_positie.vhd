library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity object_positie is
    generic (
        offset : unsigned := 10
    );
    Port ( 
        object_width        : in STD_LOGIC_VECTOR (9 downto 0);
        object_height       : in STD_LOGIC_VECTOR (9 downto 0);
        size_window_width   : in STD_LOGIC_VECTOR (9 downto 0);
        size_window_height  : in STD_LOGIC_VECTOR (9 downto 0);
        value_1               : in STD_LOGIC_VECTOR (9 downto 0);
        value_2               : in STD_LOGIC_VECTOR (9 downto 0);
        position_x_1          : out STD_LOGIC_VECTOR (9 downto 0);
        position_y_1          : out STD_LOGIC_VECTOR (9 downto 0);
        position_x_2          : out STD_LOGIC_VECTOR (9 downto 0);
        position_y_2          : out STD_LOGIC_VECTOR (9 downto 0)
    );
end object_positie;

architecture Behavioral of object_positie is
begin
    position_y_1 <= std_logic_vector((to_unsigned(size_window_height, 10) - to_unsigned(object_height, 10)) * to_unsigned(value_1, 10) / to_unsigned((2 ** position'length) - 1, 10));
    position_y_2 <= std_logic_vector((to_unsigned(size_window_height, 10) - to_unsigned(object_height, 10)) * to_unsigned(value_2, 10) / to_unsigned((2 ** position'length) - 1, 10));

    position_x_1 <= std_logic_vector(offset);
    position_x_2 <= std_logic_vector(to_unsigned(size_window_width, 10) - to_unsigned(object_width, 10) - to_unsigned(offset, 10));
end Behavioral;
