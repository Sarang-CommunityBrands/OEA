
function Set-OEA {
    [cmdletbinding()]
    param(
        [string]$subscriptionId,
        [string]$resourceGroup,
		 [string]$keyvaultname,
		  [string]$synapsename,
		  [string]$sparkpoolname
		
    )

#extracting zip files
Expand-Archive -Path $Home/clouddrive/Xporter_OEA_setup.zip -DestinationPath OEA-Setup
#set parameters
$subscription_id = $subscriptionId
$resource_group = $resourceGroup
$keyVaultName = $keyvaultname
$synapseName = $synapsename
$sparkPoolName = $sparkpoolname

#execution
az account set --subscription $subscription_id



$resourceGroup = Get-AzResourceGroup -Name $resource_group


$xporterRelyingPartySecretValue = "one.assembly.education"
$xrpsecureString = ConvertTo-SecureString $xporterRelyingPartySecretValue -AsPlainText -Force
$secretRelyingPartyName = "XporterRelyingParty"
Set-AzKeyVaultSecret -VaultName $keyVaultName -Name $secretRelyingPartyName -SecretValue $xrpsecureString


$xporterRelyingPartySecretSecretValue = "EFC642410CED454FB3DC78D8339EE135"
$xrpssecureString = ConvertTo-SecureString $xporterRelyingPartySecretSecretValue -AsPlainText -Force
$secretRelyingPartySecretName = "XporterRelyingPartySecret"

Set-AzKeyVaultSecret -VaultName $keyVaultName -Name $secretRelyingPartySecretName -SecretValue $xrpssecureString




#setting up OEA python
az synapse notebook import --workspace-name $synapseName --name Xporter_py --spark-pool-name $sparkPoolName --file @$HOME/OEA-Setup/Xporter_OEA_setup/Xporter_py.ipynb
az synapse notebook import --workspace-name $synapseName --name Ingest_schoolinfo --spark-pool-name $sparkPoolName --file @$HOME/OEA-Setup/Xporter_OEA_setup/Ingest_schoolinfo.ipynb
az synapse notebook import --workspace-name $synapseName --name Ingest_students --spark-pool-name $sparkPoolName --file @$HOME/OEA-Setup/Xporter_OEA_setup/Ingest_students.ipynb
az synapse notebook import --workspace-name $synapseName --name Ingest_attendancesummary --spark-pool-name $sparkPoolName --file @$HOME/OEA-Setup/Xporter_OEA_setup/Ingest_attendancesummary.ipynb
az synapse notebook import --workspace-name $synapseName --name Ingest_groups --spark-pool-name $sparkPoolName --file @$HOME/OEA-Setup/Xporter_OEA_setup/Ingest_groups.ipynb
az synapse notebook import --workspace-name $synapseName --name Ingest_HistoricalAttendanceSummary --spark-pool-name $sparkPoolName --file @$HOME/OEA-Setup/Xporter_OEA_setup/Ingest_HistoricalAttendanceSummary.ipynb
az synapse notebook import --workspace-name $synapseName --name Ingest_Ingest_staff --spark-pool-name $sparkPoolName --file @$HOME/OEA-Setup/Xporter_OEA_setup/Ingest_staff.ipynb
az synapse notebook import --workspace-name $synapseName --name Ingest_StudentMembers --spark-pool-name $sparkPoolName --file @$HOME/OEA-Setup/Xporter_OEA_setup/Ingest_StudentMembers.ipynb

#setting up pipelines
az synapse pipeline create --workspace-name $synapseName --name import_from_xporter --file @$HOME/OEA-Setup/Xporter_OEA_setup/import_from_xporter.json
az synapse pipeline create --workspace-name $synapseName --name setup_xporter --file @$HOME/OEA-Setup/Xporter_OEA_setup/setup_xporter.json
az synapse pipeline create --workspace-name $synapseName --name OEA_data_ingestion --file @$HOME/OEA-Setup/Xporter_OEA_setup/OEA_data_ingestion.json

#cleaning the resources
rm -r OEA-Setup
rm -r Xporter_OEA_setup.zip
}

# function call
#az login
# 1. parameter subscriptionId 2nd resourceGroup 3rd keyVaultName 4th synapseName 5th spark-pool-name
Set-OEA [your-subscriptionId] [your-resource-group-name] [key-vault-name] [synapse-name] [spark-pool-name]