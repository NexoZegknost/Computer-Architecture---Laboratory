.data
prompt:     .asciiz "Please enter a positive integer less than 16: "
msgBin:     .asciiz "Its binary form is: "

.text
main:
    li   $v0, 4
    la   $a0, prompt
    syscall
    li   $v0, 5
    syscall
    move $s0, $v0

    li   $t0, 8
    div  $s0, $t0
    mflo $s1
    mfhi $t1

    li   $t0, 4
    div  $t1, $t0
    mflo $s2
    mfhi $t1

    li   $t0, 2
    div  $t1, $t0
    mflo $s3
    mfhi $s4

    li   $v0, 4
    la   $a0, msgBin
    syscall

    li   $v0, 1
    move $a0, $s1
    syscall
    move $a0, $s2
    syscall
    move $a0, $s3
    syscall
    move $a0, $s4
    syscall

    li   $v0, 10
    syscall
