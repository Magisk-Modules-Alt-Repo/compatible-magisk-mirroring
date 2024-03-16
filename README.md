## Compatible Magisk-mirroring
This module provides the compatible Magisk-mirroring for installing pure Magisk modules on incompatible Magisk variants and KernelSU. 
<br/>

* Remark only for KernelSU: As KernelSU doesn't allow any command named "magisk" in "/data/adb/ksu/bin", this module puts "ksu-magisk" command there instead. As the result, you have to replace all "magisk --path" command executions with "ksu-magisk --path" in all magisk standard shell scripts of a (pure) magisk modue ZIP file you intend to install. Typically you can do this by inserting `alias magisk='ksu-magisk'` line at the first line except shebang and comment lines for all the scripts.

* This module was made, and has been tested slightly on Magisk alpha, Kitsune Magisk and KernelSU, as a help for installing my other pure magisk modules on them.

* See also my magisk modules, ["Audio misc. settings"](https://github.com/Magisk-Modules-Alt-Repo/audio-misc-settings) , ["DRC remover"](https://github.com/Magisk-Modules-Alt-Repo/drc-remover), ["USB Samplerate Unlocker"](https://github.com/Magisk-Modules-Alt-Repo/usb-samplerate-unlocker) and ["Hifi Maximizer"](https://github.com/yzyhk904/hifi-maximizer-mod).
<br/><br/>

## DISCLAIMER

* I am not responsible for any damage that may occur to your device, so it is your own choice to attempt this module. This module doesn't guarantee any magisk module to be able to install and run on incompatible magisk variants and KernelSU.
<br/>

##
