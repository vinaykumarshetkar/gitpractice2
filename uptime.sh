az vm list -d \
  --query "[?powerState=='VM running'].[name,resourceGroup]" \
  -o tsv |
while read vm rg
do
  echo "VM: $vm"

  az vm run-command invoke \
    -g "$rg" \
    -n "$vm" \
    --command-id RunShellScript \
    --scripts "uptime -p" \
    --query "value[0].message" \
    -o tsv

  echo "----------------"
done