# INET-3101---Module-6-Assignment

# Problem Statement & Solution Overview:

The goal was to make it so the ls command showed long format by default and make whoami print my username. I did this by running a bash script to download and compile coreutilis 9.7 and edited ls.c and whoami.c scripts, then re-ran the scripts and rebuild the bash build_on_mac.sh. Finally I reran the scripts to confirm it properly worked the way I wanted it as shown in the 3 screenshots attached to the repo.

# C System Mechanics & Diff Analysis:

- ls.c: ls checks for flags like -l or -C first, and only uses a default if you typed none. I changed that default on line 2316 to long format, so plain ls now shows the long listing, but ls -C still shows columns.
- whoami.c: geteuid gets your user ID number, and getpwuid turns that number into your username. I changed line 86 so it prints “You are: “ before the username.
- Unified git diff patch: The exact changes are in the ls.patch and whoami.patch files in this repo.

# Pros & Cons of Solution:

- Pro: you don't have to type -l anymore and whoami output is easier to read
- Con: scripts that expect normal output might break like a script that loops through ls results 
- Con: long format is slower in big folders and the commands no longer match the official documentation

# AI Audit Reflection:

- Prompts used: I asked AI for steps to take to modify ls.c and whoami.c where the default format is set in ls.c and how whoami.c gets the username
- What AI showed me: ls applies its default only after reading the user's flags so changing the default keeps the flags like -c working
- How I verified it: I used grep to find the real lines in the source code and rebuilt it and tested ls, ls-c and whoami to confirm they all worked properly.
