(deftemplate MAIN::pos
   (slot tag)
   (slot word))

(deftemplate MAIN::bigram
   (slot tags)
   (slot words))

(deffacts MAIN::test
   (error 0)
   (NN-JJS)
   (NN-JJS)
   (bigram (tags NN-JJS) (words "chair biggest")))

;;****************
;;* NOUN - RULES *
;;****************
(defrule MAIN::NN-JJS
   (declare (salience 99))
   ?nva <- (NN-JJS)
   (bigram (tags NN-JJS) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::NN-JJR
   (declare (salience 99))
   ?nva <- (noun-verb-agreement)
   (bigram (tags NN-JJR) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " is not right" crlf))

 (defrule MAIN::NN-JJ
    (declare (salience 99))
    ?nva <- (noun-verb-agreement)
    (bigram (tags NN-JJ) (words ?phrase))
    ?ferr <- (error ?err)
    =>
    (retract ?nva ?ferr)
    (assert (error (+ ?err 1)))
    (assert (mistake NN-VB-disagree))
    (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::NN-RBS
   (declare (salience 99))
   ?nva <- (noun-verb-agreement)
   (bigram (tags NN-RBS) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::NN-RBR
  (declare (salience 99))
  ?nva <- (noun-verb-agreement)
  (bigram (tags NN-RBR) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::NN-PRP$
   (declare (salience 99))
   ?nva <- (noun-verb-agreement)
   (bigram (tags NN-PRP$) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::NN-CD
  (declare (salience 99))
  ?nva <- (noun-verb-agreement)
  (bigram (tags NN-CD) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))


;;*****************
;;* NOUNP - RULES *
;;*****************
(defrule MAIN::NNS-JJS
   (declare (salience 99))
   ?nva <- (NN-JJS)
   (bigram (tags NNS-JJS) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::NNS-JJR
   (declare (salience 99))
   ?nva <- (noun-verb-agreement)
   (bigram (tags NNS-JJR) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " is not right" crlf))

 (defrule MAIN::NNS-JJ
    (declare (salience 99))
    ?nva <- (noun-verb-agreement)
    (bigram (tags NNS-JJ) (words ?phrase))
    ?ferr <- (error ?err)
    =>
    (retract ?nva ?ferr)
    (assert (error (+ ?err 1)))
    (assert (mistake NN-VB-disagree))
    (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::NNS-RBS
   (declare (salience 99))
   ?nva <- (noun-verb-agreement)
   (bigram (tags NNS-RBS) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::NNS-RBR
  (declare (salience 99))
  ?nva <- (noun-verb-agreement)
  (bigram (tags NNS-RBR) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::NNS-PRP$
   (declare (salience 99))
   ?nva <- (noun-verb-agreement)
   (bigram (tags NNS-PRP$) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::NNS-CD
  (declare (salience 99))
  ?nva <- (noun-verb-agreement)
  (bigram (tags NNS-CD) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

;;****************
;;* VERB - RULES *
;;****************
(defrule MAIN::VBP-JJS
   (declare (salience 99))
   ?nva <- (NN-JJS)
   (bigram (tags VBP-JJS) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::VBP-MD
   (declare (salience 99))
   ?nva <- (noun-verb-agreement)
   (bigram (tags VBP-MD) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " is not right" crlf))

 (defrule MAIN::VBP-WDT
    (declare (salience 99))
    ?nva <- (noun-verb-agreement)
    (bigram (tags VBP-WDT) (words ?phrase))
    ?ferr <- (error ?err)
    =>
    (retract ?nva ?ferr)
    (assert (error (+ ?err 1)))
    (assert (mistake NN-VB-disagree))
    (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::VBP-WP$
   (declare (salience 99))
   ?nva <- (noun-verb-agreement)
   (bigram (tags VBP-WP$) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::VBP-RBS
  (declare (salience 99))
  ?nva <- (noun-verb-agreement)
  (bigram (tags VBP-RBS) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::VBP-CD
   (declare (salience 99))
   ?nva <- (noun-verb-agreement)
   (bigram (tags VBP-CD) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::VBP-WP
  (declare (salience 99))
  ?nva <- (noun-verb-agreement)
  (bigram (tags VBP-WP) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

;;********************
;;* VERBPAST - RULES *
;;********************
(defrule MAIN::VBD-WP$
   (declare (salience 99))
   ?nva <- (NN-JJS)
   (bigram (tags VBD-WP$) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::VBD-JJS
   (declare (salience 99))
   ?nva <- (noun-verb-agreement)
   (bigram (tags VBD-JJS) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " is not right" crlf))

 (defrule MAIN::VBD-RBS
    (declare (salience 99))
    ?nva <- (noun-verb-agreement)
    (bigram (tags VBD-RBS) (words ?phrase))
    ?ferr <- (error ?err)
    =>
    (retract ?nva ?ferr)
    (assert (error (+ ?err 1)))
    (assert (mistake NN-VB-disagree))
    (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::VBD-VBZ
   (declare (salience 99))
   ?nva <- (noun-verb-agreement)
   (bigram (tags VBD-VBZ) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::VBD-WDT
  (declare (salience 99))
  ?nva <- (noun-verb-agreement)
  (bigram (tags VBD-WDT) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::VBD-VBP
   (declare (salience 99))
   ?nva <- (noun-verb-agreement)
   (bigram (tags VBD-VBP) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::VBD-WRB
  (declare (salience 99))
  ?nva <- (noun-verb-agreement)
  (bigram (tags VBD-WRB) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::VBD-MD
   (declare (salience 99))
   ?nva <- (noun-verb-agreement)
   (bigram (tags VBD-MD) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::VBD-JJR
  (declare (salience 99))
  ?nva <- (noun-verb-agreement)
  (bigram (tags VBD-JJR) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

;;******************
;;* ADVERB - RULES *
;;******************
(defrule MAIN::RB-WP$
   (declare (salience 88))
   ?nva <- (NN-JJS)
   (bigram (tags RB-WP$) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::RB-PDT
  (declare (salience 88))
  ?nva <- (NN-JJS)
  (bigram (tags RB-PDT) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::RB-WP
   (declare (salience 88))
   ?nva <- (NN-JJS)
   (bigram (tags RB-WP) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::RB-WDT
  (declare (salience 88))
  ?nva <- (NN-JJS)
  (bigram (tags RB-WDT) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::RB-PRP$
   (declare (salience 88))
   ?nva <- (NN-JJS)
   (bigram (tags RB-PRP$) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::RB-MD
  (declare (salience 88))
  ?nva <- (NN-JJS)
  (bigram (tags RB-MD) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::RB-PRP
   (declare (salience 88))
   ?nva <- (NN-JJS)
   (bigram (tags RB-PRP) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::RB-NNS
  (declare (salience 88))
  ?nva <- (NN-JJS)
  (bigram (tags RB-NNS) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::RB-NN
   (declare (salience 88))
   ?nva <- (NN-JJS)
   (bigram (tags RB-NN) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::RB-CD
  (declare (salience 88))
  ?nva <- (NN-JJS)
  (bigram (tags RB-CD) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::RB-JJS
   (declare (salience 88))
   ?nva <- (NN-JJS)
   (bigram (tags RB-JJS) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::RB-JJR
  (declare (salience 88))
  ?nva <- (NN-JJS)
  (bigram (tags RB-JJR) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

;;**********************
;;* ADJECTIVES - RULES *
;;**********************
(defrule MAIN::JJS-JJS
   (declare (salience 88))
   ?nva <- (NN-JJS)
   (bigram (tags JJS-JJS) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::JJS-JJR
  (declare (salience 88))
  ?nva <- (NN-JJS)
  (bigram (tags JJS-JJR) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::JJS-WP$
   (declare (salience 88))
   ?nva <- (NN-JJS)
   (bigram (tags JJS-WP$) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::JJS-PRP$
  (declare (salience 88))
  ?nva <- (NN-JJS)
  (bigram (tags JJS-PRP$) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::JJS-WDT
   (declare (salience 88))
   ?nva <- (NN-JJS)
   (bigram (tags JJS-WDT) (words ?phrase))
   ?ferr <- (error ?err)
   =>
   (retract ?nva ?ferr)
   (assert (error (+ ?err 1)))
   (assert (mistake NN-VB-disagree))
   (printout t ?phrase " contains NN-JJS error" crlf))

;;**********************
;;* ADJECTIVEC - RULES *
;;**********************
(defrule MAIN::JJR-WP$
  (declare (salience 88))
  ?nva <- (NN-JJS)
  (bigram (tags JJR-WP$) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::JJR-WDT
 (declare (salience 88))
 ?nva <- (NN-JJS)
 (bigram (tags JJR-WDT) (words ?phrase))
 ?ferr <- (error ?err)
 =>
 (retract ?nva ?ferr)
 (assert (error (+ ?err 1)))
 (assert (mistake NN-VB-disagree))
 (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::JJR-PRP$
  (declare (salience 88))
  ?nva <- (NN-JJS)
  (bigram (tags JJR-PRP$) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::JJR-JJR
 (declare (salience 88))
 ?nva <- (NN-JJS)
 (bigram (tags JJR-JJR) (words ?phrase))
 ?ferr <- (error ?err)
 =>
 (retract ?nva ?ferr)
 (assert (error (+ ?err 1)))
 (assert (mistake NN-VB-disagree))
 (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::JJR-JJS
  (declare (salience 88))
  ?nva <- (NN-JJS)
  (bigram (tags JJR-JJS) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

;;**********************
;;* ADJECTIVE - RULES *
;;**********************
(defrule MAIN::JJ-WP$
  (declare (salience 88))
  ?nva <- (NN-JJS)
  (bigram (tags JJ-WP$) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::JJ-WDT
 (declare (salience 88))
 ?nva <- (NN-JJS)
 (bigram (tags JJ-WDT) (words ?phrase))
 ?ferr <- (error ?err)
 =>
 (retract ?nva ?ferr)
 (assert (error (+ ?err 1)))
 (assert (mistake NN-VB-disagree))
 (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::JJ-PRP$
  (declare (salience 88))
  ?nva <- (NN-JJS)
  (bigram (tags JJ-PRP$) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::JJ-JJS
 (declare (salience 88))
 ?nva <- (NN-JJS)
 (bigram (tags JJ-JJS) (words ?phrase))
 ?ferr <- (error ?err)
 =>
 (retract ?nva ?ferr)
 (assert (error (+ ?err 1)))
 (assert (mistake NN-VB-disagree))
 (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::JJ-JJR
  (declare (salience 88))
  ?nva <- (NN-JJS)
  (bigram (tags JJ-JJR) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

(defrule MAIN::JJ-DT
  (declare (salience 88))
  ?nva <- (NN-JJS)
  (bigram (tags JJ-DT) (words ?phrase))
  ?ferr <- (error ?err)
  =>
  (retract ?nva ?ferr)
  (assert (error (+ ?err 1)))
  (assert (mistake NN-VB-disagree))
  (printout t ?phrase " contains NN-JJS error" crlf))

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
