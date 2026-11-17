# CO2008 - Lab 4 - Exercise 3
# Author: Nguyen Huynh Huu Duc - 2510290
# Count HIT / MISS of the word-address sequence

.data
seq:        .word 0, 4, 1, 5, 65, 1, 67, 46, 1, 70, 2, 0
N:          .word 12
cacheSize:  .word 256
blockSize:  .word 16
waysArr:    .word 1, 2, 0
cTag:       .space 64
cTime:      .space 64
trace:      .asciiz "x x x x x x x x x x x x"

title:      .asciiz "Exercise 3: sequence 0 4 1 5 65 1 67 46 1 70 2 0 (256B cache, 4-word block)\n"
nameA:      .asciiz "(a) Direct mapped         : "
nameB:      .asciiz "(b) 2-way set associative : "
nameC:      .asciiz "(c) Fully associative     : "
names:      .word nameA, nameB, nameC
sHit:       .asciiz "  -> HIT = "
sMiss:      .asciiz ", MISS = "
nl:         .asciiz "\n"

.text
main:
    li   $v0, 4
    la   $a0, title
    syscall
    li   $s0, 0
loop:
    beq  $s0, 3, done
    sll  $t0, $s0, 2
    lw   $a0, waysArr($t0)
    jal  sim
    move $s1, $v0
    move $s2, $v1

    sll  $t0, $s0, 2
    lw   $a0, names($t0)
    li   $v0, 4
    syscall
    la   $a0, trace
    syscall
    la   $a0, sHit
    syscall
    li   $v0, 1
    move $a0, $s1
    syscall
    li   $v0, 4
    la   $a0, sMiss
    syscall
    li   $v0, 1
    move $a0, $s2
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall

    addi $s0, $s0, 1
    j    loop
done:
    li   $v0, 10
    syscall

sim:
    lw   $t0, cacheSize
    lw   $t1, blockSize
    divu $t0, $t1
    mflo $t0
    bnez $a0, sim_w
    move $a0, $t0
sim_w:
    move $t1, $a0
    divu $t0, $t1
    mflo $t2
    li   $t3, 0
sim_init:
    beq  $t3, $t0, sim_init_end
    sll  $t4, $t3, 2
    li   $t5, -1
    sw   $t5, cTag($t4)
    sw   $zero, cTime($t4)
    addi $t3, $t3, 1
    j    sim_init
sim_init_end:
    li   $v0, 0
    li   $v1, 0
    li   $t3, 0
    lw   $t8, N
sim_acc:
    beq  $t3, $t8, sim_end
    sll  $t4, $t3, 2
    lw   $t5, seq($t4)
    sll  $t5, $t5, 2
    lw   $t6, blockSize
    divu $t5, $t6
    mflo $t5
    divu $t5, $t2
    mfhi $t6
    mul  $t6, $t6, $t1
    li   $t7, 0
    move $a1, $t6
    li   $a2, 0x7fffffff
sim_srch:
    beq  $t7, $t1, sim_miss
    add  $t9, $t6, $t7
    sll  $t9, $t9, 2
    lw   $a3, cTag($t9)
    beq  $a3, $t5, sim_hit
    lw   $a3, cTime($t9)
    bge  $a3, $a2, sim_next
    move $a2, $a3
    add  $a1, $t6, $t7
sim_next:
    addi $t7, $t7, 1
    j    sim_srch
sim_hit:
    addi $v0, $v0, 1
    addi $a3, $t3, 1
    sw   $a3, cTime($t9)
    li   $a3, 'H'
    j    sim_rec
sim_miss:
    addi $v1, $v1, 1
    sll  $t9, $a1, 2
    sw   $t5, cTag($t9)
    addi $a3, $t3, 1
    sw   $a3, cTime($t9)
    li   $a3, 'M'
sim_rec:
    sll  $t9, $t3, 1
    sb   $a3, trace($t9)
    addi $t3, $t3, 1
    j    sim_acc
sim_end:
    jr   $ra
