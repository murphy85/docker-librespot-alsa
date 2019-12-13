# docker-librespot-alsa
This container runs a headless [Spotify](https://www.spotify.com/) player that can be remote-controlled by any Spotify app. Audio is output via [alsa](http://www.alsa-project.org/) to /dev/snd of host.

*This requires a Spotify premium account, but does not require a Spotify developer key or libspotify binary.*

## Run
Run with docker
```
docker run -d -e SPOTIFY_NAME=MySpotify -e SPOTIFY_USER=<deviceId> -e SPOTIFY_PASSWORD=<password> -e SPOTIFY_DEVICE=hw:0,0 -e SPOTIFY_BITRATE=320 --name Spotify -m 256M --cpus=".1" --device /dev/snd --restart unless-stopped murphy85/librespot-alsa
```
## Disclaimer
Using this code to connect to Spotify's API is probably forbidden by them. Use at your own risk.
## License
Everything in this repository is licensed under the MIT license.
## Related projects
* [librespot-org/librespot](https://github.com/librespot-org/librespot) - librespot project
* [kevineye/docker-librespot](https://github.com/kevineye/docker-librespot) - Docker image based on deprecated librespot
* [murphy85/docker-librespot](https://github.com/murphy85/docker-librespot) - Fork of [kevineye/docker-librespot](https://github.com/kevineye/docker-librespot) with current librespot project
