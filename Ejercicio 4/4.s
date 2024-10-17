.text
.global main
main:
    movq $-1, %rax #0xffffffffffffffff
    movb $0, %al #0xffffffffffffff00
    movw $0, %ax #0xffffffffffff0000
    movl $0, %eax #0x0
    retq

#If %al or %ax are modified only the corresponding area of the regeister changes, however if %eax is modified the high part of the register gets
#set to zero