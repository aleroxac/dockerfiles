import subprocess
import sys

# Read the .env file
envfile = sys.argv[0]
with open(envfile, 'r', encoding="utf-8") as f:
    lines = f.readlines()

# Process each line in the .env file
for line in lines:
    # Split the line into the environment variable name and the command

    env_var, command = line.strip().split('=', maxsplit=1)
    if "$" in line:
        ## Remove shell expansion parentheses surround the command
        command = command[2:-1]

        # Run the command and capture the output
        output = subprocess.run(command, shell=True, stdout=subprocess.PIPE, check=True).stdout.decode('utf-8').strip()

        # Print the environment variable name and the command output as a key-value pair
        print(f'{env_var}={output}')
    else:
        print(f'{env_var}={command}')
