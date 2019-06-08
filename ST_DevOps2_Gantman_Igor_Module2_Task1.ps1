#                   Задание 1

#1. Получите справку о командлете справки 
Get-Help Get-Help 
#2. Пункт 1, но детальную справку, затем только примеры 
Get-Help Get-Help -Detailed
Get-Help -Examples 
#3. Получите справку о новых возможностях в PowerShell 4.0 (или выше) 
Get-Help about_Windows_PowerShell_5.0 
#4. Получите все командлеты установки значений
Get-Command -CommandType Cmdlet | Where-Object name -Like set*
#5. Получить список команд работы с файлами 
Get-Command | Where-Object  Name -Like *file*
#6. Получить список команд работы с объектами
Get-Command | Where-Object  Name -Like *object*
#7. Получите список всех псевдонимов 
Get-Alias 
#8. Создайте свой псевдоним для любого командлета 
Set-Alias GA Get-Alias 
#9. Просмотреть список методов и свойств объекта типа процесс 
Get-Process | Get-Member 
#10. Просмотреть список методов и свойств объекта типа строка 
[string]$x="12346"
$x|Get-Member
#11. Получить список запущенных процессов, данные об определённом процессе 
Get-Process 
Get-Process -Name code 
#12. Получить список всех сервисов, данные об определённом сервисе 
Get-Service 
Get-Service -Name Dhcp 
#13. Получить список обновлений системы 
Get-HotFix 
#14. Узнайте, какой язык установлен для UI Windows 
Get-UICulture 
#15. Получите текущее время и дату 
Get-Date 
#16. Сгенерируйте случайное число (любым способом) 
Get-Random 
#17. Выведите дату и время, когда был запущен процесс «explorer». Получите какой это день недели. 
(Get-Process -name explorer).StartTime 
(Get-Process -name explorer).StartTime.DayOfWeek 
#18. Откройте любой документ в MS Word (не важно как) и закройте его с помощью PowerShell
Invoke-Item "c:\temp\test.docx" 
Get-Process -Name WINWORD | Stop-Process
#19. Подсчитать значение выражения S= . N – изменяемый параметр. Каждый шаг выводить в виде строки. (Пример: На шаге 2 сумма S равна 9)
[int]$n = read-host "input N: " 
[int]$a = 0                     
for($i = 1; $i -le $n; $i++) 
{
 $a += $i  
 write-output("step $i S' sum: $a") 
}

write-output("step $i S' sum: $a")


#20. Напишите функцию для предыдущего задания. Запустите её на выполнение.
function sum ([int]$n)
{
   [int]$a=0
   for($i=1; $i -le $n; $i++)
   {
      $a += $i
      write-output("step $i S' sum: $a")
   }
 
}
sum (read-host "input N: ")
