# WPCLI Build with Linux Permissions
A docker wpcli setup using tatemz/wp-cli which can be built locally to use current user and www-data group.

The problem: in Linux docker uses `www-data` as the user executing wp-cli commands. This is fine for the wordpress container, but when it comes to developing files on linux we need shared permissions on the files.

This repo mainly exists to remind me how to fix this problem in the future. It's not intended to be a robust solution for everyone to use.

## What it does
 Builds a local `wpcli` image with your current user using the default group `www-data` for commands.

## Usage
 1. Checkout this repo and open your terminal in that directory.
 2. Run:
  ```sh
  docker build -t wpcli \
    --build-arg USER_ID=$(id -u) \
  ```
 3. Edit your docker-compose file if used:
  ```
  wpcli:
    image: wpcli
    volumes:
      - ${WP_CORE}:/var/www/html
      - ${WP_CONTENT}:/var/www/html/wp-content
    depends_on:
      - db
    entrypoint: wp
    labels:
      - "traefik.enable=false"
    entrypoint: /bin/wp-cli.phar
    command: --info
  ```
  The important part here is the `entrypoint: /bin/wp-cli.phar` part. This is to override Tatemz's sh script that runs as www-data.

  You might ask why even base this on tatemz docker, since that script is probably the main thing being provided, and you might be right.

## References
[Docker Shared Permissions from vsupalov.com](https://vsupalov.com/docker-shared-permissions/) - Explanation of permissions in docker/linux with some general solutions
[Tatemz Docker wp-cli](https://github.com/tatemz/docker-wpcli) - Go-to for wp-cli in docker
