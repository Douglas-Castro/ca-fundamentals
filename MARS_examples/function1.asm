# f = (g + h) - (i + j)

.data
ans:	.asciiz "RESULTADO: "

.text 
	addi $s1, $zero, 4 		# g = 4
	addi $s2, $zero, 3 		# h = 3
	addi $s3, $zero, 2		# i = 2
	addi $s4, $zero, 1		# j = 1
	
	add $t0, $s1, $s2		# g + h
	add $t1, $s3, $s4		# i + j
	
	sub $s0, $t0, $t1		# f = $t0 - $t1
	
	addi $v0, $zero, 4		# imprimir string syscall codigo 4
	la $a0, ans 
	syscall
	
	addi $v0, $zero, 1		# imprimir inteiro syscall codigo 1
	add $a0, $zero, $s0		# colocar o valor do resultado em $a0
	syscall