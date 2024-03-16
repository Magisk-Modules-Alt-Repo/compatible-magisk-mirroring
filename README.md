## Compatible Magisk-mirroring
This module provides the compatible Magisk-mirroring for installing pure Magisk modules on incompatible Magisk variants and KernelSU. 
<br/>

* Remark only for KernelSU: KernelSU cannot allow "magisk" named command in "/data/adb/ksu/bin", so this module puts "ksu-magisk" command instead. As the result, you have to replace every "$(magisk --path)" command execution with "$(ksu-magisk --path)" in all shell scripts of a (pure) magisk modue ZIP file you intend to install.

* This module was made and has been tested slightly on Magisk alpha, Kitsune Magisk and KernelSU, as a help for installing my other pure magisk modules on them.

* See also my companion magisk module ["Audio misc. settings"](https://github.com/Magisk-Modules-Alt-Repo/audio-misc-settings) for simply improving audio quality with respect to the number of media volume steps and resampling distortion of the Android OS mixer (AudioFlinger), and my root script ["USB_SampleRate_Changer"](https://github.com/yzyhk904/USB_SampleRate_Changer) to change the sample rate of the USB (HAL) audio class driver and a 3.5mm jack on the fly like Bluetooth LDAC or Windows mixer to enjoy high resolution sound or to reduce resampling distortion (actually pre-echo, ringing and intermodulation) ultimately. 
<br/><br/>

## DISCLAIMER

* I am not responsible for any damage that may occur to your device, so it is your own choice to attempt this module. This module doesn't guarantee any magisk module to be able to install and run on incompatible magisk variants and KernelSU.
<br/>

##
