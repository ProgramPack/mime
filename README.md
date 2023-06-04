# Mime
Mimetype and .desktop file for ProgramPack. You can install it using the instructions below.
# Installation
Run the following command in the terminal:
```bash
git clone https://github.com/ProgramPack/mime.git && mv mime programpack-mimes
cd programpack-mimes
chmod 777 run_all.sh
./run_all.sh
cd ..
true && rm -rf programpack-mimes # Change "true" to false if you want to keep the directory
```
# Uninstall
If you wish to uninstall the program, run the following command:
```bash
chmod 777 uninstall.sh
./uninstall.sh
```
Make sure to clean the file ~/.local/share/applications/mimeapps.list file (don't delete it) and call this command:
```bash
make update_database
```
# Contributing
You can send pull requests [here](https://github.com/ProgramPack/mime/pulls).
