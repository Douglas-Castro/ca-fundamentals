# f = g + h;

.data
ans:	.asciiz "RESULTADO: "

.text

	add $v0, $zero, 5		# codigo syscall para ler inteiro
	syscall
	
	add $s1, $zero, $v0		# copia do valor lido para $s1, $s1 = g
	
	add $v0, $zero, 5		# codigo syscall para ler inteiro
	syscall
	
	add $s2, $zero, $v0		# copia do valor lido para $s2, $s2 = h
	
	add $s0, $s1, $s2		# g + h
	
	addi $v0, $zero, 4		# imprimir string syscall codigo 4
	la $a0, ans 
	syscall
	
	addi $v0, $zero, 1		# imprimir inteiro syscall codigo 1
	add $a0, $zero, $s0		# colocar o valor do resultado em $a0
	syscall
	
	
	