# Урок 5
# Программирование bash


# Разбор ДЗ

# 1. Написать регулярное выражение, которое проверяет валидный IP-адрес. 
# Например, 192.168.1.1 подойдет, а 256.300.1.1 — нет.

1. ^(1?[0-9]{1,2}\.|2[0-4][0-5]\.|25[0-5]\.){3}(1?[0-9]{1,2}|2[0-4][0-5]|25[0-5]){1}$

# Real
2. ^(25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[0-9]{2}|[0-9])(\.(25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[0-9]{2}|[0-9])){3}$

# 2. Написать регулярное выражение, которое проверяет, является ли указанный 
# файлом нужного типа (на выбор .com,.exe или .jpg,.png,.gif и т.д.). 
# Написать регулярное выражение для проверки, ведет ли ссылка URL на некоторый файл,
# и это действительно ссылка на картинку (например, http://site.com/folder/1.png), 
# а не на любой файл.

1. ^https?:\/\/(www\.)?\w{1,63}\.[a-zA-Z]{1,63}\/?(\S*\/){0,100}(\w)*\.png$|\w*\.jpg$|\w*\.gif$

2. .*\.(jpg|gif|png)$
^(https?)\:\/\/[-a-z0-9]*\.[a-z]+\/[0-9a-z-\/]+\.(jpg|png|gif|jpeg)$

# 3. *Написать регулярное выражение, которое проверяет, является выведенное
# значение «белым» IP-адресом (5.255.255.5 подойдет, а 172.16.0.1 — нет).

1. (^10\.(1?[0-9]{1,2}\.|2[0-4][0-5]\.|25[0-5]\.){2}
   (1?[0-9]{1,2}|2[0-4][0-5]|25[0-5]){1}$)|
   (^172\.(1[6-9]\.|2[0-9]\.|3[0-1]\.)
   (1?[0-9]{1,2}\.|2[0-4][0-5]\.|25[0-5]\.){1}
   (1?[0-9]{1,2}|2[0-4][0-5]|25[0-5]){1}$)|
   (^192\.168\.(1?[0-9]{1,2}\.|2[0-4][0-5]\.|25[0-5]\.){1}
   (1?[0-9]{1,2}|2[0-4][0-5]|25[0-5]){1}$)|
   (^100\.(6[4-9]\.|[7-9][0-9]\.|1[0-1][0-9]\.|12[0-7]\.)
   (1?[0-9]{1,2}\.|2[0-4][0-5]\.|25[0-5]\.){1}(1?[0-9]{1,2}|2[0-4][0-5]|25[0-5]){1}$
   
   grep -P -v

# real
(\d+)(?<!127)(?<!10)\.(\d+)(?<!192\.168)(?<!172\.(1[6-9]|2\d|3[0-1]))\.(\d+)\.(\d+)
    
2. ^(?!127|10|192\.168|172\.1[6-9]|172\.2\d]|172\.3[0-1])(?:(25[0-5]|24\d|2[0-4]|1\d\d|\d\d|\d)\.){3}(?:25[0-5]|24\d|2[0-4]|1\d\d|\d\d|\d)$

# 4. *Написать регулярное выражение, которое проверяет, что файл в URL
# (например, https://site.ru/folder/download/test.docx) не обладает неким 
# расширением (например .exe не пройдет, или .sh — не пройдет. Выбор списка
# исключенных расширений за вами).

