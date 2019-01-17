#!/bin/bash

#Declaração de váriavel

metric="storage_percent" 
#Métricas Disponíveis: cpu_percent, memory_percent, io_consumption_percent, storage_percent, storage_used, storage_limit, serverlog_storage_percent, serverlog_storage_usage, serverlog_storage_limit, active_connections, connections_failed, seconds_behind_master, backup_storage_used, network_bytes_egress, network_bytes_ingress

SUBSCRIPTIONID=$1
RESOURCEGROUP=$2
PROVIDER=$3
SERVERNAME=$4
ServiceprincipalID= #Your Service Principal Application ID
ServiceprincipalSecret= #Your generated KEY Secret
TenantID= #Your account tenant id 

aggregation="Average" #Tipos disponíveis: Total (Sum), Average, Minimun, Maximum, Count

#Execução da Azure Cli para obtenção de métrica

az login --service-principal -u $ServiceprincipalID -p $ServiceprincipalSecret --tenant $TenantID > /dev/null

az monitor metrics list --resource /subscriptions/$SUBSCRIPTIONID/resourceGroups/$RESOURCEGROUP/providers/$PROVIDER/servers/$SERVERNAME --metric $metric --aggregation $aggregation --interval 5m | tail -n 16 | cut -d "," -f 1 | cut -d ':' -f 2 | cut -d ' ' -f 2 | head -n 1
