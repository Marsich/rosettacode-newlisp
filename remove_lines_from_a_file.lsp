#!/usr/local/bin/newlisp

(context 'ABC)

(define (remove-lines-from-a-file filename start num)    
	(setf new-content "")
	(setf row-counter 0)
	(setf start-delete-row start)
	(setf end-delete-row (+ start num -1))
	(setf file-content (read-file filename))
	(setf max-rows (length (parse file-content "\n" 0)))

	(cond
		((<= start 0)
			(println "Start line must be >= 1. Value passed: " start))
		((<= num 0)
			(println "# of lines to remove must be >= 1. Value passed: " num))
		((> start max-rows)
			(println "Start line must be <= " max-rows ". Value passed: " start))
		((> end-delete-row max-rows)
			(println "Not so much lines available to be removed. Max " (- max-rows start-delete-row) ". Value passed: " num))
		(true
			(dolist (row (parse file-content "\n" 0))
				(++ row-counter)
				(if (or (< row-counter start-delete-row) (> row-counter end-delete-row))
					(setf new-content (append new-content row "\n")) 
					)
			)
			(write-file (string filename ".NEW") new-content)
		)
	)
)

(context 'MAIN)

(ABC:remove-lines-from-a-file "foobar.txt" 8 3)
(exit)