$vms = az vm list -d --query "[?powerState=='VM running'].[name,resourceGroup]" -o tsv

foreach ($line in $vms) {

    $parts = $line -split "`t"

    $vm = $parts[0]
    $rg = $parts[1]

    Write-Host "`nVM: $vm"

    az vm run-command invoke `
      -g $rg `
      -n $vm `
      --command-id RunShellScript `
      --scripts "uptime -p" `
      --query "value[0].message" `
      -o tsv

    Write-Host "----------------"
}