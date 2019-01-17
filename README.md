# Azure-Zabbix-Resources
To Monitor Zabbix resources using this scripts you need to put in your Enviroment you need to copy those.

    1- Copy the Repository
    2- Set the Variables the way you need/want
    3- Put the Scripts in "ExternalScripts" Zabbix directory.
    4- in Zabbix import the Template that is in the repository.
    5- Create a host with the name of the Server/instance you using in zabbix.
    6- in Host Settings put Macros with names in this order: 
        {$PROVIDER}
        {$RESOURCEGROUP}
        {$SERVERNAME}
        {$SUBSCRIPTIONID}
    7-Pass the Variables in Macro Values, Save your host and you're good to go!
