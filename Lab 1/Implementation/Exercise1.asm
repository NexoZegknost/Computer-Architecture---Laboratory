#Program: Hello, World!

.data

strIn: .space 100

.text

main:

la $a0, strIn
addi $a1, $0, 10
li $v0, 8
syscall

li $v0, 10
syscall