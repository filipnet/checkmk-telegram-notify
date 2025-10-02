# Help & Troubleshooting Guide

Having trouble getting Checkmk Telegram notifications to work? This guide will help you identify and resolve common issues.

## Quick Checklist

Before diving into advanced troubleshooting, ensure you have checked the following:

- **curl** is installed on your system.
    - Run `curl --version` to verify.
- **Bot token** and **chat ID** are correct.
    - Avoid extra spaces, line breaks, or incorrect quotes in your configuration.
- The **bot is added to the chat or group** and has permission to post.
    - Test posting with `curl` to confirm the issue is not with the Checkmk script.
- Your Checkmk host or Docker container has **internet access**.
    - Test with `curl` to the Telegram API.
    - Watch for errors like `no route to host` (firewall/proxy issues).
- The **notification script is executable**.
    - Run: `chmod +x check_mk_telegram-notify.sh`
- You have followed the steps in the [README instructions](./README.md#check_mk-configuration).

## Validate Notification (Dry-run)

To verify your Telegram bot can send messages independently of Checkmk, use this direct API call:

```bash
curl -s \
    -X POST "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/sendMessage" \
    -d "chat_id=<YOUR_CHAT_ID>" \
    -d "text=Test notification"
```

- Replace `<YOUR_BOT_TOKEN>` and `<YOUR_CHAT_ID>` with your actual values.

This test confirms:

- Bot token and chat ID are valid
- Bot has permission to post
- Host/container has internet access
- A JSON response with `"ok":true` means the message was sent

## Logfile analysis

Check the Checkmk notification log for error messages. Replace `{sitename}` with your actual site name:

```bash
tail -f /omd/sites/{sitename}/var/log/notify.log
```

## References and documentations

For more troubleshooting and examples, see:

- [Checkmk Documentation: Notifications – Chapter 11.3](https://docs.checkmk.com/latest/en/notifications.html)
- [Checkmk GitHub Repository](https://github.com/Checkmk/checkmk)
- [Checkmk Forum](https://forum.checkmk.com/)
- [Telegram Bot API Documentation](https://core.telegram.org/bots/api)
