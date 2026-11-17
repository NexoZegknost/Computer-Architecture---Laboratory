# CO2008 - Lab 4 - Exercise 5
# Author: Nguyen Huynh Huu Duc - 2510290
# Two-level cache AMAT

.data
hitL1:      .float 10.0
hitL2:      .float 15.0
memTime:    .float 100.0
missL1:     .float 0.2
missL2:     .float 0.1

title:      .asciiz "Exercise 5: L1 hit = 10, L2 hit = 15, RAM = 100 cycles, L1 miss = 20%, L2 miss = 10%\n"
sPenL1:     .asciiz "L1 miss penalty = 15 + 0.1 x 100 = "
sAmat:      .asciiz "AMAT = 10 + 0.2 x "
sEq:        .asciiz " = "
sCyc:       .asciiz " cycles\n"

.text
main:
    li   $v0, 4
    la   $a0, title
    syscall

    l.s  $f0, hitL1
    l.s  $f1, hitL2
    l.s  $f2, memTime
    l.s  $f3, missL1
    l.s  $f4, missL2

    mul.s $f5, $f4, $f2
    add.s $f5, $f1, $f5
    mul.s $f6, $f3, $f5
    add.s $f6, $f0, $f6

    li   $v0, 4
    la   $a0, sPenL1
    syscall
    li   $v0, 2
    mov.s $f12, $f5
    syscall
    li   $v0, 4
    la   $a0, sCyc
    syscall

    li   $v0, 4
    la   $a0, sAmat
    syscall
    li   $v0, 2
    mov.s $f12, $f5
    syscall
    li   $v0, 4
    la   $a0, sEq
    syscall
    li   $v0, 2
    mov.s $f12, $f6
    syscall
    li   $v0, 4
    la   $a0, sCyc
    syscall

    li   $v0, 10
    syscall
