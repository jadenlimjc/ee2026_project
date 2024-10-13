import os
import subprocess

# Directories for Input/Output
input_dir = '/Users/jaden/NUS/Y2S1/EE2026/mainmenu'  # Directory with your images
output_dir = '/Users/jaden/NUS/Y2S1/EE2026/ee2026_project/mainmenu_output'  # Directory for converted files

# Parameters for picture2pixel library
width = 96
height = 64
svd_r = 0

if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Convert all PNG images in the folder
for image_name in os.listdir(input_dir):
    if image_name.endswith('.png'):
        image_path = os.path.join(input_dir, image_name)
        command = [
            'python3', '-m', 'picture2pixel.convert2pixel',
            image_path, str(width), str(height), str(svd_r), output_dir
        ]
        subprocess.run(command)

print("All images converted successfully using picture2pixel!")
