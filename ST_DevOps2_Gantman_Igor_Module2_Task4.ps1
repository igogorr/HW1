# Задание 4

#1.	Вывести список всех классов WMI на локальном компьютере. 
Get-WmiObject -List
#2.	Получить список всех пространств имён классов WMI. 
Get-WmiObject -Class __NAMESPACE | select Name
#3.	Получить список классов работы с принтером.
Get-WmiObject  *print* -list
#4.	Вывести информацию об операционной системе, не менее 10 полей.
Get-wmiobject Win32_OperatingSystem |select caption, BootDevice, Description, CurrentTimeZone, CSName, InstallDate, Locale,  Manufacturer, NumberOfProcesses, OSLanguage
#5.	Получить информацию о BIOS.
Get-WmiObject -Class win32_Bios
#6.	Вывести свободное место на локальных дисках. На каждом и сумму.
Get-WmiObject -class  Win32_LogicalDisk |select freespace, Name
#7.	Написать сценарий, выводящий суммарное время пингования компьютера (например 10.0.0.1) в сети.
[CmdletBinding()]
Param
(
 [parameter (Mandatory=$true,HelpMessage="Enter IP ")]
 [string]$Ip
)

$Sum=0
for ([int]$i=0; $i-lt4; $i++)
{
$Ping=Get-WmiObject -Query "select * from win32_pingstatus where Address='$Ip'"
Write-Output ("ip $Ip "+"response "+$Ping.ResponseTime)
$Sum+=$Ping.ResponseTime
}
Write-Output("Total time of response to $Ip = $Sum ms")
#8.	Создать файл-сценарий вывода списка установленных программных продуктов в виде таблицы с полями Имя и Версия.
Get-WmiObject -class Win32_Product | select Name, version | Format-Table
#9.	Выводить сообщение при каждом запуске приложения MS Word.
Register-WMIEvent -Query "SELECT * FROM __InstanceCreationEvent WITHIN 5 WHERE TargetInstance
 ISA 'Win32_Process' AND TargetInstance.
Name = 'winword.exe'" -sourceIdentifier 'MSWordStarted' -action {Write-Host 'WORD is running'
