(set 'list '(1 2 3 4 5 6 7)) ; задание списка

(if (= (mod 4 2) 0) 'true 'false) ; проверка на четность

(defun fact (n) (if (= n 0) 1 (* n (fact (- n 1))))) ; вычисление факториала числа
(defun gcd (m n) (if (= n 0) m (gcd n (mod m n)))) ; нахождение наибольшего общего делителя двух целых чисел
(defun pow (m n) (if (= n 0) 1 (* m (pow m (- n 1))))) ; возведение m в степень n
(defun count (s) (if (eq s nil) 0 (+ 1 (count (cdr s)))))
(defun sum (s) (if (eq s nil) 0 (+ (car s) (sum (cdr s)))))
(defun max1 (x) (IF (equal x nil) 0 (max (car x) (max1 (cdr x)))))
(DEFUN LASTM (X) (IF (EQUAL (CDR X) NIL) X (LASTM (CDR X))))
(defun dell (s) (if (equal (cdr s) nil) nil (cons (car s) (dell (cdr s)))))
(defun lastitem (s) (if (equal (cdr s) nil) (car s) (lastitem (cdr s))))
(defun append (s r) (cons (car s) r))
(defun inverse (s) (if (equal s nil) nil (cons (lastitem s)) (inverse (dell s))))
(cons 1 '(2 3)) = (1 2 3)

(defun reverser (l)
((if (eq l nil) nil
     (append (reverser (cdr l) (car l))))))

(reverser '(a (b c d) e))

(backtrackable)
Линейный список: список, элементы которого - атомы.
Линейный: (a b c);
Структурный: ((a b) c);
; cond
Задача линеаризации дерева:
Снести все атомарные элементы на один уровень. Любая древовидная структура может быть представлена списком
Из ( (a b) c (e f)) получить (a b c e f)
Блок схема: ( defun lin (s) )
If (s=nil)+ nil
If (atom(car(s))) + cons(car(s)),lin(cdr(s)) - append(lin(car(s)), lin(cdr(s))

Lin(s)=append(lin('(a b)),lin('(c d)))=append('(a b), (c d))= (a b c d)

Lin ('(c d)) = cons('c,lin((d))
Lin((d))=cons (d, lin(nil))=cons(d,nil)
Lun(nil)=nik
Lin('(a b))=cons('a,lin('(b))=(a b)
Lin('(b))=cons('b, lin(nil))=(b)
Lin(nil)=nil

Функции обработки списков/
1) ветвление
(Cond (условие, действие) (условие, действие) (..,..))
Пример: (cond (e q x y) 'ok (t 'fail))
(If b p q) можно изобразить оператором cond((b p) (t q))
2)присваивания
(Setq ( var) (expr))
(Set ( (expr) (expr))
((setq x '(a b)))
(SETQ X' (y a))
(set (car x) 5)

(defun flat (lst)
  (cond ((null lst) nil)
        ((atom (car lst)) (cons (car lst) (flat (cdr lst))))
        (t (append (flat (car lst)) (flat (cdr lst))))))

(flat '(1 2 (((3 4 (5)))) 6))

(defun reverser (l)
((if (eq l nil) nil
     (append (reverser (cdr l) (car l))))))

(defun reverser (l) (reverse (flat l)))

(defun reverser (l)
  (if (null l) nil
    (append (reverser (cdr l))
      (list (if (listp (car l)) (reverser (car l)) (car l)))
    )
  )
)

(defun reverser2 (l)
  (if (null l) nill
    (if (atom (car l)) (append (reverser2 (cdr l) (car l) ))
      (reverser2 (car l))
    )
  )
)



;;; сумма-произведение списка
(defun sumlist (x) (cond ((null x) 0)
                         (t (+ (car x) (sumlist (cdr x))))))
(sumlist '(2 3 4 5))

(defun multilist (x) (cond ((null x) 1)
                         (t (* (car x) (multilist (cdr x))))))
(multilist '(2 3 4 5))

(defun sell1(x s)
(case x
  ((+) (sumlist s))
  ((*) (multilist s))
))



(defun calc(s v)
(if (equal s '+) sumlist(v))
)

(calc '+ '(2 3))

(defun numelem (x)
(
  (setq i 0)
  (do
    ( (lst x (cdr lst)))
    ( (equal (cdr lst) nil) i)
    (+ i 1)
)))

(setq sum 0)

(do
( ( i 1 (+ i 1)))
( (> i 5) sum)
(setq sum (+ sum i))
)

(numelem '(2 3 4))

(defun numelem (x)
(
  (setq i 0)

))

(numelem '(2 3))

(defun gapply(s v)
(
  (do
  ((i 0 (+ i 1)))
  (())
  ()))
)

(sell1 '* '(2 3))
(sell1 '+ '(1 2 3 4 5))
;;;

(reverser '(a (b c d) e))
(reverser2 '(a (b c d) e))

 f:
 если первый эл-т nil
  возвращаем nil
  если остаток от деления первого эл-та на 2 равен 0
    возвращаем f(список без первого эл-та)
    возвращаем конкатенацию первый эл-т списка на f(остаток списка)
КР1:
(defun dev (s) (if (equal s nil) nil (
  if (equal (mod (car s) 2) 0) (dev (cdr s)) (cons (car s) (dev (cdr s))))))

  подсчитать количество атомов
  подсчитать сумму всех чисел атомов
  подсчитать числовые атомы

к\р по структурным спискам в след ср
