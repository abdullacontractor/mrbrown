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
  (error 0)
  (bigram (tags NN-JJS) (words "chair biggest"))
  (bigram (tags JJS-JJS) (words "smallest biggest"))
  (bigram (tags JJR-JJS) (words "taller biggest"))
  (bigram (tags NNS-JJR) (words "chairs bigger"))
  (bigram (tags VBD-JJS) (words "walked fastest")))


(deffunction MAIN::add-rules (?file)
   (open ?file r)
   (bind ?n-gram (read r))
   (bind ?num-of-root (read r))
   (bind ?num-of-rules 0)
   (switch ?n-gram
   (case 2 then
   (loop-for-count (?root-count 1 ?num-of-root)
      (bind ?root (read r))
      (bind ?num-of-root-rule (read r))
      (loop-for-count (?count 1 ?num-of-root-rule)
        (bind ?num-of-rules (+ ?num-of-rules 1))
        (assert (wrong-bigram-rule (root ?root)(wrong-rule (read r))))))
        ))
   (close)
   (printout t ?num-of-rules " rules created." crlf))

(defrule MAIN::wrong-on-NN-VB-root-bigram
  (declare (salience 99))
  (wrong-bigram-rule (root ?root&NN|NNS|VBP|VBD)(wrong-rule ?wrong-rule))
  ?bg <- (bigram (tags ?wrong-rule) (words ?phrase))
  ?errf <- (error ?err)
  =>
  (retract ?bg ?errf)
  (assert (error (+ ?err 1)))
  (printout t ?phrase " contains " ?wrong-rule " error" crlf))

(defrule MAIN::wrong-on-RB-JJ-root-bigram
  (declare (salience 88))
  (wrong-bigram-rule (root ?root&RB|JJS|JJR|JJ)(wrong-rule ?wrong-rule))
  ?bg <- (bigram (tags ?wrong-rule) (words ?phrase))
  ?errf <- (error ?err)
  =>
  (retract ?bg ?errf)
  (assert (error (+ ?err 1)))
  (printout t ?phrase " contains " ?wrong-rule " error" crlf))

;;******************
;;* POSTPROCESSING *
;;******************
(defrule MAIN::no-mistake
  ?ferr <- (error 0)
  =>
  (retract ?ferr)
  (printout t "No mistakes in the sentence" crlf))

(defrule MAIN::mistakes-found
  ?ferr <- (error ?err)
  (test (> ?err 0))
  =>
  (retract ?ferr)
  (printout t ?err " mistake(s) in the sentence" crlf))
