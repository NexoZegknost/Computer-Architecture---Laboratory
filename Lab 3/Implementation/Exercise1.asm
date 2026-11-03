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
    li   $v0, 2
    syscall
    li   $v0, 4
    la   $a0, newline
    syscall

    add.s $f12, $f28, $f30
    div.s $f12, $f12, $f26
    li   $v0, 4
    la   $a0, msgX2
    syscall
    li   $v0, 2
    syscall
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
    add.s $f12, $f12, $f4
    li   $v0, 4
    la   $a0, msgOne
    syscall
    li   $v0, 2
    syscall
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
