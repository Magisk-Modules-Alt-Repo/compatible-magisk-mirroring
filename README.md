## Compatible Magisk-mirroring
This module provides the compatible Magisk-mirroring (i.e., unmodified original system files (in a mounted state) mainly referred from the module installation script "customize.sh") for installing pure Magisk modules on incompatible Magisk variants and KernelSU.
<br/>

For example, a typical Magisk module modifying an existing system file on "/vendor/etc" (say "/vendor/etc/audio_policy_configuration.xml") needs its unmodified original file for generating new one from it as intendedly by editing some parts in the original one, and putting it in "${MODPATH}/system/vendor/etc" so that Magisk shall overlay it on the original one on "/vendor" after booting up.

Because system files on "/vendor" might be modified already by other Magisk modules and even by the module itself (which has already been installed) when installing or updating the module in the Magisk manager, the module (usually "customize.sh") possibly fails to install or installs wrongly in silence by their interference. For avoiding such situation, experienced Magisk module developers use mirrored system files under "$(magisk --path)/.magisk/mirror" that are unmodified original. However some recent Magisk variants (e.g., Magsik alpha, Kitsune Magisk, and KernelSU) don't provide this mirrored system files to developers for some non-technical reason.

For resolving this situation, this module puts a tiny script in "/data/adb/post-fs-data.d" and patches and forces the Magisk variants to provide the mirrored system files when installing, updating and even executing Magisk modules thereafter (but mainly for "customize.sh").

Without this module, developers must move some code (referring to unmodified original system files) in "customize.sh" into "post-fs-data.sh" (for handling almost unmodified original ones just before Magisk starts magic mounting) involuntarily for supporting such variants. It's very unfortunate, I think.

Although some people think "customize.sh" could refer to the original sytem files by mounting mirrors in it, it isn't possible by normal way because system files have been mounted in a shared mode before installing magisk modules in the Magisk manager, and the mirrors provide only possibly modified ones by already installed Magisk modules.
<br/>

* Remark only for KernelSU: Because KernelSU doesn't allow any command named "magisk" to place in "/data/adb/ksu/bin", this module puts "ksu-magisk" command there instead. As the result, you have to replace all "magisk --path" command executions with "ksu-magisk --path" in all magisk standard shell scripts of a (pure) magisk modue ZIP file you intend to install. Typically you can do this by inserting `alias magisk='ksu-magisk'` line at the first line below the shebang line and its following comment ones for all the scripts.

* This module was made, and has been tested slightly on Magisk alpha, Kitsune Magisk and KernelSU, as a help for installing my other pure magisk modules on them.

* See also my magisk modules, ["Audio misc. settings"](https://github.com/Magisk-Modules-Alt-Repo/audio-misc-settings) , ["DRC remover"](https://github.com/Magisk-Modules-Alt-Repo/drc-remover), ["USB Samplerate Unlocker"](https://github.com/Magisk-Modules-Alt-Repo/usb-samplerate-unlocker) and ["Hifi Maximizer"](https://github.com/yzyhk904/hifi-maximizer-mod).
<br/><br/>

## DISCLAIMER

* I am not responsible for any damage that may occur to your device, so it is your own choice to attempt this module. This module doesn't guarantee any magisk module to be able to install and run on incompatible magisk variants and KernelSU.
<br/>

##
