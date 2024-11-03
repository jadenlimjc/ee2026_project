from PIL import Image
import os

def convert_to_mem(image_path, output_path, width, height):
    # Open the image and resize to the specified width and height
    image = Image.open(image_path).convert("RGB")  # Ensure RGB format
    image = image.resize((width, height))          # Resize to OLED resolution

    with open(output_path, 'w') as f:
        for y in range(height):
            for x in range(width):
                r, g, b = image.getpixel((x, y))

                # Convert to RGB565 format
                r5 = (r >> 3) & 0x1F  # Get the top 5 bits of R
                g6 = (g >> 2) & 0x3F  # Get the top 6 bits of G
                b5 = (b >> 3) & 0x1F  # Get the top 5 bits of B

                # Combine into a single 16-bit value
                rgb565 = (r5 << 11) | (g6 << 5) | b5
                f.write(f"{rgb565:04X}\n")  # Write as 4-digit hex for each pixel

# Define paths for the source images and output .mem files
source_folder = "/Users/jaden/NUS/Y2S1/EE2026/settings"
output_folder = "python_scripts/bitmap"
os.makedirs(output_folder, exist_ok=True)

# Define the OLED screen width and height
width, height = 96, 64 

# Loop through each .png file in the source folder and convert it to a .mem file
for filename in os.listdir(source_folder):
    if filename.endswith(".png"):
        image_path = os.path.join(source_folder, filename)
        output_path = os.path.join(output_folder, os.path.splitext(filename)[0] + ".mem")
        convert_to_mem(image_path, output_path, width, height)
        print(f"Converted {filename} to {os.path.splitext(filename)[0]}.mem")
