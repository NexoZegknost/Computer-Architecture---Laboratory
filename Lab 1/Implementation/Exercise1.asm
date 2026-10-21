.data
prompt:     .asciiz "Please enter your name: "
hello:      .asciiz "Hello, "
excl:       .asciiz "!"
name:       .space  64

.text
main:
    li   $v0, 4
    la   $a0, prompt
    syscall

    li   $v0, 8
    la   $a0, name
    li   $a1, 64
    syscall

    la   $t0, name
    addi $t2, $zero, 10
strip:
    lb   $t1, 0($t0)
    beq  $t1, $zero, print
    beq  $t1, $t2, found
    addi $t0, $t0, 1
    j    strip
found:
    sb   $zero, 0($t0)

print:
    li   $v0, 4
    la   $a0, hello
    syscall

    li   $v0, 4
    la   $a0, name
    syscall

    li   $v0, 4
    la   $a0, excl
    syscall

    li   $v0, 10
    syscall
