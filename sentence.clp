(deftemplate MAIN::pos
   (slot tag)
   (slot word))

(deffacts MAIN::fact
   (error 0)
   (noun-verb-agreement)
   (pos (tag NN) (word dog))
   (pos (tag VB) (word run)))

(defrule MAIN::NN-VB
   (declare (salience 99))
   ?nva <- (noun-verb-agreement)
   (pos (tag NN) (word ?noun))
   (pos (tag VB) (word ?verb))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?noun " " ?verb " is not right" crlf))

(defrule MAIN::no-mistake
   (declare (salience 0))
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
