.global main
main:
    
a:
    movl $1, %eax
    sall $31, %eax
    #We obtain 10000000000000000000000000000000.

b:
    #The first two lines are to make each point self contained.
    movl $1, %eax
    sall $31, %eax
    movl $1, %ebx
    sall $15, %ebx
    orl %ebx, %eax
    #We obtain 10000000000000001000000000000000.

c:
    movl $-1, %eax
    andl $0xFFFFFF00, %eax
    #We obtain 11111111111111111111111100000000.

d:
    movl $0xAA, %eax
    sall $24, %eax
    orl $0xAA, %eax
    #We obtain 10101010000000000000000010101010.

e:
    movw $5, %ax
    salw $8, %ax
    #We obtain 0000010100000000.

f:
    movw $-1, %ax
    movw $1, %bx
    salw $8, %bx
    notw %bx
    andw %bx, %ax
    #We obtain 1111111011111111.

    ret
