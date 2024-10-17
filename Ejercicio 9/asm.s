.text

#Caluclates the factorial of the given number, takes the number in %rdi.
.global fact2
fact2:
    #Prelude
    pushq %rbp
    movq %rsp, %rbp

    movq $1, %rax

    movq %rdi, %rcx #Store the number in %rcx to use loop.

    #Performs %rax *= %rcx
    fact2Loop:
        mulq %rcx
        loop fact2Loop

    #Epilogue
    movq %rbp, %rsp
    popq %rbp

    ret