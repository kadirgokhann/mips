.text
.globl main
main:
	li $t0 , 0 #current index
	li $t6 , 0
	li $t5 , 0 #index of min element
	add $t5,$t6,$t5
	la $t1,myarray #address of array
	lb $t3, 0($t1)  #t3 is the corresponding element of the first  array && t3 is min element.
	beq $t3,$zero,exit
	
loop:	
	addi $t1,$t1,1
	lb $t4, 0($t1)  #arrayin yeni elmkontrol etmek icin yeni bir reg atıyoruz. t4 is new elm
	beq $t4,$zero,save
	addi $t0,$t0,1 # i++
	bge $t4,$t3,loop  #bge R1, R2, label If (R1 ≥ R2) goto label, else continue
	add $t3,$t4,$t6  #t6=0
	add $t5,$t0,$t6
	j loop
save:
	mul $t3,$t3,$t5

	sw $t3,0x10010070
	j exit
	

exit:
	jr $ra



.data
myarray: .byte 1 4 5 5 7 0

	
