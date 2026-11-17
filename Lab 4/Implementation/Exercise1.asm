# CO2008 - Lab 4 - Exercise 1
# Author: Nguyen Huynh Huu Duc - 2510290
# Determine Tag / Index / Byte offset

.data
addrBits:   .word 32
cacheSize:  .word 4194304
blockSize:  .word 256
unitSize:   .word 1
waysArr:    .word 1, 4, 0

title:      .asciiz "Exercise 1: 32-bit address, 4MB cache, 256B block, byte access\n"
nameA:      .asciiz "(a) Direct mapped         : "
nameB:      .asciiz "(b) 4-way set associative : "
nameC:      .asciiz "(c) Fully associative     : "
names:      .word nameA, nameB, nameC
sTag:       .asciiz "Tag = "
sIdx:       .asciiz " bits, Index = "
sOff:       .asciiz " bits, Byte offset = "
sBits:      .asciiz " bits\n"

.text
main:
    li   $v0, 4
    la   $a0, title
    syscall

    lw   $t0, blockSize
    lw   $t1, unitSize
    divu $t0, $t1
    mflo $a0
    jal  log2
    move $s0, $v0

    lw   $t0, cacheSize
    lw   $t1, blockSize
    divu $t0, $t1
    mflo $s1

    li   $s2, 0
loop:
    beq  $s2, 3, done
    sll  $t0, $s2, 2
    lw   $t1, waysArr($t0)
    bnez $t1, notFA
    move $t1, $s1
notFA:
    divu $s1, $t1
    mflo $a0
    jal  log2
    move $s3, $v0
    lw   $t2, addrBits
    sub  $s4, $t2, $s3
    sub  $s4, $s4, $s0

    sll  $t0, $s2, 2
    lw   $a0, names($t0)
    li   $v0, 4
    syscall
    la   $a0, sTag
    syscall
    li   $v0, 1
    move $a0, $s4
    syscall
    li   $v0, 4
    la   $a0, sIdx
    syscall
    li   $v0, 1
    move $a0, $s3
    syscall
    li   $v0, 4
    la   $a0, sOff
    syscall
    li   $v0, 1
    move $a0, $s0
    syscall
    li   $v0, 4
    la   $a0, sBits
    syscall

    addi $s2, $s2, 1
    j    loop
done:
    li   $v0, 10
    syscall

log2:
    li   $v0, 0
log2_loop:
    sltiu $t9, $a0, 2
    bnez $t9, log2_end
    srl  $a0, $a0, 1
    addi $v0, $v0, 1
    j    log2_loop
log2_end:
    jr   $ra
