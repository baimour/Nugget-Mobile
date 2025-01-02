![Artboard](https://github.com/leminlimez/Nugget-Mobile/blob/1881fdc2b721fd2675a2909e7fbc24769d11bb53/readme-images/icon.png)

# Nugget (mobile)
释放您设备的全部潜力！适用于所有版本的iOS 16.0-18.2 Beta 2（Public Beta 1）。

这在iOS 18.2 Beta 2或更高版本上不起作用。请不要对此提出问题，它不会被修复。你必须使用 [PC版的Nugget](https://github.com/leminlimez/Nugget) 除非将来有解决办法

要使用它，需要一个 `.mobiledevicepairing` 文件和WireGuard，阅读下面的[部分](#getting-your-mobiledevicepairing-file) 了解如何获取这些文件

如果您在使用minimuxer时遇到问题，请参考 [解决Minimuxer问题](#solving-minimuxer-issues)

这使用Sparserestore漏洞来写入预期还原位置之外的文件，如mobilegestalt

注意：如果您的设备出现启动循环，我概不负责，请谨慎使用本软件。使用前请备份数据！

## 获取您的移动设备配对文件
要获取配对文件，请执行以下步骤：
1. 下载 `jitterbugpair` for your system from here: <https://github.com/osy/Jitterbug/releases/latest>
    - **Note:** On mac or linux, you may have to run the terminal command `chmod +x ./jitterbugpair` in the same directory.
2. Run the program by either double clicking it or using terminal/powershell
3. Share the `.mobiledevicepairing` file to your iOS device
4. Open the app 和 select the pairing file

除非你丢失了文件并删除了应用程序的数据，否则你应该只做一次

## 设置WireGuard
1. 下载 [WireGuard](<https://apps.apple.com/us/app/wireguard/id1441195209>) on the iOS App Store.
2. 下载 [SideStore's config file](https://github.com/sidestore/sidestore/releases/download/0.1.1/sidestore.conf) on your iOS device
3. 使用分享菜单将配置文件导入到WireGuard
4. 启用它并运行Nugget

## 解决Minimuxer问题
如果您以前使用过Cowabunga Lite，您可能会遇到minimuxer的问题。这是由于它跳过了设置进程
这些步骤应该能解决问题，但这并不是万能
1. 下载 [Nugget Python](https://github.com/leminlimez/Nugget) 并按照描述中的步骤安装Python和要求
2. Connect your device 和 (in terminal) type `python3 fix-minimuxer.py` (or `python fix-minimuxer.py` if it doesn't work)

您的设备应该重新启动。重启后，立即尝试Nugget手机。如果仍然不起作用，请按照以下步骤操作：

3. After your device reboots, go to `[Settings] -> General -> Transfer or Reset iPhone`
4. Tap `Reset` and then `Reset Location & Privacy`
5. Nugget mobile should work now. If it doesn't, try getting a new pairing file.

If the steps above don't work for you, try using `Cowabunga Lite` and clicking the `Deep Clean` button, then try the steps again.
If not even that works, the only solution I know is to wipe the device (not ideal). I would recommend using [Nugget Python](https://github.com/leminlimez/Nugget) instead in this case.

## 致谢
- [JJTech](https://github.com/JJTech0130) for Sparserestore/[TrollRestore](https://github.com/JJTech0130/TrollRestore)
- khanhduytran for [Sparsebox](https://github.com/khanhduytran0/SparseBox)
- [pymobiledevice3](https://github.com/doronz88/pymobiledevice3)
- [disfordottie](https://x.com/disfordottie) for some global flag features
- f1shy-dev for the old [AI Enabler](https://gist.github.com/f1shy-dev/23b4a78dc283edd30ae2b2e6429129b5#file-eligibility-plist)
- [SideStore](https://sidestore.io/) for em_proxy and minimuxer
- [libimobiledevice](https://libimobiledevice.org) for the restore library
