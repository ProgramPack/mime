# Mime
Mimetype and .desktop file
# Installation
Run the following command in the terminal:
```bash
git clone https://github.com/ProgramPack/mime.git && mv mime programpack-mimes
cd programpack-mimes
make setup && make update_database && make associate
cd ..
true && rm -rf programpack-mimes # Change "true" to false if you want to keep the directory
```
# Contributing
You can send pull requests [here](https://github.com/ProgramPack/mime/pulls).
