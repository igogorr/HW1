#Задание 2

#1. Просмотреть содержимое ветви реeстра HKCU
CD HKCU:
ls
#2. Создать, переименовать, удалить каталог на локальном диске
New-Item-path d:\epam -ItemType Directory -name task2 #создать
Rename-Item-path D:\epam\task2 -NewName task02 #переименовать
Remove-Item-path D:\epam\task02 #удалить
#3. Создать папку C:\M2T2_ФАМИЛИЯ. Создать диск ассоциированный с папкой C:\M2T2_ФАМИЛИЯ.
New-Item-path C:\ -ItemType Directory -name M2T2_GANTMAN # Создать папку
New-PSDrive-Name B -PSProvider FileSystem -Root "C:\M2T2_GANTMAN"#ассоциация
#4. Сохранить в текстовый файл на созданном диске список запущенных(!) служб. Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
Get-Service|Where-Object Status -Like running |out-file-FilePath C:\M2T2_GANTMAN\services.txt
Get-Service|Where-Object Status -Like running |out-file-FilePath C:\M2T2_GANTMAN\services.txt |Out-Default
Get-Content-Path C:\M2T2_GANTMAN\services.txt
#5. Просуммировать все числовые значения переменных текущего сеанса.
[int]$sum = 0
foreach ($i in (Get-Variable | Select-Object Value)){if ($i.Value -is [int]){$sum += $i.Value}}
Write-Host("Sum = $sum")
#6. Вывести список из 6 процессов занимающих дольше всего процессор.
Get-Process|where {$_.CPU-gt100} |Sort-Object CPU | select -first 6| select CPU, VM, Name 
#7. Вывести список названий и занятую виртуальную память (в Mb) каждого процесса, разделённые знаком тире,
#при этом если процесс занимает более 100Mb – выводить информацию красным цветом, иначе зелёным.
Get-Process|ForEach-Object {if($_.VM/1Mb-gt100) {Write-Host-ForegroundColor red $_.name, ("{0:N2}"-f $($_.vm/1Mb)) `
-Separator "-" } else {write-host-ForegroundColor green $_.Name, ("{0:N2}"-f $($_.VM/1Mb))-Separator "-"}}

#8. Подсчитать размер занимаемый файлами в папке C:\windows (и во всех подпапках) за исключением файлов *.tmp
Get-ChildItem C:\Windows\*-recurse -Exclude *.tmp| measure -Property Length -Sum;
#9. Сохранить в CSV-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
Get-Item HKLM:\SOFTWARE\Microsoft\*|Export-Csv-path C:\M2T2_GANTMAN\reg.CSV
#10.    Сохранить в XML -файле историческую информацию о командах выполнявшихся в текущем сеансе работы PS.
get-history|Export-Clixml-path C:\M2T2_GANTMAN\command.XML
#11.    Загрузить данные из полученного в п.10 xml-файла и вывести в виде списка информацию о каждой записи, в виде 5 любых (выбранных Вами) свойств.
Import-Clixml C:\M2T2_GANTMAN\reg.XML |Select-Object Id, CommandLine, ExecutionStatus, StartExecutionTime, EndExecutionTime
#12.    Удалить созданный диск и папку С:\M2T2_ФАМИЛИЯ
Remove-Item C:\M2T2_GANTMAN
