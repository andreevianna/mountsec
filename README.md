script evtx to json:
This script was developed using as main the binary located on this repository https://github.com/omerbenamram/evtx/releases the windows file evtx_dump-v0.9.0.exe
The main ideia of this scritp is to help to manipulate a huge mont of evtx files for analysis, during the incident response investigation
![image](https://github.com/user-attachments/assets/59afd632-4d0b-4023-a0ad-55ff859a80c9)
Note on How to Run the Script:
To use this batch script, follow the steps below:
Prepare the environment:
Place the batch script in the same directory where your .evtx files are located.
Make sure that the evtx_dump-v0.9.0.exe executable is also in the same directory.
Run the script:
Double-click the batch script (.bat) to execute it.
The script will:
Check all .evtx files in the directory.
Rename any files that contain spaces in their names by replacing the spaces with hyphens (-).
Convert all .evtx files to .json format using the evtx_dump-v0.9.0.exe executable.
Display a summary of the renaming and conversion process at the end.
Review the output:
After the script finishes, you'll see a summary of:
How many files were found and processed.
How many files had their names adjusted.
How many files were successfully converted to .json.
Any files that could not be renamed or converted will also be listed.
This script simplifies the process of renaming .evtx files with spaces in their names and converting them to JSON format for further analysis.
Note:
Consider put as admin before the file execution.
