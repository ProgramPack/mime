.SILENT: all setup uninstall update_database associate _create_dirs
SHELL := /usr/bin/env bash
APPSFOLDER = $(HOME)/.local/share/applications
BASICMIMEFOLDER = $(HOME)/.local/share/mime/
MIMESFOLDER = $(BASICMIMEFOLDER)packages
define DATA
[Added Associations]
custom-mime/custom-programpack-mime-type=ProgramPackLauncher.desktop
endef
IS_ROOT = $(shell id -u)
LAUNCHER_FILE = "$(APPSFOLDER)/ProgramPackLauncher.desktop"
MIME_FILE = "$(MIMESFOLDER)/x-programpack-extension.xml"

all: setup update_database associate
_create_dirs:
	echo 'Creating directories...'
	mkdir -p "$(APPSFOLDER)"
	echo 'Apps directory created'
	mkdir -p "$(MIMESFOLDER)"
	echo 'Mimetypes directory created'
	echo 'Directories created'
setup:
	echo 'Starting...'
	$(MAKE) _create_dirs
	cp "desktop/ProgramPackLauncher.desktop" "$(LAUNCHER_FILE)"
	echo 'Application .desktop file copied'
	cp "mimetype/programpack-extension.xml" "$(MIME_FILE)"
	echo 'Mimetype copied'
	echo 'Done!"'
uninstall:
	echo 'Starting to uninstall...'
	$(MAKE) _create_dirs
	rm -f "$(LAUNCHER_FILE)"
	rm -f "$(MIME_FILE)"
	echo 'Successfully uninstalled'
update_database:
	echo 'Updating database(s)...'
	update-mime-database $(BASICMIMEFOLDER)
	if [ $(IS_ROOT) == 0 ]; then \
		update-mime-database /usr/share/mime; \
		echo 'Is root: updated the /usr/share/mime database'; \
	else \
		echo "Not root: didn't update the /usr/share/mime database"; \
	fi
	echo "Database(s) updated"
associate:
	echo 'Associating types...'
	echo "$$DATA">"$(APPSFOLDER)/mimeapps.list"
	echo 'Type associated'
