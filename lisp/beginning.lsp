(defun fact (n) (if (= n 0) 1 (* n (fact (- n 1)))))

(defun gcd (m n) (if (= n 0) m (gcd n (mod m n))))

(defun pow (m n) (if (= n 0) 1 (* m (pow m (- n 1)))))

(defun count (s) (if (eq s nil) 0 (+ 1 (count (cdr s)))))

(defun sum (s) (if (eq s nil) 0 (+ (car s) (sum (cdr s)))))

(defun max1 (x) (IF (equal x nil) 0 (max (car x) (max1 (cdr x)))))

(DEFUN LASTM (X) (IF (EQUAL (CDR X) NIL) X (LASTM (CDR X))))
