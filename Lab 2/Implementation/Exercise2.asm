.data
promptA:    .asciiz "a = "
promptB:    .asciiz "b = "
msgInvalid: .asciiz "Invalid input. Please enter a positive integer.\n"
msgGCD:     .asciiz "GCD="
msgLCM:     .asciiz ", LCM="

.text
main:
read_a:
    li   $v0, 4
    la   $a0, promptA
    syscall
    li   $v0, 5
    syscall
    move $s0, $v0
    bgtz $s0, read_b
    li   $v0, 4
    la   $a0, msgInvalid
    syscall
    j    read_a

read_b:
    li   $v0, 4
    la   $a0, promptB
    syscall
    li   $v0, 5
    syscall
    move $s1, $v0
    bgtz $s1, compute
    li   $v0, 4
    la   $a0, msgInvalid
    syscall
    j    read_b

compute:
    move $a0, $s0
    move $a1, $s1
    jal  gcd
    move $s2, $v0

    div  $s0, $s2
    mflo $t0
    mul  $s3, $t0, $s1

    li   $v0, 4
    la   $a0, msgGCD
    syscall
    li   $v0, 1
    move $a0, $s2
    syscall
    li   $v0, 4
    la   $a0, msgLCM
    syscall
    li   $v0, 1
    move $a0, $s3
    syscall

    li   $v0, 10
    syscall

gcd:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)
    bne  $a1, $zero, gcd_recurse
    move $v0, $a0
    j    gcd_return
gcd_recurse:
    div  $a0, $a1
    move $a0, $a1
    mfhi $a1
    jal  gcd
gcd_return:
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra
