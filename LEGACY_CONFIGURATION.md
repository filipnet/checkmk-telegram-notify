### CONFIGRURATION CHECK_MK VERSION 1.6.0

Now you can create your own alarm rules in Check_MK.

```WATO → Notifications → New Rule → Notification Method → Push Notification (using Telegram)```

<!-- TOC -->

- [CONFIGRURATION CHECK_MK VERSION 1.6.0](#configruration-check_mk-version-160)
- [ACTIVATE CHANGES](#activate-changes)

<!-- /TOC -->t you have to press "1 Change" and "Activate affected"

<img src="images/activate_affected.png" alt="Activate changes and commit" width="100"/>

To ensure that the parameters are also transferred in the event of an alert, it is strongly recommended that the Check_MK instance is restarted.
```
su - mysite
omd stop
omd start
```