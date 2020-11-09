# Check_MK Telegram notification
Telegram has long been one of my real-time communication media. It is obvious to output monitoring messages for server and network components as alarm messages. There are several scripts for this on the internet, but most of them are written in Python, many of them have problems with Python3 and its libraries. Instead of spending hours and hours with Python, I decided to use a scripting language I know and write a Linux Bash script for it.

The following Script is for Check_MK, I have used it exclusively with the RAW version 1.6.0_p18.

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
wget https://github.com/filipnet/checkmk-telegram-notify/blob/main/check_mk_telegram-notify.sh
wget https://github.com/filipnet/checkmk-telegram-notify/blob/main/config.xml.sample
```
or 
```
git clone https://github.com/filipnet/checkmk-telegram-notify.git
cd checkmk-telegram-notify
cp check_mk_telegram-notify.sh /opt/omd/sites/mysite/local/share/check_mk/notifications/
cp config.xml.sample /opt/omd/sites/mysite/local/share/check_mk/notifications/
```

Adjusting the config.xml
```
cd /opt/omd/sites/mysite/local/share/check_mk/notifications/
cp config.xml.sample config.xml
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

No further settings are required for this.

## LICENSE
telegram and all individual scripts are under the BSD 3-Clause license unless explicitly noted otherwise. Please refer to the LICENSE
