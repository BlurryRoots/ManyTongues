; define the value lookup table
(define lookup-table
	(list
		'("a" 0) '("e" 0) '("i" 0) '("o" 0) '("u" 0) '("y" 0) '("h" 0) '("w" 0)
		'("b" 1) '("f" 1) '("p" 1) '("v" 1)
		'("c" 2) '("g" 2) '("j" 2) '("k" 2) '("q" 2) '("s" 2) '("x" 2) '("z" 2)
		'("d" 3) '("t" 3)
		'("l" 4)
		'("m" 5) '("n" 5)
		'("r" 6)))

; method to find the corresponding value for a character
(define (lookup value)
	; define a recursive helper function
	(letrec ((lookup-helper (lambda (list)
				; if there are no more values left break with -1
				(if (= 0 (length list))
					-1
					; else check if the given the given value is equal
					; to the front value of head
					(let ((head (car list)) (rest (cdr list)))
						(define symbol (car head))
						(if (string=? value symbol)
							; if so return the value corresping to head
							(car (cdr head))
							; if not keep search in the remainig values
							(lookup-helper rest)))))))
		; call the recursive helper
		(lookup-helper lookup-table)))

; gets the character at position n as a string
(define (string-at str n)
	(substring str n (+ n 1)))

; gets the first character of given string as string
(define (string-head str)
	(string-at str 0))

; returns the rest of the string beginning at position n
(define (string-tail str n)
	(substring str n (string-length str)))

; executes callback for each character in given string
(define (foreach-char str callback)
	(let ((c (string-head str)) (rest (string-tail str 1)))
		(callback c)
		(if (< 0 (string-length rest))
			(foreach-char rest callback))
			#t))

; iterates the string and calles either eq-cb if there are at least 2
; characters left from the current position to the end or last-cb if
; the position reaches the end of the string
(define (foreach-neighbour str eq-cb last-cb)
	(if (= 1 (string-length str))
		(last-cb (string-at str 0))
		(begin
			(eq-cb (string-at str 0) (string-at str 1))
			(foreach-neighbour (string-tail str 1) eq-cb last-cb))))

; returns the uppercase version of the given string
(define (string-upcase str)
	(letrec ((upstr ""))
		(foreach-char
			str
			(lambda (c)
				(set! upc (char-upcase (string-ref c 0)))
				(set! upstr (string-append upstr (string upc)))))
		upstr))

; returns the lower case version of given string
(define (string-downcase str)
	(letrec ((downstr ""))
		(foreach-char
			str
			(lambda (c)
				(set! downc (char-downcase (string-ref c 0)))
				(set! downstr (string-append downstr (string downc)))))
		downstr))

; returns a string of "0"s with length n
(define (fill-zeros n)
	(letrec ((fill-zeros-helper (lambda (n accu)
				(if (= 0 n)
					accu
					(fill-zeros-helper (- n 1) (string-append accu "0"))))))
		(fill-zeros-helper n "")))

; returns a character followed by 3 numbers representing a phonetic hash
; of given name
(define (zoundex name)
	; split head and tail of the name and convert them to lower case
	; so that it is possible to look up the corresponding values
	(let ((head (string-downcase (string-head name)))
			(rest (string-downcase (string-tail name 1)))
			(code "")
			(reduced-code ""))
		; look up each value of the rest of the name and store them in code
		(foreach-char
			rest
			(lambda (c)
				(set! code (string-append code (number->string (lookup c))))))

		; check if there are adjacent values which are equal
		; if so omit them
		(foreach-neighbour
			code
			(lambda (a b)
				(if (not (string=? a b))
					(set! reduced-code (string-append reduced-code a))))
			(lambda (a)
				(set! reduced-code (string-append reduced-code a))))

		; remove all zeros
		(set! code "")
		(foreach-char
			reduced-code
			(lambda (c)
				(if (not (string=? "0" c))
					(set! code (string-append code c)))))

		; fill the code if its length is below 4
		; and trim it if the length exceeds 4
		(set! code (string-append (string-upcase head) code))
		(set! l (string-length code))
		(if (<= 4 l)
			(substring code 0 4)
			(string-append code (fill-zeros (- l 4))))
		))

; ---------------- Testing -----------------
(define (assert-equal a b predicate)
	(if (not (predicate a b))
		(begin
			(error (string-append a " not equal " b)))))

(define (assert-equal-string a b)
	(assert-equal a b string=?))

(assert-equal-string (zoundex "Lovecraft") "L126")
(assert-equal-string (zoundex "loAfKraft") "L126")
(assert-equal-string (zoundex "farnswort") "F652")
