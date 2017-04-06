;*************
;* TEMPLATES *
;*************

(deftemplate MAIN::bigram
   (slot tags)
   (slot words))

(deftemplate wrong-bigram-rule
  (slot root)
  (multislot wrong-rule))

(deffacts MAIN::test
  (error 0))

(deffunction MAIN::add-rules (?file)
   (open ?file r)
   (bind ?n-gram (readinput r))
   (bind ?num-of-root (readinput r))
   (bind ?num-of-rules 0)
   (switch ?n-gram
   (case 2 then
    (print t "creating incorrect bigram rules" crlf)
    (loop-for-count (?root-count 1 ?num-of-root)
      (bind ?root (readinput r))
      (bind ?num-of-root-rule (readinput r))
      (loop-for-count (?count 1 ?num-of-root-rule)
        (bind ?num-of-rules (+ ?num-of-rules 1))
        (assert (wrong-bigram-rule (root ?root)(wrong-rule (readinput r)))))))
    (case 3 then
      (print t "creating incorrect trigram rules" crlf)))
   (close)
   (print t ?num-of-rules " rules created." crlf))

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
  (print t ?phrase " contains " ?wrong-rule " error" crlf))

;;******************
;;* POSTPROCESSING *
;;******************
(defrule MAIN::no-mistake
  ?ferr <- (error 0)
  =>
  (retract ?ferr)
  (print t "No mistakes in the sentence" crlf))

(defrule MAIN::mistakes-found
  ?ferr <- (error ?err)
  (test (> ?err 0))
  =>
  (retract ?ferr)
  (print t ?err " mistake(s) in the sentence" crlf))
