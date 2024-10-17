.data
list: .long 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
length: .byte 10
strSum: .asciz "The sum of the elements is: %d\n"
strMax: .asciz "The maximum element is: %d\n"
strMin: .asciz "The minimum element is: %d\n"
strAvg: .asciz "The average of the list is: %d\n"

.text
.global main
main:
    #Sum of list
    movl $list, %edi #Set %rdi to be a pointer to the start of "list".
    movzb length, %rsi
    call addList

    pushq %rbp #Align the stack to 16 bytes, any register would do.
    leaq strSum, %rdi # Load the address of the string to print.
    movq %rax, %rsi #Store the argument in %rsi.
    call printf
    popq %rbp #Recall value of %rbp

    #Biggest element.
    movl $list, %edi #Set %rdi to be a pointer to the start of "list".
    movzb length, %rsi
    call maxList

    pushq %rbp #Align the stack to 16 bytes, any register would do.
    leaq strMax, %rdi # Load the address of the string to print.
    movq %rax, %rsi #Store the argument in %rsi.
    call printf
    popq %rbp #Recall value of %rbp.

    #Smallest element.
    movl $list, %edi #Set %rdi to be a pointer to the start of "list".
    movzb length, %rsi
    call minList

    pushq %rbp #Align the stack to 16 bytes, any register would do.
    leaq strMin, %rdi # Load the address of the string to print.
    movq %rax, %rsi #Store the argument in %rsi.
    call printf
    popq %rbp #Recall value of %rbp.

    #Average element.
    movl $list, %edi #Set %rdi to be a pointer to the start of "list".
    movzb length, %rsi
    call avgList

    pushq %rbp #Align the stack to 16 bytes, any register would do.
    leaq strAvg, %rdi # Load the address of the string to print.
    movq %rax, %rsi #Store the argument in %rsi.
    call printf
    popq %rbp #Recall value of %rbp.

    xorl %eax, %eax #Return zero.
ret

#Takes the list in %rdi and it's length in %rsi.
.global addList
addList:
    #Prelude
    pushq %rbp
    movq %rsp, %rbp

    movl $0, %eax #Used to keep the total sum
    movq %rsi, %rcx #Store list length in %rcx to use "loop".

    countLoopAdd:
        movl -4(%rdi, %rcx, 4), %r8d #Get value stored in "rbx(list) + rcx * 4 - 4", which are the elements in the list.
        addl %r8d, %eax #Add the obtained value to our counter.

        loop countLoopAdd
    
    cdqe #Extend %eax to %rax.

    #Epilogue
    movq %rbp, %rsp
    popq %rbp

    ret

#Takes the list in %rdi and it's length in %rsi.
.global maxList
maxList:
    #Prelude
    pushq %rbp
    movq %rsp, %rbp

    movq %rsi, %rcx #Store list length in %rcx to use "loop".
    movl -4(%rdi, %rcx, 4), %eax #Stores the last element of the list in %eax, which contains the biggest element.

    decq %rcx #Subtract one since we already processed the last element.

    countLoopMax:
        movl -4(%rdi, %rcx, 4), %r8d #Get value stored in "rbx(list) + rcx * 4 - 4", which are the elements in the list.
        cmp %r8d, %eax #Compare current element against max.
        cmovb %r8d, %eax #Only moves %r8d to %eax if %r8d is greater.

        loop countLoopMax
    
    cdqe #Extend %eax to %rax.

    #Epilogue
    movq %rbp, %rsp
    popq %rbp

    ret

#Takes the list in %rdi and it's length in %rsi.
.global minList
minList:
    #Prelude
    pushq %rbp
    movq %rsp, %rbp

    movq %rsi, %rcx #Store list length in %rcx to use "loop".
    movl -4(%rdi, %rcx, 4), %eax #Stores the last element of the list in %eax, which contains the smallest element.

    decq %rcx #Subtract one since we already processed the last element.

    countLoopMin:
        movl -4(%rdi, %rcx, 4), %r8d #Get value stored in "rbx(list) + rcx * 4 - 4", which are the elements in the list.
        cmp %r8d, %eax #Compare current element against max.
        cmova %r8d, %eax #Only moves %r8d to %eax if %r8d is smaller.

        loop countLoopMin
    
    cdqe #Extend %eax to %rax.

    #Epilogue
    movq %rbp, %rsp
    popq %rbp

    ret

#Takes the list in %rdi and it's length in %rsi.
.global avgList
avgList:
    #Prelude
    pushq %rbp
    movq %rsp, %rbp

    call addList #We already have a function to add all the elements in a list, note that the arguments are already in place.

    #We now have the result of the sum in %rax, assuming we stayed within the bounds of a double word then the result will be contained in
    #%eax, meaning we can already divide.
    movq $0, %rdx #Set high bits to zero.
    div %rsi #Perform unsigned division.

    cdqe #Extend %eax to %rax.

    #Epilogue
    movq %rbp, %rsp
    popq %rbp

    ret