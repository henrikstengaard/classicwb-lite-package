# ClassicWB LITE Package

ClassicWB LITE is a feature rich Workbench enhancement by Bloodwych targeted A1200 using 4/8/16 colour screenmode using PAL / NTSC / Non-Interlaced 640x256 display.

## Description

ClassicWB LITE Package contains ClassicWB LITE v28 created by Bloodwych from EAB. 

With permission from Bloodwych it has been converted to a package for HstWB Installer.

Original version of ClassicWB LITE can be downloaded from http://classicwb.abime.net/.

## Requirements

ClassicWB LITE package can be installed on any Amiga with Amiga OS 3.2, 3.1.4 or 3.1 and about 41MB free space on a harddrive for installation.

## Installation

Download latest release from https://github.com/henrikstengaard/classicwb-lite-package/releases and copy it to HstWB Installer "packages" directory, which typically is "c:\Program Files (x86)\HstWB Installer\Packages".

Installation through HstWB Installer will install and configure ClassicWB LITE package using defined assigns.
During installation dialogs are presented to customize ClassicWB installation.

## Assigns

Installation of ClassicWB LITE package requires and uses following assign and default value:

- SYSTEMDIR: = DH0:

ClassicWB LITE files will be installed and configured in SYSTEMDIR: assign, which must be set to harddrive containing Workbench.

## Modifications

ClassicWB is installed from a zip file containing all files from ClassicWB System.hdf.

The install script for HstWB Installer is based on S/Startup-Sequence from ClassicWB System.hdf with following changes:

- Removed Workbench installation.
- Paths has been changed: SYS: to SYSTEMDIR:, C: to SYSTEMDIR:C/, L: to SYSTEMDIR:L/.
- Modified versions of Temp enable and disable option scripts with changed paths.
- Removed all "press enter to continue" expect last one used after installation complete message is shown.
- Removed and reduced waits.
- Adjusted text spacing.
- Creates backup of startup sequence as "S:Startup-Sequence.BAK".
- Creates backup of user startup as "S:User-Startup.BAK". 
- Creates backup of original ClassicWB LITE startup sequence as "S:Startup-Sequence.CWB".
- Creates backup of original ClassicWB LITE user startup as "S:User-Startup.CWB". 
- Patch startup sequence and user startup with ClassicWB LITE changes for best Amiga OS compatibility with existing and future versions.
- Added support for Amiga OS 3.2 and 3.1.4:
  - Disabled PatchRam, MinStack, TagLiFE, PatchWB, StackAttack, RamSnap, HDEnv, SmartWin, Border Blank, Copper, FBlit, ENV.
  - Reinstalled MUI.
  - Removed black text shadow for Retro and Re-Gen themes. 
  - Fix WB13 by always disabling Copper.

## Screenshots

Screenshots of ClassicWB LITE installed with Amiga OS 3.2.

![ClassicWB LITE 3.2 1](screenshots/classicwb_lite_3.2_1.png?raw=true)

![ClassicWB LITE 3.2 2](screenshots/classicwb_lite_3.2_2.png?raw=true)

![ClassicWB LITE 3.2 3](screenshots/classicwb_lite_3.2_3.png?raw=true)

![ClassicWB LITE 3.2 4](screenshots/classicwb_lite_3.2_4.png?raw=true)

Screenshots of ClassicWB LITE installed with Amiga OS 3.1.4.

![ClassicWB LITE 3.1.4 1](screenshots/classicwb_lite_3.1.4_1.png?raw=true)

![ClassicWB LITE 3.1.4 2](screenshots/classicwb_lite_3.1.4_2.png?raw=true)

![ClassicWB LITE 3.1.4 3](screenshots/classicwb_lite_3.1.4_3.png?raw=true)

![ClassicWB LITE 3.1.4 4](screenshots/classicwb_lite_3.1.4_4.png?raw=true)

Screenshots of ClassicWB LITE from http://classicwb.abime.net/classicweb/litepics.htm.

![ClassicWB LITE 1](screenshots/classicwb_lite1.png?raw=true)

![ClassicWB LITE 2](screenshots/classicwb_lite2.png?raw=true)

![ClassicWB LITE 3](screenshots/classicwb_lite3.png?raw=true)

![ClassicWB LITE 4](screenshots/classicwb_lite4.png?raw=true)

![ClassicWB LITE 5](screenshots/classicwb_lite5.png?raw=true)

![ClassicWB LITE 6](screenshots/classicwb_lite6.png?raw=true)

![ClassicWB LITE 7](screenshots/classicwb_lite7.png?raw=true)

![ClassicWB LITE 8](screenshots/classicwb_lite8.png?raw=true)

![ClassicWB LITE 9](screenshots/classicwb_lite9.png?raw=true)