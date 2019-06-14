#В задании используются виртуальные машины созданные в предыдущих модулях.
#1.	При помощи WMIперезагрузить все виртуальные машины.
Invoke-Command -ScriptBlock{Restart-Computer -Force} -ComputerName vm1, vm2, vm3 -Credential Administrator
#2.	При помощи WMI просмотреть список запущенных служб на удаленном компьютере. 
Invoke-Command -ScriptBlock { Get-Service | Where-Object {$_.Status -eq "Running" }} -ComputerName vm3 -Credential Administrator 
#3.	Настроить PowerShellRemoting, для управления всеми виртуальными машинами с хостовой.
Enable-PSRemoting
Set-Item WSMan:\localhost\Client\TrustedHosts -Value vm1, vm2, vm3
#4.	Для одной из виртуальных машин установить для прослушивания порт 42658. Проверить работоспособность PS Remoting.
Invoke-Command -ScriptBlock {Set-Item WSMan:\localhost\Listener\Listener*\Port -Value 42658 -Force} -ComputerName vm3 -Credential Administrator
#5.	Создать конфигурацию сессии с целью ограничения использования всех команд, кроме просмотра содержимого дисков.
$cred=Get-Credential vm3\administrator
Register-PSSessionConfiguration -Name dir -Path .\dir.pssc -RunAsCredential $cred -ShowSecurityDescriptorUI