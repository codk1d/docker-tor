## CREDITS
* [Jess Frazelle](https://github.com/jfrazelle) for [containers on the deskop](https://blog.jessfraz.com/post/docker-containers-on-the-desktop/).

## WHAT DOES THIS DO?
This is a container that runs Tor.

## WHY?
* Avoid cookies and tracking and stuff... maybe.
* Impress your friends by running a GUI application in Docker.

## SHOULD YOU RELY ON THIS?
**NO!** This Docker image is a toy. Do not rely on it to protect yourself. Should you need this sort of thing, use something [built by experts](https://www.torproject.org/projects/torbrowser.html).

## HOW TO RUN IT?
0. Make sure you're on a system running [X](https://en.wikipedia.org/wiki/X_Window_System).
1. Disable X access control (don't do this on a public-facing machine): `$ xhost +`
2. ``$ docker run --rm -it -v /tmp/.X11-unix:/tmp/.X11-unix -v `pwd`:`pwd` -e DISPLAY=$DISPLAY hackenfreude/tor``
3. Have fun. Close the Tor window when you're done, and the container will shut down.
4. __Reenable X access control:__ `$ xhost -`

## WHAT JUST HAPPENED?
* Docker mounted the host's X socket in the continer as the container's X socket; this allows the container's GUI to pass back up to the host.

## WHAT IF IT DOESN'T WORK?
Open an [issue](https://github.com/hackenfreude/docker-tor/issues/new).

