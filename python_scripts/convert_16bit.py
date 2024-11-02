# Import necessary libraries
import re

# Function to convert a single 16-bit RGB color in binary to a 6-bit RGB color
def convert_16bit_binary_to_6bit_rgb(rgb16_binary):
    """
    Convert a 16-bit RGB color (RGB565 format) in binary to a 6-bit RGB color (6'bxxxxxx format).

    Parameters:
    rgb16_binary (str): The 16-bit color in binary format (e.g., "1011111111101111").

    Returns:
    str: A string representing the 6-bit color in the format "6'bxxxxxx".
    """
    # Convert binary string to integer
    rgb16 = int(rgb16_binary, 2)
    
    # Extract 5-bit red, 6-bit green, 5-bit blue from 16-bit RGB565
    r_5bit = (rgb16 >> 11) & 0x1F   # Extract bits 15-11
    g_6bit = (rgb16 >> 5) & 0x3F    # Extract bits 10-5
    b_5bit = rgb16 & 0x1F           # Extract bits 4-0

    # Scale 5-bit red and blue, 6-bit green down to 2 bits each
    r_2bit = (r_5bit * 3) // 31      # Scale 5-bit red to 2 bits
    g_2bit = (g_6bit * 3) // 63      # Scale 6-bit green to 2 bits
    b_2bit = (b_5bit * 3) // 31      # Scale 5-bit blue to 2 bits

    # Combine the 2-bit values into a single 6-bit binary string
    rgb6_value = (r_2bit << 4) | (g_2bit << 2) | b_2bit  # Pack them into a single integer

    # Format result as 6-bit binary
    return f"6'b{format(rgb6_value, '06b')}"

# Function to process the text file
def process_file(input_filename, output_filename):
    with open(input_filename, 'r') as file:
        content = file.read()
    
    # Regex pattern to match 16-bit binary values in the format "16'bxxxxxxxxxxxxxxxx"
    binary_pattern = r"16'b[01]{16}"
    
    # Find all instances of 16-bit binary RGB values in the file
    matches = re.findall(binary_pattern, content)

    # Dictionary to store original and converted values
    converted_values = {}

    for match in matches:
        # Extract the binary part after "16'b"
        binary_value = match[5:]
        
        # Convert 16-bit to 6-bit RGB binary
        rgb6_binary = convert_16bit_binary_to_6bit_rgb(binary_value)
        
        # Store the converted 6-bit binary format
        converted_values[match] = rgb6_binary

    # Replace all 16-bit binary RGB values with their 6-bit equivalents
    for orig, conv in converted_values.items():
        content = content.replace(orig, conv)
    
    # Write the updated content to a new file
    with open(output_filename, 'w') as file:
        file.write(content)
    
    print(f"Conversion complete. The updated file is saved as '{output_filename}'")

# Specify the input and output filenames
input_filename = 'end_menu.txt'  # Replace with your actual file name
output_filename = 'end_menu_16bit.txt'

# Run the conversion function
process_file(input_filename, output_filename)
