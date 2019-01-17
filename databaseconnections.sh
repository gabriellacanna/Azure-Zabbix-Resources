#!/bin/bash

#Declaring Variables:
metric="active_connections" #Disponible Metrics: cpu_percent, memory_percent, io_consumption_percent, storage_percent, storage_used, storage_limit, serverlog_storage_percent, serverlog_storage_usage, serverlog_storage_limit, active_connections, connections_failed, seconds_behind_master, backup_storage_used, network_bytes_egress, network_bytes_ingress

#The Variables Above must be declared through macro in Zabbix Server when creating a host
SUBSCRIPTIONID=$1 #subscription ID of Azure Account
RESOURCEGROUP=$2 #Resource group from which
PROVIDER=$3 #The Provider, in case you could search for the provider "name" through Azure Docs. as Example we get: Microsoft.DBforMySQL
SERVERNAME=$4 #The name of server or virtual machine
ServiceprincipalID= #Your Service Principal Application ID
ServiceprincipalSecret= #Your generated KEY Secret
TenantID= #Your account tenant id 

aggregation="Average" #Disponible Types: Total (Sum), Average, Minimun, Maximum, Count

#Azure Authentication through Active Directory Service Principal.
az login --service-principal -u $ServiceprincipalID -p $ServiceprincipalSecret --tenant $TenantID > /dev/null

#Executing command to get metrics:
az monitor metrics list --resource /subscriptions/$SUBSCRIPTIONID/resourceGroups/$RESOURCEGROUP/providers/$PROVIDER/servers/$SERVERNAME --metric $metric --aggregation $aggregation --interval 5m | tail -n 16 | cut -d "," -f 1 | cut -d ':' -f 2 | cut -d ' ' -f 2 | head -n 1 

#take note: in some cases the URI above might be diferent depending on which resource you're trying to use. in most of cases this might work. if it doesn't search for the URI in Azure Docs and exchange the variables as your needs. In other Resources the Metrics are different.

#####Author: Gabriel C. Lacanna
###Title: ACTIVE DATABASE CONNECTIONS METRICS FOR AZURE RESOURCES
