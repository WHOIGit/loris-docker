The files in this repository build a Docker container for the [Loris IIIF Image Server][loris].

You may be interested in the official [loris-docker][] repository, but at the time of writing, this was severely outdated.

[loris]: https://github.com/loris-imageserver/loris
[loris-docker]: https://github.com/loris-imageserver/loris-docker


## Building the image

    wget https://github.com/loris-imageserver/loris/archive/v3.0.0.tar.gz
    tar xzf v3.0.0.tar.gz
    ln -s loris-3.0.0 loris
    docker build --tag whoi/loris .


## Using the image

    docker run --rm -it \
        --publish 8000:80 \
        --volume /path/to/images:/usr/local/share/images:ro \
        whoi/loris

This serves images from the `/path/to/images` directory. An image can be requested with a URL such as:

    http://localhost:8000/photo.jpg/full/pct:10/90/default.png

Refer to the [IIIF Image API 2.0][api] documentation for details.

[api]: https://iiif.io/api/image/2.0


### Loris configuration

To override the Loris configuration, map in a different configuration file:

    --volume /path/to/loris2.conf:/etc/loris2.conf


### Cache directory

By default, the image cache is created inside the container. To store the cache outside of the container:

    --volume /path/to/cache:/var/cache/loris

Note that this directory must be writable by the `nginx` user inside the container.
