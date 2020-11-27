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

./.build/debug/Run search
code=$?
rightCode=0
runTest $code $rightCode "Удачный поиск без ключей"

./.build/debug/Run search -k day
code=$?
rightCode=0
runTest $code $rightCode "Удачный поиск с ключом k"

./.build/debug/Run search -k chicken
code=$?
echo $code
rightCode=1
runTest $code $rightCode "Неудачный поиск с ключом k"

./.build/debug/Run search -l en
code=$?
rightCode=0
runTest $code $rightCode "Удачный поиск с ключом l"

./.build/debug/Run search -l it
code=$?
rightCode=1
runTest $code $rightCode "Неудачный поиск с ключом l"

./.build/debug/Run update Dog -k dog -l en
code=$?
rightCode=0
runTest $code $rightCode "Удачное обновление словаря"

./.build/debug/Run update Hola -k hello -l es
code=$?
rightCode=0
runTest $code $rightCode "Удачное обновление словаря"

./.build/debug/Run update Пока -k bye -l ru
code=$?
rightCode=0
runTest $code $rightCode "Удачное обновление словаря"


./.build/debug/Run delete
code=$?
rightCode=3
runTest $code $rightCode "Неудачное удаление из словаря"

./.build/debug/Run delete -k dog
code=$?
rightCode=0
runTest $code $rightCode "Удачное удаление из словаря по ключу -k"
 
./.build/debug/Run delete -l es
code=$?
rightCode=0
runTest $code $rightCode "Удачное удаление из словаря"

./.build/debug/Run delete -k bye -l ru
code=$?
rightCode=0
runTest $code $rightCode "Удачное удаление из словаря"

./.build/debug/Run -h
code=$?
rightCode=0
runTest $code $rightCode "Удачное получение помощи"

./.build/debug/Run delete -h
code=$?
rightCode=0
runTest $code $rightCode "Удачное получение помощи"

./.build/debug/Run search -h
code=$?
rightCode=0
runTest $code $rightCode "Удачное получение помощи"

./.build/debug/Run update -h
code=$?
rightCode=0
runTest $code $rightCode "Удачное получение помощи"

./.build/debug/Run search sdfsd
code=$?
rightCode=0
runTest $code $rightCode "Получение помощи при невалидных аргументах поиска"

./.build/debug/Run esfsf update
code=$?
rightCode=0
runTest $code $rightCode "Получение помощи при невалидной субкоманде, даже если верная команда указана после"

./.build/debug/Run sdfsd
code=$?
rightCode=0
runTest $code $rightCode "Получение помощи при невалидной субкоманде"

./.build/debug/Run update -k hello
code=$?
rightCode=0
runTest $code $rightCode "Получение помощи при недостатке аргументов"

./.build/debug/Run update -l ru
code=$?
rightCode=0
runTest $code $rightCode "Получение помощи при недостатке аргументов"

./.build/debug/Run search -k hello -l
code=$?
rightCode=0
runTest $code $rightCode "Получение помощи, если значение ключа не указано"

./.build/debug/Run -h lkasdj
code=$?
rightCode=0
runTest $code $rightCode "Получение помощи при неправильном использовании помощи)))))))))))))))))))"

./.build/debug/Run asdasd -h
code=$?
rightCode=0
runTest $code $rightCode "Получение помощи при неправильном использовании помощи"

./.build/debug/Run search -m
code=$?
rightCode=0
runTest $code $rightCode "Получение помощи при указании неверных ключей"

./.build/debug/Run update
code=$?
rightCode=0
runTest $code $rightCode "Получение помощи, если отсутствуют необходимые ключи"

results