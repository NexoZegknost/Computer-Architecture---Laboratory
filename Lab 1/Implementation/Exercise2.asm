.data
array:      .space  20
prompt0:    .asciiz "Please input element 0:"
prompt1:    .asciiz "Please input element 1:"
prompt2:    .asciiz "Please input element 2:"
prompt3:    .asciiz "Please input element 3:"
prompt4:    .asciiz "Please input element 4:"
promptIdx:  .asciiz "Please enter index:"

.text
main:
    la   $s0, array

    li   $v0, 4
    la   $a0, prompt0
    syscall
    li   $v0, 5
    syscall
    sw   $v0, 0($s0)

    li   $v0, 4
    la   $a0, prompt1
    syscall
    li   $v0, 5
    syscall
    sw   $v0, 4($s0)

    li   $v0, 4
    la   $a0, prompt2
    syscall
    li   $v0, 5
    syscall
    sw   $v0, 8($s0)

    li   $v0, 4
    la   $a0, prompt3
    syscall
    li   $v0, 5
    syscall
    sw   $v0, 12($s0)

    li   $v0, 4
    la   $a0, prompt4
    syscall
    li   $v0, 5
    syscall
    sw   $v0, 16($s0)

    li   $v0, 4
    la   $a0, promptIdx
    syscall
    li   $v0, 5
    syscall

    add  $t0, $v0, $v0
    add  $t0, $t0, $t0
    add  $t0, $s0, $t0
    lw   $a0, 0($t0)

    li   $v0, 1
    syscall

    li   $v0, 10
    syscall
