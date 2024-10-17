.global main
main:
movb $0xFE, %al #0xFE = 254
movb $-1, %bl
addb %bl, %al #We are doing 254 + (-1) = 253
incb %bl #No effect, just modifying bl
ret
