.data
promptA:    .asciiz "Insert a: "
promptB:    .asciiz "Insert b: "
promptC:    .asciiz "Insert c: "
promptD:    .asciiz "Insert d: "
msgF:       .asciiz "F = "
msgRem:     .asciiz ", remainder "

.text
main:
    li   $v0, 4
    la   $a0, promptA
    syscall
    li   $v0, 5
    syscall
    move $s0, $v0

    li   $v0, 4
    la   $a0, promptB
    syscall
    li   $v0, 5
    syscall
    move $s1, $v0

    li   $v0, 4
    la   $a0, promptC
    syscall
    li   $v0, 5
    syscall
    move $s2, $v0

    li   $v0, 4
    la   $a0, promptD
    syscall
    li   $v0, 5
    syscall
    move $s3, $v0

    addi $t0, $s0, 10
    sub  $t1, $s1, $s3
    add  $t2, $s0, $s0
    sub  $t2, $s2, $t2
    mul  $t3, $t0, $t1
    mul  $t3, $t3, $t2

    add  $t4, $s0, $s1
    add  $t4, $t4, $s2

    div  $t3, $t4
    mflo $s4
    mfhi $s5

    li   $v0, 4
    la   $a0, msgF
    syscall
    li   $v0, 1
    move $a0, $s4
    syscall

    li   $v0, 4
    la   $a0, msgRem
    syscall
    li   $v0, 1
    move $a0, $s5
    syscall

    li   $v0, 10
    syscall
