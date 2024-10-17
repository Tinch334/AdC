.data
list: .long 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
length: .byte 10

.text
.global main
main:
    movl $0, %eax #Used to keep the total sum
    movq $list, %rbx #Set ebx to be a pointer to the start of "list".
    movq length, %rcx #Store list length in rcx to use "loop".

countLoop:
    movl -4(%rbx, %rcx, 4), %esi #Get value stored in "rbx(list) + rcx * 4 - 4", which are the elements in the list.
    addl %esi, %eax #Add the obtained value to our counter.

    loop countLoop

ret