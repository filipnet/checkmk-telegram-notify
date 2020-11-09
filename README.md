# Check_MK Telegram notification
<img src="images/telegram_notification_example.png" alt="Telegram notification example" width="400" align="right"/>
Telegram has long been one of my real-time communication media. It is obvious to output monitoring messages for server and network components as alarm messages. There are several scripts for this on the internet, but most of them are written in Python, many of them have problems with Python3 and its libraries. Instead of spending hours and hours with Python, I decided to use a scripting language I know and write a Linux Bash script for it.

The following Script is for Check_MK, I have used it exclusively with the RAW version 1.6.0_p18.

<!-- TOC -->

- [Check_MK Telegram notification](#check_mk-telegram-notification)
    - [REQUIREMENTS](#requirements)
    - [INSTALLATION](#installation)
    - [CHECK_MK CONFIGURATION](#check_mk-configuration)
    - [LICENSE](#license)

<!-- /TOC -->

## REQUIREMENTS
In order for Check_MK to send alerts (notifications) to the Telegram Messenger, we need

* a bot
* a username for the bot
* an API token
* a chat ID

There are a lot of good instructions for this on the Internet, so this is not part of this documentation.

## INSTALLATION
Change to your Check_MK site user
```
su - mysite
```

Change to the notification directory
```
cd ~/local/share/check_mk/notifications/
```

Download the Telegram notify script from Git repository
```
git clone https://github.com/filipnet/checkmk-telegram-notify.git .
```

Adjusting the config.xml
```
cd /opt/omd/sites/mysite/local/share/check_mk/notifications/
mv config.xml.sample config.xml
```

Inside your API Token and Chat/Group-ID
```
<telegram_api_token>TELEGRAM_API_TOKEN_WITHOUT_BOT_PREFIX</telegram_api_token>
<telegram_chat_id>TELEGRAM_GROUP_OR_CHAT-ID</telegram_chat_id>
```

Give the script execution permissions
```
chmod +x check_mk_telegram-notify.sh
```

## CHECK_MK CONFIGURATION
Now you can create your own alarm rules in Check_MK.

```WATO → Notifications → New Rule → Notification Method → Push Notification (using Telegram)```

First create a clone of your existing mail notification rule

<img src="images/global_notification_rules_create_clone.png" alt="Create clone" width="600"/>

Change the description and select "Push Notification (by Telegram)", no further settings are required for this.

<img src="images/create_new_notification_rule_for_telegram.png" alt="Adjust settings" width="600"/>

If everything was ok, you will see your new Notification Rule afterwards

<img src="images/notification_configuration_change.png" alt="Final result" width="600"/>

To activate it you have to press "1 Change" and "Activate affected"

<img src="images/activate_affected.png" alt="Activate changes and commit" width="100"/>

## LICENSE
checkmk-telegram-notify and all individual scripts are under the BSD 3-Clause license unless explicitly noted otherwise. Please refer to the LICENSE
