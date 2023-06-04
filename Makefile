.SILENT: all setup uninstall update_database associate trusted _create_dirs
SHELL := /usr/bin/env bash
APPS_FOLDER = $(HOME)/.local/share/applications
BASIC_MIME_FOLDER = $(HOME)/.local/share/mime/
MIMES_FOLDER = $(BASIC_MIME_FOLDER)packages
IS_ROOT = $(shell id -u)
LAUNCHER_FILE = "$(APPS_FOLDER)/ProgramPackLauncher.desktop"
MIME_FILE = "$(MIMES_FOLDER)/x-programpack-extension.xml"
CACHE_DIR = ~/.cache
CACHE_FILE = $(CACHE_DIR)/programpack_mime_set.flag

define DATA
[Added Associations]
custom-mime/custom-programpack-mime-type=ProgramPackLauncher.desktop
endef

export DATA

all: setup update_database associate
_create_dirs:
	echo 'Creating directories...'
	mkdir -p "$(APPS_FOLDER)"
	echo 'Apps directory created'
	mkdir -p "$(MIMES_FOLDER)"
	echo 'Mimetypes directory created'
	echo 'Directories created'
setup:
	echo 'Starting...'
	$(MAKE) _create_dirs
	cp "desktop/ProgramPackLauncher.desktop" "$(LAUNCHER_FILE)"
	echo 'Application .desktop file copied'
	cp "mimetype/programpack-extension.xml" "$(MIME_FILE)"
	echo 'Mimetype copied'
	$(MAKE) trusted
	echo 'Done!"'
uninstall:
	echo 'Starting to uninstall...'
	$(MAKE) _create_dirs
	rm -f "$(LAUNCHER_FILE)"
	rm -f "$(MIME_FILE)"
	rm -f "$(CACHE_FILE)"
	echo 'Successfully uninstalled'
update_database:
	echo 'Updating database(s)...'
	update-mime-database $(BASIC_MIME_FOLDER)
	if [ $(IS_ROOT) == 0 ]; then \
		update-mime-database /usr/share/mime; \
		echo 'Is root: updated the /usr/share/mime database'; \
	else \
		echo "Not root: didn't update the /usr/share/mime database"; \
	fi
	echo "Database(s) updated"
associate:
	echo 'Associating types...'
	if [ -f $(CACHE_FILE) ]; then \
		echo 'Type have been already associated'; \
	else \
		echo "$$DATA">>"$(APPS_FOLDER)/mimeapps.list"; \
		mkdir -p $(CACHE_DIR); \
		touch $(CACHE_FILE); \
	fi
	echo 'Type associated'
trusted:
	echo 'Making file trusted...'
	gio set "$(LAUNCHER_FILE)" 'metadata::trusted' yes
	echo 'Making file executable...'
	chmod 777 "$(LAUNCHER_FILE)"
	echo 'File should be trusted now'
