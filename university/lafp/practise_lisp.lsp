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

 f:
 если первый эл-т nil
  возвращаем nil
  если остаток от деления первого эл-та на 2 равен 0
    возвращаем f(список без первого эл-та)
    возвращаем конкатенацию первый эл-т списка на f(остаток списка)
КР1:
(defun dev (s) (if (equal s nil) nil (
  if (equal (mod (car s) 2) 0) (dev (cdr s)) (cons (car s) (dev (cdr s))))))
