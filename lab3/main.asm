.text
.globl main

main:
    li $s1,101;li $s2,102;li $s3,103  # every time the made_up procedure ends,
    li $s4,104;li $s5,105  # these registers’ original values must be restored
    li $s6,106;li $s7,107  # VALUES WILL CHANGE, use stack to store-restore

    addi $sp, $sp, -4
    sw   $ra, 0($sp)     # push($ra)
    li   $s0, 0          # $s0 = array indexer
main_loop:
    lw   $a0, N($s0)     # $a0 = N[$s0]
    beqz $a0, main_done  # end loop if N[$s0] == 0
    lw   $a1, K($s0)     # $a1 = K[$s0]
    jal  combination     # $v0 = $a0 choose $a1
    sw   $v0, C($s0)     # C[$s0] = $v0
    addi $s0, $s0, 4     # $s0 += 4
    b    main_loop       # loop
main_done:
    sw   $zero, C($s0)   # mark the end of the array C
    lw   $ra, 0($sp)     # pop($ra)
    addi $sp, $sp, 4
    jr   $ra

combination:
    # iki argm alıyoruz  $a0 > $a1   end result to $v0 
    sub $sp, $sp, 24 
    sw $ra, 20($sp)  # adress 
    sw $a0, 16($sp)    #  a0
    sw $a1, 12($sp)      # a1
    jal   factorial
    sw $v0, 8($sp)  # result of a0!
    lw $a0,12($sp)  # sp deki a1’i a0’a attımı 
    jal factorial
    sw $v0, 4($sp)  # result of a1!
    lw $t1,8($sp)  #result of a0 
    lw $t2,4($sp) #result of a1
    divu $t1,$t2
    mflo $t3
    sw $t3, 0($sp) # now 4 is the result of a0/a1
    lw $t4,16($sp)  #a0 
    lw $t5,12($sp) # a1
    sub $t5,$t4,$t5
    add $a0,$t5,$a0
    jal factorial
    lw $t6,0($sp)
    divu $t6,$v0
    mflo $v0
    lw $ra, 20($sp)
    addi $sp, $sp, 24
    jr   $ra

factorial:
    li $a1,0;li $a2,0;li $a3,0;li $v1,0 # combination procedure
    li $t0,0;li $t1,0;li $t2,0;li $t3,0 # should not rely on these
    li $t4,0;li $t5,0;li $t6,0          # being preserved, because...
    li $t7,0;li $t8,0;li $t9,0  # all the temporaries are cleared!

    li   $v0, 1               # $v0 = 1
factorial_loop:
    beqz $a0, factorial_done  # end loop if $a0 == 0
    mul  $v0, $v0, $a0        # $v0 *= $a0
    addi $a0, $a0, -1         # $a0 -= 1
    b    factorial_loop       # loop
factorial_done:
    jr   $ra

.data 
N: .word  8,  5, 1,  12,  0
K: .word  8,  1,  1,  6,  0
C: .word  0



