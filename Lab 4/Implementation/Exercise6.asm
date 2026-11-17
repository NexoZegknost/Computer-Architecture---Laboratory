# CO2008 - Lab 4 - Exercise 6
# Author: Nguyen Huynh Huu Duc - 2510290
# Average CPI of a pipeline with instruction / data cache misses

.data
cpiBase:    .float 1.0
iMiss:      .float 0.05
dMiss:      .float 0.1
penalty:    .float 100.0
nInstr:     .word 1000
nLS:        .word 100

title:      .asciiz "Exercise 6: I-miss = 5%, D-miss = 10%, 1000 instr (100 load/store), penalty = 100 cycles\n"
sIs:        .asciiz "Instruction miss stall = 0.05 x 100 = "
sDs:        .asciiz "Data miss stall = (100/1000) x 0.1 x 100 = "
sCpi:       .asciiz "Average CPI = 1 + "
sPlus:      .asciiz " + "
sEq:        .asciiz " = "
sCyc:       .asciiz " cycles/instr\n"
nl:         .asciiz "\n"

.text
main:
    li   $v0, 4
    la   $a0, title
    syscall

    l.s  $f0, cpiBase
    l.s  $f1, iMiss
    l.s  $f2, dMiss
    l.s  $f3, penalty
    lw   $t0, nLS
    lw   $t1, nInstr
    mtc1 $t0, $f4
    cvt.s.w $f4, $f4
    mtc1 $t1, $f5
    cvt.s.w $f5, $f5
    div.s $f4, $f4, $f5

    mul.s $f6, $f1, $f3
    mul.s $f7, $f4, $f2
    mul.s $f7, $f7, $f3
    add.s $f8, $f0, $f6
    add.s $f8, $f8, $f7

    li   $v0, 4
    la   $a0, sIs
    syscall
    li   $v0, 2
    mov.s $f12, $f6
    syscall
    li   $v0, 4
    la   $a0, sCyc
    syscall

    li   $v0, 4
    la   $a0, sDs
    syscall
    li   $v0, 2
    mov.s $f12, $f7
    syscall
    li   $v0, 4
    la   $a0, sCyc
    syscall

    li   $v0, 4
    la   $a0, sCpi
    syscall
    li   $v0, 2
    mov.s $f12, $f6
    syscall
    li   $v0, 4
    la   $a0, sPlus
    syscall
    li   $v0, 2
    mov.s $f12, $f7
    syscall
    li   $v0, 4
    la   $a0, sEq
    syscall
    li   $v0, 2
    mov.s $f12, $f8
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall

    li   $v0, 10
    syscall
