# Variables
SYSTEMD_DIR = /etc/systemd/system
SERVICE_FILES = $(wildcard *.service)
TIMER_FILES = $(wildcard *.timer)
TARGET_FILES = $(wildcard *.target)
ENV_FILES = $(wildcard *.env)
ALL_FILES = $(SERVICE_FILES) $(TIMER_FILES) $(TARGET_FILES) $(ENV_FILES)

# Default target
.PHONY: all install uninstall clean reload

all: install

# Install service files
install: $(ALL_FILES)
	@echo "Installing systemd service files..."
	sudo install -m 644 -t $(SYSTEMD_DIR) $(ALL_FILES)
	sudo systemctl daemon-reload
	@echo "Installed: $(ALL_FILES)"

# Remove installed files
uninstall:
	@echo "Removing systemd service files..."
	sudo rm -f $(addprefix $(SYSTEMD_DIR)/, $(ALL_FILES))
	sudo systemctl daemon-reload
	@echo "Removed: $(ALL_FILES)"

# Reload systemd daemon
reload:
	sudo systemctl daemon-reload

# Check what would be installed
dry-run:
	@echo "Files to install: $(ALL_FILES)"
	@echo "Target directory: $(SYSTEMD_DIR)"
