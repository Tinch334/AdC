.global main

main:
a:
    movb $100, %al
    movb $120, %bl
    addb %bl, %al
    #Results in OF being set.
b:
    movb $-63, %al
    movb $-56, %bl
    addb %bl, %al
    #Results in CF being set.
c:
    movb $-63, %al
    movb $-91, %bl
    addb %bl, %al
    #Results in OF and CF being set.
d:
    movb $120, %al
    movb $-56, %bl
    subb %bl, %al
    #Results in OF being set.
e:
    movb $-91, %al
    movb $120, %bl
    subb %bl, %al
    #Results in OF being set.

    ret
