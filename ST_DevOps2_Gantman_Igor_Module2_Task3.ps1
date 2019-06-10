#1.	Создайте сценарии *.ps1 для задач из labwork 2, проверьте их работоспостобность. Каждый сценарий должен иметь параметры.

#1.1.	Сохранить в текстовый файл на диске список запущенных(!) служб. 
#Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
[CmdletBinding()]
Param 
( 
    [parameter(Mandatory = $true, HelpMessage = "disk name")]
    [string]$Disk,
    
    [parameter(Mandatory = $true, HelpMessage = "direcrory")]
    [string]$Folder,

    [string]$file="Service.txt"
    
)
Get-Service|Where-Object Status -Like running | out-file -FilePath $disk":"\$folder\$file
Get-Content -Path $disk":"\$folder\$file

#1.2.	Просуммировать все числовые значения переменных среды Windows. (Параметры не нужны)
[CmdletBinding()]
Param 
(
    [parameter(Mandatory = $false)]
    [int]$sum = 0
)
foreach ($i in (Get-Variable | Select-Object Value)){if ($i.Value -is [int]){$sum += $i.Value}}
Write-Host("Sum = $sum")
#1.3.	Вывести список из 10 процессов занимающих дольше всего процессор.Результат записывать в файл.
[CmdletBinding()]
Param 
( 
    [parameter(Mandatory = $true, HelpMessage = "Enter fale name")]
    [string]$filemame,
    [string]$Path = "c:\2\$filemame.txt"
)
Get-Process|where {$_.CPU-gt 100} |Sort-Object CPU | select -first 10| select CPU, VM, Name| Out-File $Path
#1.3.1.	Организовать запуск скрипта каждые 10 минут
[CmdletBinding()]
Param
(
    [parameter(Mandatory = $false)]
    [string]$Name = "task 1.3.1",
    [string]$Repeat = "00:10:00",                                                                          
    [string]$Path = "C:\Users\Administrator\Desktop\1.3.ps1"
)
$job= New-JobTrigger -RepetitionInterval $Repeat -RepetitionDuration ([timespan]::MaxValue) `
-At (Get-Date -DisplayHint Time) -Once Register-ScheduledJob -Name $Name -FilePath $Path -Trigger $job
#1.4.	Подсчитать размер занимаемый файлами в папке (например C:\windows) за исключением файлов с заданным расширением(напрмер .tmp)
[CmdletBinding()]
Param
(   [parameter(Mandatory = $false)]
    [string]$path ="C:\windows\*" ,
    [string]$exclude = "*.tmp"
)
Get-ChildItem $path -recurse -Exclude $exclude | measure -Property Length -Sum;
#1.5.	Создать один скрипт, объединив 3 задачи:
#1.5.1.	Сохранить в CSV-файле информацию обо всех обновлениях безопасности ОС.
#1.5.2.	Сохранить в XML-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
#1.5.3.	Загрузить данные из полученного в п.1.5.1 или п.1.5.2 файла и вывести в виде списка  разным разными цветами
[CmdletBinding()]
Param
(
    [parameter (Mandatory=$true, HelpMessage="file name" )]
    [string]$CSVname ,
    [parameter (Mandatory=$true, HelpMessage="file name" )]
    [string]$XMLname ,

    [parameter(Mandatory = $false, HelpMessage="file name" )]
    [string]$pathC = "c:\temp\",
    [string]$pathX = "c:\temp\"
)  


Get-HotFix| Export-Csv -Path "$pathC\$CSVname.csv"
Get-Item HKLM:\SOFTWARE\Microsoft\* | Export-Clixml -Path $pathX\$XMLname.xml | Write-Host -ForegroundColor Red $_.name

Import-Clixml $pathX\$XMLname.xml |Select-Object | Select-Object name | Write-Host -ForegroundColor Green
Get-Content   $pathX\$CSVname.csv | Write-Host -ForegroundColor Yellow 
#2.	Работа с профилем
#2.1.	Создать профиль
#2.2.	В профиле изненить цвета в консоли PowerShell
#2.3.	Создать несколько собственный алиасов
#2.4.	Создать несколько констант
#2.5.	Изменить текущую папку
#2.6.	Вывести приветсвие
#2.7.	Проверить применение профиля
New-Item -ItemType file -Path $profile -force
notepad $profile 
<#
# Изменение внешнего вида консоли
 (Get-Host).UI.RawUI.ForegroundColor = "green"
 (Get-Host).UI.RawUI.BackgroundColor = "black"
 (Get-Host).UI.RawUI.CursorSize = 12
 (Get-Host).UI.RawUI.WindowTitle = "My Window"
 
# Установка директорию по умолчанию
 Set-Location C:\temp
 
# Новыйалиасдля Get-Help
 Set-Alias Help   Get-Help
 Set-Alias Member Get-Member
 Set-Alias Date   Get-date
 
# константа
 Set-Variable test -Option Constant -Value 100

# Добавление всех зарегистрированных оснасток и модулей
 #Get-Pssnapin-Registered| Add-Pssnapin-Passthru-ErrorActionSilentlyContinue
 Get-Module-ListAvailable| Import-Module-PassThru-ErrorActionSilentlyContinue
 
# Очиcтка экрана
 Clear-Host
 
# Приветствие себя любимого
 Write-Host "Hello, Igor"
#>
Set-ExecutionPolicy Remotesigned
#3.	Получить список всех доступных модулей
Get-Module -ListAvailable -All