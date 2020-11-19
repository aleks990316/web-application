#!/bin/bash
function runTest() {
    let numberOfTests++
    echo $3
    if [ $1 -eq $2 ]
    then
    let numberOfSuccessfulTests++
    echo "Тест успешно выполнен"
    else
    let numberOfFailedTests++
    echo "Тест не прошёл"
    fi
    echo " "
}

function results() {
    echo "Всего тестов: $numberOfTests"
    echo "Успешных: $numberOfSuccessfulTests"
    echo "Провальных: $numberOfFailedTests"
}
numberOfTests=0
numberOfSuccessfulTests=0
numberOfFailedTests=0

./.build/debug/web-application search
code=$?
rightCode=0
runTest $code $rightCode "Удачный поиск без ключей"

./.build/debug/web-application search -k day
code=$?
rightCode=0
runTest $code $rightCode "Удачный поиск с ключом k"

./.build/debug/web-application search -k chicken
code=$?
rightCode=1
runTest $code $rightCode "Неудачный поиск с ключом k"

./.build/debug/web-application search -l en
code=$?
rightCode=0
runTest $code $rightCode "Удачный поиск с ключом l"

./.build/debug/web-application search -l it
code=$?
rightCode=1
runTest $code $rightCode "Неудачный поиск с ключом l"

./.build/debug/web-application update Dog -k dog -l en
code=$?
rightCode=2
runTest $code $rightCode "Удачное обновление словаря"

./.build/debug/web-application update Hola -k hello -l es
code=$?
rightCode=2
runTest $code $rightCode "Удачное обновление словаря"

./.build/debug/web-application update Пока -k bye -l ru
code=$?
rightCode=2
runTest $code $rightCode "Удачное обновление словаря"


./.build/debug/web-application delete
code=$?
rightCode=3
runTest $code $rightCode "Неудачное удаление из словаря"

./.build/debug/web-application delete -k dog
code=$?
rightCode=6
runTest $code $rightCode "Удачное удаление из словаря по ключу -k"
 
./.build/debug/web-application delete -l es
code=$?
rightCode=5
runTest $code $rightCode "Удачное удаление из словаря"

./.build/debug/web-application delete -k bye -l ru
code=$?
rightCode=4
runTest $code $rightCode "Удачное удаление из словаря"

./.build/debug/web-application -h
code=$?
rightCode=7
runTest $code $rightCode "Удачное получение помощи"

./.build/debug/web-application delete -h
code=$?
rightCode=7
runTest $code $rightCode "Удачное получение помощи"

./.build/debug/web-application search -h
code=$?
rightCode=7
runTest $code $rightCode "Удачное получение помощи"

./.build/debug/web-application update -h
code=$?
rightCode=7
runTest $code $rightCode "Удачное получение помощи"

./.build/debug/web-application search sdfsd
code=$?
rightCode=7
runTest $code $rightCode "Получение помощи при невалидных аргументах поиска"

./.build/debug/web-application esfsf update
code=$?
rightCode=7
runTest $code $rightCode "Получение помощи при невалидной субкоманде, даже если верная команда указана после"

./.build/debug/web-application sdfsd
code=$?
rightCode=7
runTest $code $rightCode "Получение помощи при невалидной субкоманде"

./.build/debug/web-application update -k hello
code=$?
rightCode=7
runTest $code $rightCode "Получение помощи при недостатке аргументов"

./.build/debug/web-application update -l ru
code=$?
rightCode=7
runTest $code $rightCode "Получение помощи при недостатке аргументов"

./.build/debug/web-application search -k hello -l
code=$?
rightCode=7
runTest $code $rightCode "Получение помощи, если значение ключа не указано"

./.build/debug/web-application -h lkasdj
code=$?
rightCode=7
runTest $code $rightCode "Получение помощи при неправильном использовании помощи)))))))))))))))))))"

./.build/debug/web-application asdasd -h
code=$?
rightCode=7
runTest $code $rightCode "Получение помощи при неправильном использовании помощи"

./.build/debug/web-application search -m
code=$?
rightCode=7
runTest $code $rightCode "Получение помощи при указании неверных ключей"

./.build/debug/web-application update
code=$?
rightCode=7
runTest $code $rightCode "Получение помощи, если отсутствуют необходимые ключи"

results