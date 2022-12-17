[net-eval-test.lsp]
#!/usr/bin/newlisp
(set 'evalstring "(+ 1 2)")
(println (net-eval (list (list
"192.168.0.55" 31337 evalstring)) 3000))
(exit)
