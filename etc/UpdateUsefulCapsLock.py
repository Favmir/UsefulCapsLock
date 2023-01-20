# Copy the script file into a separte archive folder, and add it to startup
# so that any changes I make during development doesn't affect my everyday use of the script.
# Place this script in the same folder as the UsefulCapsLock folder
# (NOT insdie the UsefulCapsLock folder!)
# Set dst_path (archive folder) to wherever you wish
# IMPORTANT!! Make sure to replace backslashes(\) in path string with normal slash(/)!!!


import os
import shutil
import re
import subprocess

# Get the current script's directory
script_dir = os.path.dirname(os.path.realpath(__file__))

# Define the source and destination paths
src_path = os.path.join(script_dir, 'UsefulCapsLock')
dst_path = 'C:/Users/Favmir/Desktop/AHKScripts/UsefulCapsLockArchive'

# Read the version number from the text file
with open(os.path.join(src_path, 'Changelog.md'), 'r', encoding='utf-8') as f:
    changelog = f.read()
    # Use a regular expression to extract the version number
    match = re.search(r'20\d{2}/\d{1,2}/\d{1,2} v\d+\.\d+\.\d+', changelog)
    if match:
        version = match.group(0).split(" v")[1]
        print(version)
    else:
        print("No version number found.")

# Construct the new folder name
new_folder_name = 'UCL_' + version
new_folder_path = os.path.join(dst_path, new_folder_name)

# Check if a folder with the same name already exists in the destination
if os.path.exists(new_folder_path):
    # If so, append a number to the folder name to make it unique
    i = 1
    while os.path.exists(new_folder_path + ' (' + str(i) + ')'):
        i += 1
    new_folder_path += ' (' + str(i) + ')'
    new_folder_name += ' (' + str(i) + ')'

# Copy the folder to the destination, using the new folder name
shutil.copytree(src_path, new_folder_path)

# Run the batch file in the new folder path
# stdin=subprocess.DEVNULL bypasses the "Press any key to continue..." message
subprocess.run(['cmd.exe', '/c', 'Add to Startup.bat'], cwd=os.path.join(new_folder_path,'App'), stdin=subprocess.DEVNULL)

os.system('start ' + dst_path)