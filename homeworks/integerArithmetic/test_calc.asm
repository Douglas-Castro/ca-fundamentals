		.data
saida1:		.asciiz "A exponencial modular "
saida2:		.asciiz " elevado a "
saida3:		.asciiz " (mod "
saida4:		.asciiz ") eh "
saida5:		.asciiz "."
saida6:		.asciiz "\n"
.text
main:
		jal 	ler_inteiro			# chama a função ler_inteiro
		move	$s0, $v0			# carrega $s0 com o valor lido na função le_inteiro
		 
		jal	ler_inteiro			# chama a função ler_inteiro
		move	$s1, $v0			# carrega $s1 com o valor lido na função le_inteiro
			
	  	jal	ler_inteiro			# chama a função ler_inteiro
		move	$s2, $v0			# carrega $s2 com o valor lido na função le_inteiro
		
		
		move	$a0, $s0			# carrega $a0 com o valor de $s0
		move	$a1, $s1			# carrega $a1 com o valor de $s1
		move	$a2, $s2			# carrega $a2 com o valor de $s2
				
		jal	calc_exp			# chama função calc_exp
		
		move	$t0, $v0			# carrega em $t0 o valor da retorno da função ($v0) calc_exp
		
		jal	imprimir_saida			# jump para imprimir_saida
		
		j	exit
ler_inteiro:
		li 	$v0, 5				# código para ler um inteiro
		syscall					# executa a chamada para ler
		jr 	$ra				# volta para o lugar de onde foi chamado
calc_exp:#resultado = $t5
		move	$t0, $a1			# carrega $t0 com o valor do segundo parametro da função ($a1)
		move	$t1, $a1			# carrega $t5 com o valo do reg $a1
		li	$t2, 0				# carrega com zero o reg
		li	$t3, 0x80000000			# carrega $t3 com o valor 1
		li	$t4, 0x80000000				# carrega com zero o reg
count:
		addi	$t2, $t2, 1
		srl	$t0, $t0, 1		
		bne	$t0, $zero, count
prepara_exp:
		sll	$t1, $t1, 1			# faz um shift a direita
			
		and	$t0, $t1, $t3			# pega o primeiro bit de $t0($t1 = $t0 and 0x10000000)
		
		beq	$t0, $zero, prepara_exp		# se $t1 = $zero, então jump para prepara_exp
		
		divu	$a0, $a2			# faz uma divisão da base pelo modulo
		
		mfhi	$t5				# guarda o resto em $t5 
		
		sll	$t1, $t1, 1			# faz um shift a direita	
continua:
		addi	$t2, $t2, -1			# subtrai 1 no contador $t6
		
		beq	$t2, $zero, fim_calc		# se $t6 = 0, jump para o fim
		
		and	$t6, $t1, $t3			# pega o primeiro bit de $t0($t1 = $t0 and 0x10000000)
		
		beq	$t6, $t4, square_and_multiply	# se $t1 = 0, jump para square_and_multiply
		
		sll	$t1, $t1, 1			# faz um shift a direita
square:
		multu	$t5, $t5
		
		mflo	$t5
		
		divu	$t5, $a2			# faz uma divisão do resultado anterior pelo modulo
		
		mfhi	$t5				# guarda o resto em $t4
		
		j	continua
square_and_multiply:
		multu	$t5, $t5			# $t5 * $t5
		
		mflo	$t5				# guarda em $t4 o resultado da multiplicação
		
		divu	$t5, $a2			# faz uma divisão do resultado anterior pelo modulo
		
		mfhi	$t5				# guarda o resto em $t4
		
		multu	$t5, $a0			# multiplica a base pelo resultado anterior
		
		mflo	$t5
		
		divu	$t5, $a2			# faz uma divisão do resultado anterior pelo modulo
		
		mfhi	$t5				# guarda o resto em $t4
		
		sll	$t1, $t1, 1			# faz um shift a direita
		
		j 	continua			# jump para continua
fim_calc:
		move	$v0, $t5			# carrega o reg $v0 (retorno da função) com o resultado ($t4)
		jr	$ra
imprimir_saida:
		li 	$v0, 4			
		la 	$a0, saida1
		syscall	
		
		li 	$v0, 1			
		move 	$a0, $s0		
		syscall	
		
		li 	$v0, 4			
		la 	$a0, saida2
		syscall	
		
		li 	$v0, 1			
		move 	$a0, $s1		
		syscall
		
		li 	$v0, 4			
		la 	$a0, saida3
		syscall	
		
		li	$v0, 1			
		move 	$a0, $s2		
		syscall
		
		li	$v0, 4			
		la 	$a0, saida4
		syscall	
		
		li 	$v0, 1			
		move 	$a0, $t0		
		syscall
		
		li 	$v0, 4			
		la 	$a0, saida5
		syscall	
		
		li 	$v0, 4			
		la 	$a0, saida6
		syscall	
exit:
		li	$v0, 10				# código para finalizar um programa
		syscall	