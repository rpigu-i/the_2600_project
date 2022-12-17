[port.lsp]
#!/usr/bin/newlisp
(set 'params (main-args))
(if (< (length params) 5)
(begin
(println "USAGE: port.lsp
host begin-port end-port")
(exit)
)
)
(set 'host (nth 2 params))
(set 'bport (int (nth 3 params)))
(set 'eport (int (nth 4 params)))
(for (port bport eport)
(begin
(set 'socket (net-connect host port))
(if socket (println port " open"))
)
)
(exit)
