import os

def generate_code(input_folder, output_file):
    with open(output_file, 'w') as outfile:
        for i, p2p_filename in enumerate(sorted(os.listdir(input_folder))):
            if p2p_filename.endswith('.p2p'):
                p2p_path = os.path.join(input_folder, p2p_filename)
                with open(p2p_path, 'r') as infile:
                    content = infile.read()
                if i == 0:
                    outfile.write(f"if (frame_count == {i}) begin\n")
                else:
                    outfile.write(f"else if (frame_count == {i}) begin\n")
                outfile.write(content)
                outfile.write("end\n")

input_folder = "/Users/jaden/NUS/Y2S1/EE2026/ee2026_project/mainmenu_output"
output_file = "mainmenu_output.txt"

generate_code(input_folder, output_file)
