.data
promptA:    .asciiz "Please insert a: "
promptB:    .asciiz "Please insert b: "
promptC:    .asciiz "Please insert c: "
msgX1:      .asciiz "x1 = "
msgX2:      .asciiz "x2 = "
msgOne:     .asciiz "There is one solution, x = "
msgNone:    .asciiz "There is no real solution"
msgInf:     .asciiz "There are infinitely many solutions"
newline:    .asciiz "\n"
zero:       .float 0.0
two:        .float 2.0
four:       .float 4.0
dZero:      .double 0.0
dHalf:      .double 0.5
dScale:     .double 10000.0

.text
main:
    li   $v0, 4
    la   $a0, promptA
    syscall
    li   $v0, 6
    syscall
    mov.s $f20, $f0

    li   $v0, 4
    la   $a0, promptB
    syscall
    li   $v0, 6
    syscall
    mov.s $f21, $f0

    li   $v0, 4
    la   $a0, promptC
    syscall
    li   $v0, 6
    syscall
    mov.s $f22, $f0

    l.s  $f4, zero
    c.eq.s $f20, $f4
    bc1t linear

    mul.s $f6, $f21, $f21
    l.s  $f8, four
    mul.s $f8, $f8, $f20
    mul.s $f8, $f8, $f22
    sub.s $f24, $f6, $f8

    l.s  $f10, two
    mul.s $f26, $f10, $f20
    neg.s $f28, $f21

    c.lt.s $f24, $f4
    bc1t no_solution
    c.eq.s $f24, $f4
    bc1t one_solution

    sqrt.s $f30, $f24
    sub.s $f12, $f28, $f30
    div.s $f12, $f12, $f26
    li   $v0, 4
    la   $a0, msgX1
    syscall
    jal  print_float4
    li   $v0, 4
    la   $a0, newline
    syscall

    add.s $f12, $f28, $f30
    div.s $f12, $f12, $f26
    li   $v0, 4
    la   $a0, msgX2
    syscall
    jal  print_float4
    j    exit

one_solution:
    div.s $f12, $f28, $f26
    j    print_one

linear:
    c.eq.s $f21, $f4
    bc1t degenerate
    neg.s $f12, $f22
    div.s $f12, $f12, $f21

print_one:
    li   $v0, 4
    la   $a0, msgOne
    syscall
    jal  print_float4
    j    exit

degenerate:
    c.eq.s $f22, $f4
    bc1f no_solution
    li   $v0, 4
    la   $a0, msgInf
    syscall
    j    exit

no_solution:
    li   $v0, 4
    la   $a0, msgNone
    syscall

exit:
    li   $v0, 10
    syscall

print_float4:
    cvt.d.s $f0, $f12
    li   $t9, 0
    l.d  $f2, dZero
    c.lt.d $f0, $f2
    bc1f pf_round
    neg.d $f0, $f0
    li   $t9, 1
pf_round:
    l.d  $f2, dScale
    mul.d $f0, $f0, $f2
    l.d  $f2, dHalf
    add.d $f0, $f0, $f2
    floor.w.d $f4, $f0
    mfc1 $t0, $f4
    beq  $t9, $zero, pf_print
    beq  $t0, $zero, pf_print
    li   $v0, 11
    li   $a0, 45
    syscall
pf_print:
    li   $t1, 10000
    div  $t0, $t1
    mflo $t2
    mfhi $t3
    li   $v0, 1
    move $a0, $t2
    syscall
    li   $v0, 11
    li   $a0, 46
    syscall
    li   $v0, 11
    li   $a0, 48
    bge  $t3, 1000, pf_frac
    syscall
    bge  $t3, 100, pf_frac
    syscall
    bge  $t3, 10, pf_frac
    syscall
pf_frac:
    li   $v0, 1
    move $a0, $t3
    syscall
    jr   $ra