1. ^https?:\/\/(www\.)?\w{1,63}\.[a-zA-Z]{1,63}\/?(\S*\/){0,100}(\w*\.exe$

grep -P -v ...
echo https://site2.com/files/uploads/file1.exe | grep -P -v '^https?:\/\/(www\.)?\w{1,63}\.[a-zA-Z]{1,63}\/?(\S*\/){0,100}(\w*\.exe$)'

2. ^(?:(https?)\:\/\/)?([a-z0-9-])(?:[a-z0-9-])*\.(?:[a-z]{1,7})(\/{1}+).+\.(?!sh|exe).{1,4}$

# real
^(?:(https?)\:\/\/)?(www\.)?([a-z0-9-])(?:[a-z0-9-])*\.(?:[a-z]{1,7})(\/{1}+).+\.(?!sh|exe).{1,4}$

#!/bin/bash

# Some comment

# Простой скрипт для бэкапа
#!/bin/bash
echo Starting backup
# Переходим в директорию work, вложенную в домашнюю папку
cd ~/work
# Копируем все файлы в папку backup, также находящуюся в домашней папке
cp * ~/backup


# Работа с git в скрипте
#!/bin/bash
# Так как все файлы должны принадлежать группе www-data, а для директории
# /var/www/project установлен SGID, нужно, чтобы все файлы получали группу директории
# а не группу пользователя
umask 002
#Переходим в рабочую директорию
cd /var/www/project
# обновляем данные из репозитория 
git fetch master
git checkout
git pull
# Кстати, у geekbrains есть бесплатный  курс по git
# https://geekbrains.ru/courses/66


# Проверка существования директории
#!/bin/bash
folder=/var/www/project
ls $folder
[ -d $folder ]&&cd $folder


# Пример для работы с кодом возврата
#!/bin/bash
echo Первый аргумент $1
exit $1


# Проверка количества параметров
#!/bin/bash
[ $# == 3 ]&&echo Все верно, три параметра


# Вывод сообщения об ошибке при нехватке обязательных параметров 
#!/bin/bash
[ $# -lt 3 ]&&{
                     echo Параметров не может быть меньше трех
                     echo Формат использования
                     echo $0 arg1 arg2 arg3
                     exit 1
}


# Обработка условия для успешного и неуспешного случая 
#!/bin/bash
if [ $# -lt 3 ]
then
                     echo Параметров не может быть меньше трех
                     echo Формат использования
                     echo $0 arg1 arg2 arg3
                     exit 1
else
                     echo все хорошо, продолжаем
                     ln $1 $2
                     ln -s $1 $3   

fi


# Сканирование лога с выводом ошибок
#!/bin/bash
LOG=~/usefullscripts/monitor/logfile 
tail -0f "${LOG}" |     while read i     
do      
 case $i in     
       "err1")     
 echo "В журнале  ошибка 1" ;;
 "err2") 
 echo "В журнале  ошибка 2" ;; 
 "err3")   
 echo "В журнале  ошибка 3" ;;   
 esac  
done 


# Простейший цикл
#!/bin/bash
for i in *
do
    echo $i
done


# Пример использования арифметических операций
#!/bin/bash
#Прочитаем с клавиатуры a и b
echo "Введите a: "
read a
echo "Введите b: "
read b
let "c = a + b"  #сложение
echo "a+b= $c"
let "c = a * b"  #умножение
echo "a*b= $c"
let "c = a ** b" #возведение в степень
echo "a^b= $c"
let "c = a / b"   #деление
echo "a/b= $c"
let "c <<= 2"    #сдвигает c на 2 разряда влево
echo "c после сдвига на 2 разряда: $c"
let "c = a % b" # находит остаток от деления a на b
echo "$a / $b. остаток: $c "


# Цикл с continue
#!/bin/bash
for f in *
do
        # если копия .bak есть то будем читать следующий файл
	if [ -f ${f}.bak ]
	then
		echo "Skiping $f file..."
		continue  # переходим к следующей итерации
	fi
        # архива нет, копируем
	/bin/cp $f $f.bak
done

# Цикл с break
#!/bin/bash
for d in $*
do
#для каждого из аргументов пытаемся создать директорию
#если хотя бы раз не получилось, выходим из цикла
         mkdir $d||{
                         echo Недостаточно прав, останавливаемся
                             break
                             #а если надо выйти из программы, используем exit с кодом ошибки
                         }
done


# Создание простой функции
function errorlevel(){
echo Первый аргумент $1
return $1
}

errorlevel 1
echo $?
errorlevel 0
echo $?


# Сортировка файлов по директориям
#!/bin/bash
#Создадим структуру директорий
mkdir -p 20{00..17}/{01..12}
# В цикле обходим года
for year in {2000..2017}
do
           #в цикле обходим месяцы
           for month in {01..12}
          do
                #все файлы вида 20XXMMчто-нибудь.jpg перемещаем в 20XX/MM 
                #имя файла не меняем
               mv $year$month*jpg $year/$month
          done
done





