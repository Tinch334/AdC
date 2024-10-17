.global main
main:
    movq $0x1122334455667788, %rax
    addq $0x1122334455667788, %rax
    ret

#An error occurs, because the given direct value is too large, in a 64 bit processor the maximum size for a direct value is 32 bits, except for
#the move instruction, it can take a direct value of 64 bits.