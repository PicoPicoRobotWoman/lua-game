# lua-match 3
main.lua можно считать "точкой входа"

* в тз четко не прописано правило что из x,y ряд, а что столбец в команде "m x y d" (с пробелами), поэтому на основании примера в тз, вычислила что x - ряд, y - столбец
* в игре предусмотрена поддержка гемов специального вида, посредством 2 таблице : actionsBefore, actionsAfter
* реализована доп команда mix, которая перемешивает игровое поле
* main.lua только запускает gameController, больше не для чего он не нужен

* P.S. это буквально моя первая программа на lua
