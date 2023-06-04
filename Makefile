.SILENT: setup
SHELL := /usr/bin/env bash
APPSFOLDER = ~/.local/share/applications
MIMESFOLDER = ~/.local/share/mime/packages

setup:
	echo "Starting..."
	mkdir -p "$(APPSFOLDER)"
	echo "Apps directory created"
	mkdir -p "$(MIMESFOLDER)"
	echo "Mimetypes directory created"
	cp "desktop/ProgramPackLauncher.desktop" "$(MIMESFOLDER)/ProgramPackLauncher.desktop"
	echo "Application .desktop file copied"
	cp "mimetype/programpack-extension.xml" "$(MIMESFOLDER)/x-programpack-extension.xml"
	echo "Mimetype copied"
	echo "Done!"
