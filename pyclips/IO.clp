
(deffunction print (?logical-name $?args)
  (if (member$ python-call (get-function-list))
   then (funcall python-call pyprintout ?logical-name $?args)
   else (progn$ (?arg $?args)
          (printout ?logical-name ?arg))))

(deffunction readline1 ($?logical-name)
  (if (> (length$ $?logical-name) 0)
   then (bind ?logical-name (first$ $?logical-name))
   else (bind ?logical-name t))

  (if (member$ python-call (get-function-list))
   then (funcall python-call pyreadline ?logical-name)
   else (readline ?logical-name)))

(deffunction readinput ($?logical-name)
  (if (> (length$ $?logical-name) 0)
   then (bind ?logical-name (first$ $?logical-name))
   else (bind ?logical-name t))

  (if (member$ python-call (get-function-list))
   then (eval (funcall python-call pyread ?logical-name))
   else (read ?logical-name)))
