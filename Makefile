.SILENT: setup uninstall update_database associate _create_dirs
SHELL := /usr/bin/env bash
APPSFOLDER = $(HOME)/.local/share/applications
BASICMIMEFOLDER = $(HOME)/.local/share/mime/
MIMESFOLDER = $(BASICMIMEFOLDER)packages
DATA = "[Added Associations]
custom-mime/custom-programpack-mime-type=ProgramPackLauncher.desktop"
IS_ROOT = $(shell id -u)

setup:
	echo "Starting..."
	_create_dirs
	cp "desktop/ProgramPackLauncher.desktop" "$(APPSFOLDER)/ProgramPackLauncher.desktop"
	echo "Application .desktop file copied"
	cp "mimetype/programpack-extension.xml" "$(MIMESFOLDER)/x-programpack-extension.xml"
	echo "Mimetype copied"
	echo "Done!"
uninstall:
	echo "Starting..."
	_create_dirs
update_database:
	echo "Updating database\(s\)..."
	update-mime-database $(BASICMIMEFOLDER)
	if [ $(IS_ROOT) == 0 ]; then \
		update-mime-database /usr/share/mime; \
		echo "Is root: updated the /usr/share/mime database"; \
	else \
		echo "Not root: didn't update the /usr/share/mime database"; \
	fi
	echo "Database\(s\) updated"
associate:
	echo "Associating types..."
	echo $(DATA)>"$(APPSFOLDER)/mimeapps.list"
	echo "Type associated"
_create_dirs:
	echo "Creating directories..."
	mkdir -p "$(APPSFOLDER)"
	echo "Apps directory created"
	mkdir -p "$(MIMESFOLDER)"
	echo "Mimetypes directory created"
	echo "Directories created"
