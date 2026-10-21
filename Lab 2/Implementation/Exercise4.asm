.data
prompt:     .asciiz "Please enter a non-negative integer: "
msgInvalid: .asciiz "A factorial for your number can not be found."
msgLarge:   .asciiz "The factorial of your number is too large to be displayed."

.text
main:
    li   $v0, 4
    la   $a0, prompt
    syscall
    li   $v0, 5
    syscall
    move $s0, $v0

    bltz $s0, invalid
    li   $t0, 12
    bgt  $s0, $t0, too_large

    move $a0, $s0
    jal  fact
    move $a0, $v0
    li   $v0, 1
    syscall
    j    exit

invalid:
    li   $v0, 4
    la   $a0, msgInvalid
    syscall
    j    exit

too_large:
    li   $v0, 4
    la   $a0, msgLarge
    syscall

exit:
    li   $v0, 10
    syscall

fact:
    addi $sp, $sp, -8
    sw   $ra, 4($sp)
    sw   $a0, 0($sp)
    bgtz $a0, fact_recurse
    li   $v0, 1
    j    fact_return
fact_recurse:
    addi $a0, $a0, -1
    jal  fact
    lw   $a0, 0($sp)
    mul  $v0, $a0, $v0
fact_return:
    lw   $ra, 4($sp)
    addi $sp, $sp, 8
    jr   $ra
