.text
.globl main
main:
	li $t0 , 0
	la $t1,myarray1 #address
	la $t2,myarray2 #address
	

	
	
loop:	
	lb $t3, 0($t1)  #   t3 is the corresponding element of the first  array
	lb $t4, 0($t2)   #  t4 is the corresponding element of the second array
	beq $t3,$t0,exit
	add $t3,$t4,$t3
	sb $t3,($t1)  ########
	addi $t1,$t1,1
	addi $t2,$t2,1
	j loop


exit:
	jr $ra



.data
myarray1: .byte 45 84 22 12 5 -4 9 4 0
myarray2: .byte 1 2 3 -9 -8 -7 10 11 0
	
	