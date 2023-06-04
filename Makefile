.SILENT: setup update_database associate
SHELL := /usr/bin/env bash
APPSFOLDER = $(HOME)/.local/share/applications
BASICMIMEFOLDER = $(HOME)/.local/share/mime/
MIMESFOLDER = $(BASICMIMEFOLDER)packages
DATA = "custom-mime/custom-programpack-mime-type=ProgramPackLauncher.desktop"

setup:
	echo "Starting..."
	mkdir -p "$(APPSFOLDER)"
	echo "Apps directory created"
	mkdir -p "$(MIMESFOLDER)"
	echo "Mimetypes directory created"
	cp "desktop/ProgramPackLauncher.desktop" "$(APPSFOLDER)/ProgramPackLauncher.desktop"
	echo "Application .desktop file copied"
	cp "mimetype/programpack-extension.xml" "$(MIMESFOLDER)/x-programpack-extension.xml"
	echo "Mimetype copied"
	echo "Done!"
update_database:
	update-mime-database $(BASICMIMEFOLDER)
	ifneq ($(shell id -u), 0)
		echo "Not root: didn\'t update the /usr/share/mime database"
	else
		update-mime-database /usr/share/mime
		echo "Is root: updated the /usr/share/mime database"
	endif
	echo "Database updated"
associate:
	echo $(DATA)>"$(APPSFOLDER)/mimeapps.list"
	echo "Type associated"
