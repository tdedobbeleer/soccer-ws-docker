[![CircleCI](https://dl.circleci.com/status-badge/img/gh/tdedobbeleer/soccer-angular/tree/master.svg?style=shield)](https://dl.circleci.com/status-badge/redirect/gh/tdedobbeleer/soccer-angular/tree/master)

# soccer-ws-docker
Docker image for soccer ws.

Triggered by soccer-ws project when tag is successfully pushed and built.
Using docker buildx to generate image for multiple platforms.

Tags:
- latest
- $VERSION_$DATE (e.g. 1.0.0_2562421, used for version pinning.)
- $VERSION (e.g. 1.0.0, the version of soccer-ws is stable, the image itself can be updated.

Generally speaking, the $VERSION tag is also safe for production. Only latest can contain code changes.
