.data
array:      .space  20
prompt:     .asciiz "Please input element "
colon:      .asciiz ": "
msgResult:  .asciiz "Result: "
space:      .asciiz " "

.text
main:
    la   $s0, array
    li   $s1, 0
input_loop:
    beq  $s1, 5, round_start
    li   $v0, 4
    la   $a0, prompt
    syscall
    li   $v0, 1
    move $a0, $s1
    syscall
    li   $v0, 4
    la   $a0, colon
    syscall
    li   $v0, 5
    syscall
    sll  $t0, $s1, 2
    add  $t0, $s0, $t0
    sw   $v0, 0($t0)
    addi $s1, $s1, 1
    j    input_loop

round_start:
    li   $s1, 0
round_loop:
    beq  $s1, 5, print_start
    sll  $t0, $s1, 2
    add  $s2, $s0, $t0
    lw   $a0, 0($s2)
    jal  round4
    sw   $v0, 0($s2)
    addi $s1, $s1, 1
    j    round_loop

print_start:
    li   $v0, 4
    la   $a0, msgResult
    syscall
    li   $s1, 0
print_loop:
    beq  $s1, 5, exit
    sll  $t0, $s1, 2
    add  $t0, $s0, $t0
    lw   $a0, 0($t0)
    li   $v0, 1
    syscall
    li   $v0, 4
    la   $a0, space
    syscall
    addi $s1, $s1, 1
    j    print_loop

exit:
    li   $v0, 10
    syscall

round4:
    li   $t1, 4
    div  $a0, $t1
    mfhi $t2
    bgez $t2, round4_mod
    addi $t2, $t2, 4
round4_mod:
    li   $t3, 2
    bgt  $t2, $t3, round4_up
    sub  $v0, $a0, $t2
    jr   $ra
round4_up:
    sub  $t3, $t1, $t2
    add  $v0, $a0, $t3
    jr   $ra
