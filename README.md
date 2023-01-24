# MindChat

MindChat is a demo application developed with Phoenix/Elixir/Erlang and Facebook Messenger webhooks for MValley.

## Installation using prebuilt Docker Image

On Debian and Ubuntu based systems use apt to install Docker. Tested on Ubuntu 20.04.5 (Focal Fossa). For other/incompatible OS and versions, please see [Docker](https://docs.docker.com/engine/install/) for guidance.

```bash
sudo apt install docker.io -y
```

Fetch my pre-built Docker Image.

```bash
docker pull vijlaks/mindchat:v1
```

## Usage of Docker Image

Run the container with port mapping and environment variables pass-through.

```bash
export FACEBOOK_WEBHOOK_VERIFY_TOKEN=mindvalleychatbot
export SECRET_KEY_BASE=gCEvRyAfve0o49uy1abgkmvvp539d8bV9hevU0D7bk1Qegks8nKJDK2ZexItZu5W
export FACEBOOK_PAGE_ACCESS_TOKEN=EAARq4Cea5tEBAEvRKZCcCiHH58k2lnvN1mta4Ow3jZBlKntKyZCm8m08jPYP2Gtu1u5T2FIm89FGDo4XAMbQkhqY3ZCVV4TIuQXr4ozRIYHZCJOUT6do7MgPLksl7h3c5II931t9PhtgFtZAH8fP0khvDp031kGhIMZBl2KaV5NAYK8gavUQwOaL1ZCTXD2wHrwZD

docker run -p 4000:4000 -e FACEBOOK_PAGE_ACCESS_TOKEN -e FACEBOOK_WEBHOOK_VERIFY_TOKEN -e SECRET_KEY_BASE vijlaks/mindchat:v1
```

> Note: Ensure that port 4000 is accessible through the firewall from external networks through a static IP or URL.

## Building from source

These instructions have only been tested on Ubuntu 20.04.5 Server (Focal Fossa).

```bash
wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb
sudo dpkg -i erlang-solutions_2.0_all.deb
sudo apt-get update
sudo apt-get install elixir erlang-dev erlang-xmerl -y
mix local.hex --force
```

Download the mindchat source files directory thats available as part of this upload/archive.

```bash
cd mindchat
export MIX_ENV=prod
mix deps.get --only prod
mix deps.compile
mix assets.deploy
mix compile
mix phx.gen.release
mix release
```

> The production-ready binaries are now available at `_build/prod/rel/mindchat` . We can extract those and clean up the source and intermediate builds.

```bash
cd ..
mv mindchat/_build/prod/rel/mindchat mindchat_app
rm -r mindchat
```

## Usage of built & deployed Release

Set the environment variables and start the server.

```bash
export FACEBOOK_WEBHOOK_VERIFY_TOKEN=mindvalleychatbot
export SECRET_KEY_BASE=gCEvRyAfve0o49uy1abgkmvvp539d8bV9hevU0D7bk1Qegks8nKJDK2ZexItZu5W
export FACEBOOK_PAGE_ACCESS_TOKEN=EAARq4Cea5tEBAEvRKZCcCiHH58k2lnvN1mta4Ow3jZBlKntKyZCm8m08jPYP2Gtu1u5T2FIm89FGDo4XAMbQkhqY3ZCVV4TIuQXr4ozRIYHZCJOUT6do7MgPLksl7h3c5II931t9PhtgFtZAH8fP0khvDp031kGhIMZBl2KaV5NAYK8gavUQwOaL1ZCTXD2wHrwZD

mindchat_app/bin/server
```

> Note: Ensure that port 4000 is accessible through the firewall from external networks through a static IP or URL.

## Hope you like the demo !

Thanks for the opportunity.
