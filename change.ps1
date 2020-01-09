
$vms = Get-VM | Get-NetworkAdapter | Select @{N='VM';E={$_.Parent.Name}},@{N='AdapterName';E={$_.Name}},@{N='Type';E={$_.Type}} | Where-Object{$_.Type -eq "e1000"}
foreach $vm in $vms{
	$vm | shutdown-vmguest -confirm:$false
	$vm | Get-NetworkAdapter | set-networkadapter -type vmxnet3 -confirm:$false
	$vm | start-vm -confirm:$false
}
