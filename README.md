# How to use
This is a script to auto update your Quilibrium node IF you are running it as a service.
The service name must be "ceremonyclient".
To run the node as a service you can follow [this guide](https://github.com/demipoet/demipoet.github.io), or [this other guide](https://github.com/hedging8563/quilnode/blob/main/README.md) (with auto-installer script).

After you have successfully installed everything and you are running the node as a service, you can use this script to auto-update the node. The script checks for updates once a day, but you can edit the cronjob to check more often.

STEP 1: Download the file  upgrade_q_node.sh and put it in your /root folder

STEP 2: Make script executable and set cronjob once a day, run:

    chmod +x /root/upgrade_q_node.sh && (crontab -l ; echo "0 0 * * * /root/upgrade_q_node.sh") | crontab -

STEP 3: check if cronjob is setup correctly, run:

    crontab -l

