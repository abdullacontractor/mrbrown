;*************
;* TEMPLATES *
;*************

(deftemplate MAIN::bigram
   (multislot tags)
   (multislot words))

(deftemplate wrong-bigram-rule
  (slot root)
  (multislot wrong-rule))

(deffacts MAIN::test
  (error 0))

;*********
;* RULES *
;*********

(defrule MAIN::wrong-on-NN-VB-root-bigram
  (declare (salience 99))
  (wrong-bigram-rule (root ?root&NN|NNS|VBP|VBD)(wrong-rule ?root ?tag2))
  ?bg <- (bigram (tags ?root ?tag2) (words ?word1 ?word2))
  ?errf <- (error ?err)
  =>
  (retract ?bg ?errf)
  (assert (error (+ ?err 1)))
  (capturerule t ?word1 ?root ?word2 ?tag2))

(defrule MAIN::wrong-on-RB-JJ-root-bigram
  (declare (salience 88))
  (wrong-bigram-rule (root ?root&RB|JJS|JJR|JJ)(wrong-rule ?root ?tag2))
  ?bg <- (bigram (tags ?root ?tag2) (words ?word1 ?word2))
  ?errf <- (error ?err)
  =>
  (retract ?bg ?errf)
  (assert (error (+ ?err 1)))
  (capturerule t ?word1 ?root ?word2 ?tag2))

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
