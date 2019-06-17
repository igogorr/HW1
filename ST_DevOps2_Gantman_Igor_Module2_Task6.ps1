#Задание 6
#1.	Для каждого пункта написать и выполнить соответсвующий скрипт автоматизации администрирования:
#1.1.	Вывести все IPадреса вашего компьютера (всех сетевых интерфейсов)
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE | Select-Object -ExpandProperty IPAddress
#1.2.	Получить mac-адреса всех сетевых устройств вашего компьютера и удалённо.
Get-WmiObject -Class Win32_NetworkAdapter  -ComputerName  localhost, VM1, VM2, VM3 | 
Select-Object  -Property  Name, MACAddress
#1.3.	На всех виртуальных компьютерах настроить (удалённо) получение адресов с DHСP.
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=true -ComputerNameVM1, VM2, VM3 |
ForEach-Object -Process {$_.InvokeMethod("EnableDHCP", $null)}
#1.4.	Расшарить папку на компьютере
net share taskpshare=c:\temp\share /users:4 /remark:"task share"
#1.5.	Удалить шару из п.1.4
net share c:\temp\share /delete
#1.6.	Скрипт входными параметрами которого являются Маска подсети и два ip-адреса.
#Результат  – сообщение (ответ) в одной ли подсети эти адреса.

#2.	Работа с Hyper-V
#2.1.	Получить список коммандлетов работы с Hyper-V (ModuleHyper-V)
Get-Command -ModuleHyper-V
#2.2.	Получить список виртуальных машин 
Get-VM
#Name State CPUUsage(%) MemoryAssigned(M) Uptime   Status             Version
#---- ----- ----------- ----------------- ------   ------             -------
#VM1  Off   0           0                 00:00:00 Operating normally 9.0
#VM2  Off   0           0                 00:00:00 Operating normally 9.0
#VM3  Off   0           0                 00:00:00 Operating normally 9.0
#2.3.	Получить состояние имеющихся виртуальных машин
Get-VM | select name, State
#2.4.	Выключить виртуальную машину
Stop-VM VM1
#2.5.	Создать новую виртуальную машину
New-VM -Name "VM4" -MemoryStartupBytes 1GB -NewVHDPath E:\VM4\base.vhdx -NewVHDSizeBytes 60GB  -SwitchName gantman_private
#Name State CPUUsage(%) MemoryAssigned(M) Uptime   Status             Version
#---- ----- ----------- ----------------- ------   ------             -------
#VM4  Off   0           0                 00:00:00 Operating normally 9.0
#2.6.	Создать динамический жесткий диск
New-VHD -Path E:\VM4\DynamicDefault.vhdx -SizeBytes 10GB
<#
omputerName            : PC
Path                    : E:\VM4\DynamicDefault.vhdx
VhdFormat               : VHDX
VhdType                 : Dynamic
FileSize                : 4194304
Size                    : 10737418240
MinimumSize             : 
LogicalSectorSize       : 512
PhysicalSectorSize      : 4096
BlockSize               : 33554432
ParentPath              :
DiskIdentifier          : ADC8583E-AEAF-4364-B5B6-C41F033D6648
FragmentationPercentage : 0
Alignment               : 1
Attached                : False
DiskNumber              :
IsPMEMCompatible        : False
AddressAbstractionType  : None
Number                  :
#>
#2.7.	Удалитьсозданную виртуальную машину
Remove-VM VM4
