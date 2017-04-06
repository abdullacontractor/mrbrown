# mrbrown
English Language Knowledge Based System.

How to use the clp file.
```
Clips > (clear)
Clips > (load sentence.clp)
Clips > (reset)
Clips > (add-rules wrong-rule.txt)
Clips > //Add the bigram rules you want to test
Clips > (run)
```

Just copy and paste the following for a no mistake example.
```
(clear)
(load sentence.clp)
(reset)
(add-rules wrong-rule.txt)
(assert (bigram (tags DT-NN) (words "The chair")))
(assert (bigram (tags NN-VBP) (words "chair is")))
(assert (bigram (tags VBP-DT) (words "is the")))
(assert (bigram (tags DT-JJS) (words "the biggest")))
(run)
```
Just copy and paste the following for a mistake example.
```
(clear)
(load sentence.clp)
(reset)
(add-rules wrong-rule.txt)
(assert (bigram (tags DT-NN) (words "The chair")))
(assert (bigram (tags NN-JJS) (words "chair biggest")))
(run)
```
