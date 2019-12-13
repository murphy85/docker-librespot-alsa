# docker-librespot-alsa
This container runs a headless [Spotify](https://www.spotify.com/) player that can be remote-controlled by any Spotify app. Audio is output via [alsa](http://www.alsa-project.org/) to /dev/snd of host.

*This requires a Spotify premium account, but does not require a Spotify developer key or libspotify binary.*

## Prerequisites
Setup your Spotify device id and password: [https://www.spotify.com/de/account/set-device-password/](https://www.spotify.com/de/account/set-device-password/)
## Run
Run with docker
```
docker run -d -e SPOTIFY_NAME=MySpotify -e SPOTIFY_USER=<deviceId> -e SPOTIFY_PASSWORD=<password> -e SPOTIFY_DEVICE=hw:0,0 -e SPOTIFY_BITRATE=320 --name Spotify -m 256M --cpus=".1" --device /dev/snd --restart unless-stopped murphy85/librespot-alsa
```
The above command will create a receiver named Librespot, with bitrate set to 320kbps, initial volume at 75%, with volume normalisation enabled, and the device displayed in the app as an Audio/Video Receiver. A folder named `/tmp` will be created/used in the current directory, and be used to cache audio data and credentials.
### Settings
| Name             | Description                          |
| -----------------|--------------------------------------|
| SPOTIFY_NAME     | Device name displayed in Spotify app |
| SPOTIFY_USER     | Your Spotify device id               |
| SPOTIFY_PASSWORD | Your Spotify device password         |
| SPOTIFY_DEVICE   | Hardware device of host              |
| SPOTIFY_BITRATE  | Bitrate (96, 160, 320)               |
## Disclaimer
Using this code to connect to Spotify's API is probably forbidden by them. Use at your own risk.
## License
Everything in this repository is licensed under the MIT license.
## Related projects
* [librespot-org/librespot](https://github.com/librespot-org/librespot) - librespot project
* [kevineye/docker-librespot](https://github.com/kevineye/docker-librespot) - Docker image based on deprecated librespot
* [murphy85/docker-librespot](https://github.com/murphy85/docker-librespot) - Fork of [kevineye/docker-librespot](https://github.com/kevineye/docker-librespot) with current librespot project
