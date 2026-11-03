.data
fileIn:     .asciiz "raw_input.txt"
fileOut:    .asciiz "formatted_result.txt"
msgOpenErr: .asciiz "Can not open the file raw_input.txt"
msgOutErr:  .asciiz "Can not create the file formatted_result.txt"
header:     .asciiz "-----Student personal information-----\n"
lblName:    .asciiz "Name: "
lblID:      .asciiz "ID: "
lblAddr:    .asciiz "Address: "
lblAge:     .asciiz "Age: "
lblRel:     .asciiz "Religion: "
labels:     .word lblName, lblID, lblAddr, lblAge, lblRel
buffer:     .space 512

.text
main:
    li   $v0, 13
    la   $a0, fileIn
    li   $a1, 0
    li   $a2, 0
    syscall
    bltz $v0, open_error
    move $s0, $v0

    li   $v0, 14
    move $a0, $s0
    la   $a1, buffer
    li   $a2, 511
    syscall
    move $s1, $v0
    bgez $s1, read_ok
    li   $s1, 0
read_ok:
    li   $v0, 16
    move $a0, $s0
    syscall

    li   $v0, 9
    addi $a0, $s1, 1
    syscall
    move $s2, $v0

    la   $t0, buffer
    move $t1, $s2
    li   $t2, 0
copy_loop:
    beq  $t2, $s1, copy_end
    lb   $t3, 0($t0)
    beq  $t3, 10, copy_end
    beq  $t3, 13, copy_end
    sb   $t3, 0($t1)
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    addi $t2, $t2, 1
    j    copy_loop
copy_end:
    sb   $zero, 0($t1)

    li   $v0, 9
    li   $a0, 1024
    syscall
    move $s3, $v0
    move $s4, $s3

    la   $a0, header
    jal  append_str

    move $s5, $s2
    li   $s6, 0
    la   $s7, labels
field_loop:
    beq  $s6, 5, build_end
    sll  $t0, $s6, 2
    add  $t0, $s7, $t0
    lw   $a0, 0($t0)
    jal  append_str
field_copy:
    lb   $t3, 0($s5)
    beq  $t3, $zero, field_end
    blt  $s6, 4, check_comma
    j    field_store
check_comma:
    beq  $t3, 44, field_skip
field_store:
    sb   $t3, 0($s4)
    addi $s4, $s4, 1
    addi $s5, $s5, 1
    j    field_copy
field_skip:
    addi $s5, $s5, 1
field_end:
    li   $t3, 10
    sb   $t3, 0($s4)
    addi $s4, $s4, 1
    addi $s6, $s6, 1
    j    field_loop
build_end:
    sb   $zero, 0($s4)
    sub  $s1, $s4, $s3

    li   $v0, 4
    move $a0, $s3
    syscall

    li   $v0, 13
    la   $a0, fileOut
    li   $a1, 1
    li   $a2, 0
    syscall
    bltz $v0, out_error
    move $s0, $v0

    li   $v0, 15
    move $a0, $s0
    move $a1, $s3
    move $a2, $s1
    syscall

    li   $v0, 16
    move $a0, $s0
    syscall
    j    exit

open_error:
    li   $v0, 4
    la   $a0, msgOpenErr
    syscall
    j    exit

out_error:
    li   $v0, 4
    la   $a0, msgOutErr
    syscall

exit:
    li   $v0, 10
    syscall

append_str:
    lb   $t3, 0($a0)
    beq  $t3, $zero, append_end
    sb   $t3, 0($s4)
    addi $s4, $s4, 1
    addi $a0, $a0, 1
    j    append_str
append_end:
    jr   $ra
