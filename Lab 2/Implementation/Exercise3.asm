.data
array:      .space  40
prompt:     .asciiz "Please insert a element:"
msgValue:   .asciiz "Second largest value is "
msgIndex:   .asciiz ", found in index "
comma:      .asciiz ", "
msgNone:    .asciiz "There is no second largest value."

.text
main:
    la   $s0, array
    li   $s1, 0
input_loop:
    beq  $s1, 10, find_max
    li   $v0, 4
    la   $a0, prompt
    syscall
    li   $v0, 5
    syscall
    sll  $t0, $s1, 2
    add  $t0, $s0, $t0
    sw   $v0, 0($t0)
    addi $s1, $s1, 1
    j    input_loop

find_max:
    lw   $s2, 0($s0)
    li   $s1, 1
max_loop:
    beq  $s1, 10, find_second
    sll  $t0, $s1, 2
    add  $t0, $s0, $t0
    lw   $t1, 0($t0)
    ble  $t1, $s2, max_next
    move $s2, $t1
max_next:
    addi $s1, $s1, 1
    j    max_loop

find_second:
    li   $s4, 0
    li   $s1, 0
second_loop:
    beq  $s1, 10, check_second
    sll  $t0, $s1, 2
    add  $t0, $s0, $t0
    lw   $t1, 0($t0)
    bge  $t1, $s2, second_next
    beq  $s4, $zero, second_set
    ble  $t1, $s3, second_next
second_set:
    move $s3, $t1
    li   $s4, 1
second_next:
    addi $s1, $s1, 1
    j    second_loop

check_second:
    bne  $s4, $zero, print_value
    li   $v0, 4
    la   $a0, msgNone
    syscall
    j    exit

print_value:
    li   $v0, 4
    la   $a0, msgValue
    syscall
    li   $v0, 1
    move $a0, $s3
    syscall
    li   $v0, 4
    la   $a0, msgIndex
    syscall

    li   $s5, 0
    li   $s1, 0
index_loop:
    beq  $s1, 10, exit
    sll  $t0, $s1, 2
    add  $t0, $s0, $t0
    lw   $t1, 0($t0)
    bne  $t1, $s3, index_next
    beq  $s5, $zero, index_print
    li   $v0, 4
    la   $a0, comma
    syscall
index_print:
    li   $v0, 1
    move $a0, $s1
    syscall
    li   $s5, 1
index_next:
    addi $s1, $s1, 1
    j    index_loop

exit:
    li   $v0, 10
    syscall
