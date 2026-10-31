# Redmine Project Menu Tabs Reorder

A lightweight, powerful plugin designed for **Redmine 7.0.x** that allows administrators to dynamically rearrange project and global application menu tabs using a visual drag-and-drop sorting interface.

## Features
* **Visual Sorter:** Intuitive drag-and-drop vertical list interface embedded right inside the plugin settings.
* **Unified Scope:** Safely reorders menu items across both high-level global layouts and individual project-level pages.
* **Third-Party Compatibility:** Automatically preserves and falls back to accommodate menu tabs loaded by other installed plugins.
* **UI Cleanliness:** Dynamically overwrites labels and strips standard black browser pop-up tooltips for a modern dashboard look.

## Requirements
* **Redmine:** `7.0.0` or higher
* **Ruby:** `4.x`
* **Rails:** `8.1.4` or higher

(It may also work with other versions)
---
### Additional Locale Translations
### Example Mapping Setups ('de.yml')

Create your target language string map inside plugin's `config/locales/` directory using the following structures:

#### German (Deutch) Layout (`de.yml`)

Create a new file at plugins/redmine_menutabs_reorder/config/locales/de.yml and paste the following content:
```yaml
de:
  project_tab_titles:
    overview: "Übersicht"
    activity: "Aktivität"
    roadmap: "Roadmap"
    issues: "Tickets"
    time_entries: "Zeitaufwand"
    gantt: "Gantt-Diagramm"
    calendar: "Kalender"
    news: "Meldungen"
    documents: "Dokumente"
    wiki: "Wiki"
    boards: "Foren"
    files: "Dateien"
    repository: "Projektarchiv"
    settings: "Einstellungen"
```

## Installation Steps

### 1. Position the Directory
Ensure your folder is placed under your Redmine installation directory and matches the internal module architecture requirements exactly:
```text
/path/to/redmine/plugins/redmine_menutabs_reorder/
```
*Note: The physical directory name must be exactly `redmine_menutabs_reorder` to align with the plugin namespace.*

### 2. Install Bundle Dependencies
Run the installation sequencer from your core Redmine root path to register the plugin environment hooks:
```bash
cd /path/to/redmine
bundle install --without development test
```

### 3. Clear Cache & Restart Server
Purge stale framework view paths and reload your web server instance to load the new modules:
```bash
# Clear application rendering caches
bundle exec rake tmp:cache:clear RAILS_ENV="production"

# Trigger a reload (Passenger / Puma / Nginx)
touch tmp/restart.txt
```

---

## How to Configure

1. Log into your Redmine instance as an **Administrator**.
2. Navigate to **Administration** -> **Plugins**.
3. Locate **Redmine Project Menu Tabs Reorder** and click **Configure**.
4. Drag and drop the menu rows into your desired default priority sequence.
5. Click **Apply** to save changes.

### Third-Party Plugin Tabs Notice
Any menu items created by other third-party extensions (e.g., *Agile, Checklists, Scrum*) that aren't explicitly sorted in source code will stay secure and automatically dock at the end of the sequence.

You may reposition them from configuration page.

---

## Troubleshooting Initialization Errors

If you encounter an error after Installation just remove "redmine_menutabs_reorder" directory from redmine/plugins/ directory an trigger a reload your webserver.
