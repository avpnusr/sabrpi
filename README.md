**SABnzbd in container for x86_64 CPUs**
===

Image is automatically updated, when a new version of SABnzbd arrives on GitHub. 
The image is based on alpine Linux.

Versions in the latest image
-----
- [SABnzbd](https://sabnzbd.org "SABnzbd Homepage") Version: 2.3.9
- PAR2 from [par2cmdline](https://github.com/Parchive/par2cmdline) Version: 0.8.0

Tested and compatible with following devices
----
- Raspberry Pi
- Raspberry Pi2
- Raspberry Pi3 (all models)
- Raspberry Pi4 (all models)
- Raspberry Pi Zero
- Rock64
- RockPro64
- TinkerBoard
- TinkerBoard S

Start your container
-----
- For **[/config/location]**, use the folder, where your **sabnzbd.ini** file is stored.
- For **[/complete/folder]**, you can use the folder, where your completed downloads will be stored.
- For **[/incomplete/folder]**, use the folder, where the temporary files will be stored, until download is finished.

````
docker run -d \
  -v [/config/location]:/config \
  -v [/complete/folder]:/complete \
  -v [/incomplete/folder]:/incomplete \
  -e UID=[Users UID] \
  -e GID=[Users GID] \
  -p 8080:8080 \
  --restart=unless-stopped avpnusr/sabrpi
