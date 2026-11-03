.data
promptU:    .asciiz "Please insert u: "
promptV:    .asciiz "Please insert v: "
promptA:    .asciiz "Please insert a: "
promptB:    .asciiz "Please insert b: "
promptC:    .asciiz "Please insert c: "
promptD:    .asciiz "Please insert d: "
promptE:    .asciiz "Please insert e: "
msgResult:  .asciiz "Result: "
msgZero:    .asciiz "The denominator d^4 + e^3 is zero, the integral can not be calculated."
zero:       .float 0.0
two:        .float 2.0
six:        .float 6.0
seven:      .float 7.0

.text
main:
    la   $a0, promptU
    jal  read_float
    mov.s $f20, $f0
    la   $a0, promptV
    jal  read_float
    mov.s $f21, $f0
    la   $a0, promptA
    jal  read_float
    mov.s $f22, $f0
    la   $a0, promptB
    jal  read_float
    mov.s $f23, $f0
    la   $a0, promptC
    jal  read_float
    mov.s $f24, $f0
    la   $a0, promptD
    jal  read_float
    mov.s $f25, $f0
    la   $a0, promptE
    jal  read_float
    mov.s $f26, $f0

    mul.s $f4, $f25, $f25
    mul.s $f4, $f4, $f4
    mul.s $f6, $f26, $f26
    mul.s $f6, $f6, $f26
    add.s $f27, $f4, $f6

    l.s  $f8, zero
    c.eq.s $f27, $f8
    bc1t denominator_zero

    mov.s $f12, $f20
    jal  antiderivative
    mov.s $f28, $f0

    mov.s $f12, $f21
    jal  antiderivative
    sub.s $f28, $f28, $f0

    div.s $f12, $f28, $f27
    l.s  $f8, zero
    add.s $f12, $f12, $f8

    li   $v0, 4
    la   $a0, msgResult
    syscall
    li   $v0, 2
    syscall
    j    exit

denominator_zero:
    li   $v0, 4
    la   $a0, msgZero
    syscall

exit:
    li   $v0, 10
    syscall

read_float:
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    jr   $ra

antiderivative:
    mul.s $f4, $f12, $f12
    mul.s $f6, $f4, $f4
    mul.s $f6, $f6, $f4
    mul.s $f8, $f6, $f12

    mul.s $f8, $f8, $f22
    l.s  $f10, seven
    div.s $f8, $f8, $f10

    mul.s $f6, $f6, $f23
    l.s  $f10, six
    div.s $f6, $f6, $f10

    mul.s $f4, $f4, $f24
    l.s  $f10, two
    div.s $f4, $f4, $f10

    add.s $f0, $f8, $f6
    add.s $f0, $f0, $f4
    jr   $ra
