;*************
;* TEMPLATES *
;*************

(deftemplate MAIN::bigram
   (slot tags)
   (slot words))

(deftemplate wrong-bigram-rule
  (slot root)
  (slot wrong-rule))

(deffacts MAIN::test
  (error 0))

;*********
;* RULES *
;*********

(defrule MAIN::wrong-on-NN-VB-root-bigram
  (declare (salience 99))
  (wrong-bigram-rule (root ?root&NN|NNS|VBP|VBD)(wrong-rule ?wrong-rule))
  ?bg <- (bigram (tags ?wrong-rule) (words ?phrase))
  ?errf <- (error ?err)
  =>
  (retract ?bg ?errf)
  (assert (error (+ ?err 1)))
  (print t ?phrase " contains " ?wrong-rule " error" crlf))

(defrule MAIN::wrong-on-RB-JJ-root-bigram
  (declare (salience 88))
  (wrong-bigram-rule (root ?root&RB|JJS|JJR|JJ)(wrong-rule ?wrong-rule))
  ?bg <- (bigram (tags ?wrong-rule) (words ?phrase))
  ?errf <- (error ?err)
  =>
  (retract ?bg ?errf)
  (assert (error (+ ?err 1)))
  (print t ?phrase " contains " ?wrong-rule " error" crlf crlf))

;;******************
;;* POSTPROCESSING *
;;******************
(defrule MAIN::no-mistake
  ?ferr <- (error 0)
  =>
  (retract ?ferr)
  (print t "No mistakes in the sentence" crlf crlf))

(defrule MAIN::mistakes-found
  ?ferr <- (error ?err)
  (test (> ?err 0))
  =>
  (retract ?ferr)
  (print t ?err " mistake(s) in the sentence" crlf crlf))
