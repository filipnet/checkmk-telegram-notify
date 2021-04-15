#!/bin/bash
# Push Notification (using Telegram)
#
# Script Name   : check_mk_telegram-notify.sh
# Description   : Send Check_MK notifications by Telegram
# Author        : https://github.com/filipnet/checkmk-telegram-notify
# License       : BSD 3-Clause "New" or "Revised" License
# ======================================================================================

# Telegram API Token
# Find telegram bot named "@botfarther", type /mybots, select your bot and select "API Token" to see your current token
if [ -z ${NOTIFY_PARAMETER_1} ]; then
        echo "No Telegram token ID provided. Exiting" >&2
        exit 2
else
        TOKEN="${NOTIFY_PARAMETER_1}"
fi

# Telegram Chat-ID or Group-ID
# Open "https://api.telegram.org/bot<YOUR_TOKEN>/getUpdates" inside your Browser and send a HELLO to your bot, refresh side
if [ -z ${NOTIFY_PARAMETER_2} ]; then
        echo "No Telegram Chat-ID or Group-ID provided. Exiting" >&2
        exit 2
else
        CHAT_ID="${NOTIFY_PARAMETER_2}"
fi

# Create a MESSAGE variable to send to your Telegram bot
MESSAGE="${NOTIFY_HOSTNAME} (${NOTIFY_HOSTALIAS})%0A"
MESSAGE+="${NOTIFY_WHAT} ${NOTIFY_NOTIFICATIONTYPE}%0A%0A"
if [[ ${NOTIFY_WHAT} == "SERVICE" ]]; then
        MESSAGE+="${NOTIFY_SERVICEDESC}%0A"
        MESSAGE+="State changed from ${NOTIFY_PREVIOUSHOSTHARDSHORTSTATE} to ${NOTIFY_SERVICESHORTSTATE}%0A"
        MESSAGE+="${NOTIFY_SERVICEOUTPUT}%0A"
else
        MESSAGE+="State changed from ${NOTIFY_PREVIOUSHOSTHARDSHORTSTATE} to ${NOTIFY_HOSTSHORTSTATE}%0A"
        MESSAGE+="${NOTIFY_HOSTOUTPUT}%0A"
fi
MESSAGE+="%0AIPv4: ${NOTIFY_HOST_ADDRESS_4} %0AIPv6: ${NOTIFY_HOST_ADDRESS_6}%0A"
MESSAGE+="${NOTIFY_SHORTDATETIME}"

# Send message to Telegram bot
curl -S -X POST "https://api.telegram.org/bot${TOKEN}/sendMessage" -d chat_id="${CHAT_ID}" -d text="${MESSAGE}"
if [ $? -ne 0 ]; then
        echo "Not able to send Telegram message" >&2
        exit 2
else
        exit 0
fi
