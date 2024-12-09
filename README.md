## Compatible Magisk-mirroring
This module provides the compatible Magisk-mirroring (i.e., unmodified original system files (in a mounted state) mainly referred from the module installation script "customize.sh") for installing pure Magisk modules (before Magisk v28.0) on official Magisk v28.0 & v28.1, Magisk variants, KernelSU and APatch.
<br/>

For example, a typical Magisk module modifying an existing system file on "/vendor/etc" (say "/vendor/etc/audio_policy_configuration.xml") needs its unmodified original file for generating new one from it as intendedly by editing some parts in the original one, and putting it in "${MODPATH}/system/vendor/etc" so that Magisk shall overlay it on the original one on "/vendor" after booting up.

Because system files on "/vendor" might be modified already by the module itself (which has already been installed) or other Magisk modules when updating or newly installing the module in the Magisk manager, the module (usually "customize.sh") possibly fails to install or installs wrongly in silence by their interference. For avoiding such situation, experienced Magisk module developers use mirrored system files under "$(magisk --path)/.magisk/mirror" that are unmodified original. However Magisk v28.0 & v28.1 and some recent Magisk variants (e.g., Magsik alpha, Kitsune Mask, KernelSU and APatch) don't provide this mirrored system files to developers for some non-technical reason.

For resolving this situation, this module puts a tiny script in "/data/adb/post-fs-data.d" and patches and forces the Magisk v28.0 & v28.1 and its variants to provide the mirrored system files when updating, installing and even executing Magisk modules thereafter (but mainly for "customize.sh").

Without this module, developers must move some code (referring to unmodified original system files) in "customize.sh" into "post-fs-data.sh" (for handling almost unmodified original ones (but possibly already modified by "post-fs-data.sh" of another module) just before Magisk starts magic mounting) involuntarily for supporting such variants. It's very unfortunate, I think.

Although some people might think "customize.sh" could refer to the original sytem files by mounting mirrors in it, it isn't possible by normal means because system files have been mounted in a shared mode before installing magisk modules in the Magisk manager, and the mirrors provide only possibly modified ones by already installed Magisk modules. Be careful for such Magisk modules mounting mirrors by themselves in "customize.sh" because they cannot update themselves correctly.
<br/>

* Remark only for KernelSU and APatch: Because KernelSU doesn't allow any command named "magisk" to place in "/data/adb/ksu/bin" (or "/data/adb/ap/bin"), this module puts "ksu-magisk" command there instead (for both KernelSU and APatch). As the result, you have to replace every "magisk --path" command execution with "ksu-magisk --path" in all magisk standard shell scripts of a (pure) magisk modue ZIP file you intend to install. Typically you can do this by inserting `alias magisk='ksu-magisk'` line at the first line below the shebang line and its following comment ones for all the scripts.

* This module was made, and has been tested slightly on Magisk v28.0 & v28.1, Magisk alpha, Kitsune Mask, KernelSU and APatch, as a help for installing my other pure magisk modules on them.

* See also my magisk modules, ["Audio misc. settings"](https://github.com/Magisk-Modules-Alt-Repo/audio-misc-settings) , ["Audio Samplerate Changer"](https://github.com/Magisk-Modules-Alt-Repo/audio-samplerate-changer) , ["DRC remover"](https://github.com/Magisk-Modules-Alt-Repo/drc-remover), ["USB Samplerate Unlocker"](https://github.com/Magisk-Modules-Alt-Repo/usb-samplerate-unlocker) and ["Hifi Maximizer"](https://github.com/yzyhk904/hifi-maximizer-mod).
<br/><br/>

## DISCLAIMER

* I am not responsible for any damage that may occur to your device, so it is your own choice whether to attempt this module or not. This module doesn't guarantee any magisk module to be able to install and run on incompatible magisk variants and KernelSU.
<br/>

##
