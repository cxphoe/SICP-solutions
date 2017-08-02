; the apply-generic procedure is called twice when execute the
; (magnitude z) which is defined as (apply-generic 'magniture z).
; the structure of z is like '(complex (polar (r a))) with two tags.

; when we execute (magniture z), the process used to handle the z
; in the apply-generic would be (get 'magnitude 'complex) which is
; not defined within the install-complex-package. so system will try
; to find its defination in the global environment which is the same
; with the process mantioned at the beginning. So the following proc
; would be (magnitude z). At this point, the first tag of z is ridded
; so that the z is '(polar (r a)) literally. So the proc would get
; access to the apply-generic and end up with getting the process
; (get 'magniture 'polar) used to handle the z, which is defined within
; install-polar-package. At this point, z become (r a). 