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
export FACEBOOK_PAGE_ACCESS_TOKEN=<<your_page_access_token_given_by_facebook_in_step_4>>

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
export FACEBOOK_PAGE_ACCESS_TOKEN=<<your_page_access_token_given_by_facebook_in_step_4>>

mindchat_app/bin/server
```

> Note: Ensure that port 4000 is accessible through the firewall from external networks through a static IP or URL.

## IMPORTANT: Setting up Webhooks properly

1. Create a new Facebook [app](https://developers.facebook.com/apps/create/).

2. After app creation set up Messenger by clicking on `Set up`.

3. In Messenger settings, create a new page or add an existing page.

4. Go back to Messenger Settings page and generate access token with `Generate token` button and copy the token generated.

5. In your server, export the access token and a webhook token by adding lines like the following to the end of .bashrc or to your os specific profile.

```bash
export SECRET_KEY_BASE=<provide_a_secret_key_base>
export FACEBOOK_WEBHOOK_VERIFY_TOKEN=<provide_a_webhook_token_string>
export FACEBOOK_PAGE_ACCESS_TOKEN=<your_page_access_token_given_by_facebook_in_step_4>
```

6. Start your mindchat server after exporting the required environment variables

```bash
source ~/.bashrc
docker run -p 4000:4000 -e FACEBOOK_PAGE_ACCESS_TOKEN -e FACEBOOK_WEBHOOK_VERIFY_TOKEN -e SECRET_KEY_BASE vijlaks/mindchat:v1
```

7. Back in the Messenger Settings page, click `Add Callback URL` in webhook section and enter the Callback URL thats got by appending `/api/facebook_webhook` to your app server endpoint. Example: `https://mindchat.pagekite.me/api/facebook_webhook`. Also provide verify token that you created in step 5 and click `Verify and save`.

8. In Webhooks section click on `Add subscriptions` and subscribe to *messages*, *messaging_postbacks*, *messaging_optins*, *messaging_optouts* and *message_deliveries*.

9. Initialize Messenger welcome page using the following curl command, after substituting the facebook page access token in the command.

```bash
curl -X POST -H "Content-Type: application/json" -d '{
  "get_started": {"payload": "welcome"}
}' "https://graph.facebook.com/v2.6/me/messenger_profile?access_token=<your_page_access_token_given_by_facebook_in_step_4>"
```

> NOTE: Only after completing step 9, when you open the Messenger on your facebook page, `Get started` button will appear. And when you click it, "welcome" postback handler of our app server is invoked and the chatbot starts and the conversation can happen.

## Hope you like the demo !

Thanks for the opportunity.
