[uname.lsp]
#!/usr/bin/newlisp
(set 'evalstring "(exec \
"uname -s -n -m\ ")")
(println (net-eval (list
(list "localhost" 31337 evalstring)
(list "192.168.0.55"
31337 evalstring)
(list "192.168.0.102"
31337 evalstring)
(list "192.168.0.127"
31337 evalstring)
) 3000))
(exit)
