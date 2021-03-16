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
TOKEN=$NOTIFY_PARAMETER_1

# Telegram Chat-ID or Group-ID
# Open "https://api.telegram.org/bot<YOUR_TOKEN>/getUpdates" inside your Browser and send a HELLO to your bot, refresh side
CHAT_ID=$NOTIFY_PARAMETER_2

# Write Check_MK output to a temporary file, delete depricated macros and create variable OUTPUT
env | grep NOTIFY_ | grep -v "This macro is deprecated" | sort > $OMD_ROOT/tmp/telegram.out
OUTPUT=$OMD_ROOT/tmp/telegram.out

# Read OUTPUT variable and create some more variables for every text-part you want to use afterwards
HOSTNAME=$(grep NOTIFY_HOSTNAME $OUTPUT | cut -d'=' -f2)
HOSTALIAS=$(grep NOTIFY_HOSTALIAS $OUTPUT | cut -d'=' -f2)
WHAT=$(grep NOTIFY_WHAT $OUTPUT | cut -d'=' -f2)
NOTIFICATIONTYPE=$(grep NOTIFY_NOTIFICATIONTYPE $OUTPUT | cut -d'=' -f2)
SERVICEDESC=$(grep NOTIFY_SERVICEDESC $OUTPUT | cut -d'=' -f2)
SERVICEOUTPUT=$(grep NOTIFY_SERVICEOUTPUT $OUTPUT | cut -d'=' -f2)
HOSTOUTPUT=$(grep NOTIFY_HOSTOUTPUT $OUTPUT | cut -d'=' -f2)
PREVIOUSHOSTHARDSHORTSTATE=$(grep NOTIFY_PREVIOUSHOSTHARDSHORTSTATE $OUTPUT | cut -d'=' -f2)
HOSTSHORTSTATE=$(grep NOTIFY_HOSTSHORTSTATE $OUTPUT | cut -d'=' -f2)
PREVIOUSSERVICEHARDSHORTSTATE=$(grep NOTIFY_PREVIOUSSERVICEHARDSHORTSTATE $OUTPUT | cut -d'=' -f2)
SERVICESHORTSTATE=$(grep NOTIFY_SERVICESHORTSTATE $OUTPUT | cut -d'=' -f2)
SHORTDATETIME=$(grep NOTIFY_SHORTDATETIME $OUTPUT | cut -d'=' -f2)
HOST_ADDRESS_4=$(grep NOTIFY_HOST_ADDRESS_4 $OUTPUT | cut -d'=' -f2)
HOST_ADDRESS_6=$(grep NOTIFY_HOST_ADDRESS_6 $OUTPUT | cut -d'=' -f2)

# Create a MESSAGE variable to send to your Telegram bot
MESSAGE="$HOSTNAME ($HOSTALIAS)%0A"
MESSAGE+="$WHAT $NOTIFICATIONTYPE%0A%0A"
if [[ $WHAT == "SERVICE" ]]; then
        MESSAGE+="$SERVICEDESC%0A"
        MESSAGE+="State changed from $PREVIOUSSERVICEHARDSHORTSTATE to $SERVICESHORTSTATE%0A"
        MESSAGE+="$SERVICEOUTPUT%0A"
else
        MESSAGE+="State changed from $PREVIOUSHOSTHARDSHORTSTATE to $HOSTSHORTSTATE%0A"
        MESSAGE+="$HOSTOUTPUT%0A"
fi
MESSAGE+="%0AIPv4: $HOST_ADDRESS_4 %0AIPv6: $HOST_ADDRESS_6%0A"
MESSAGE+="$SHORTDATETIME"

# Send message to Telegram bot
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" -d chat_id=$CHAT_ID -d text="$MESSAGE" >> /dev/null

# End of script
exit 0
