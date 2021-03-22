	.text
main:
	jal 	ler_inteiro			# Jump para função ler_inteiro
	move	$s0, $v0			# Carrega $s0 com o valor lido na função le_inteiro

	jal	ler_inteiro			# Jump para função ler_inteiro
	move	$s1, $v0			# Carrega $s1 com o valor lido na função le_inteiro
	
	li	$t0, 1				# Carrega o valor imediato 1 no registrador $t0
	ble     $s0, $t0, imprimir_erro_1	# Se $a0 <= $t0 chama função imprime_erro_1	
	
	li	$t0, 16
	ble     $s1, $0, imprimir_erro_1	# Se $s1 <= $0 chama função imprime_erro_1 
	bgt     $s1, $t0, imprimir_erro_1	# Se $s1 > $t0 chama função imprime_erro_1 
	
	li	$a0, 2				# Carrega o imediato 1 no registrador $t0
	jal	encontra_inteiros		# Jump para encontra_inteiros
	
	move	$a0, $v0			# Copia o registrador $v0 em $a0
	move	$a1, $v1			# Copia o registrador $v1 em $a1
	
	jal 	calc_raiz			# Jump para calc_raiz
	
	jal	imprimir_saida			# Jump para função imprimir_saida
		
	j	exit				# Jump para exit
ler_inteiro:
	li 	$v0, 5				# Carrega o valor imediato 5 no registrador $v0 
	syscall					# Executa a chamada para ler um inteiro
	
	jr 	$ra				# Jump para proxima instrução da main
encontra_inteiros:
	multu	$a0,$a0				# Multiplica o valor em $t0 por ele mesmo ($to)²
	mflo	$t0				# Guarda o resultado da multiplicação anterior em $t0
	
	bgt	$t0, $s0, fim			# Se $t0 > $s0, jump para fim
	beq	$t0, $s0, exata_fim		# Se $t0 = $s0, jump para exata	
	
	addi	$a0, $a0, 1			# Soma o imediato 1 em $a0
	
	j	encontra_inteiros		# Jump para encontra_inteiros
fim:	
	move	$v1, $a0			# Copia o inteiro $a0 em $v1 (retorno da função)
	addi	$a0, $a0, -1			# Subtrai o imediato 1 do registrador $a0 
	move	$v0, $a0			# Copia o inteiro $a0 em $v0 (retorno da função)
	
	jr	$ra				# Jump para proxima instrução da main
exata_fim:
	addi	$a0, $a0, -1			# Subtrai o imediato 1 do registrador $a0 
	move	$v0, $a0			# Copia o inteiro $a0 em $v0 (retorno da função)
	addi	$a0, $a0, 2			# Subtrai o imediato 1 do registrador $a0 
	move	$v1, $a0			# Copia o inteiro $a0 em $v1 (retorno da função)
	
	jr	$ra
calc_raiz:#########################$f4 = a  ||  $f6 = b  ||  $f20 = x
	mtc1.d 	$s0, $f20
	cvt.d.w $f20, $f20			# Converte para double o valor em $f20
	
	li	$t0, 1				# Carrega o reg $t0 com o imediato 1
	li	$t1, 10				# Carrega o reg $t1 com o imediato 10
	
	mtc1.d 	$t0, $f8
	cvt.d.w $f8, $f8			# Converte para double o valor em $f8
	
	mtc1.d 	$t1, $f10
	cvt.d.w $f10, $f10			# Converte para double o valor em $f10
loop_erro:
	addi	$s1, $s1, -1			# Subtrai 1 do reg $s1 
	
	div.d	$f8, $f8, $f10			# $f8 = $f8 / $f10
	
	bne	$s1, $0, loop_erro		# Se $s1 != 0, jump para loop_erro

	mtc1.d 	$a0, $f4
	cvt.d.w $f4, $f4			# Converte para double o valor em $f4
	
	mtc1.d 	$a1, $f6
	cvt.d.w $f6, $f6			# Converte para double o valor em $f6
	
	sub.d	$f10,$f6, $f4			# $f10 = $f6 - $f4
	
	abs.d	$f10, $f10			# Valor absoluto de $f10
	
	c.le.d 	$f10, $f8			# Se $f10 <= $f8 cc = 1, cc = 0 caso contrario
	
	bc1t 	fim_calc			# Se flag = 1, jump para fim_calc

	div.d	$f6, $f20, $f4			# $f6 = $f20 / $f4
	
	sub.d	$f10,$f6, $f4			# $f10 = $f6 - $f4
	
	abs.d	$f10, $f10			# Valor absoluto de $f10
	
	c.le.d 	$f10, $f8			# Se $f10 <= $f8 cc = 1, cc = 0 caso contrario
	
	bc1t 	fim_calc			# Se flag = 1, jump para fim_calc
	
	li	$t1, 2				# Carrega o reg $t1 com o imediato 2
	
	mtc1.d 	$t1, $f12
	cvt.d.w $f12, $f12			# Converte para double o valor em $f12
	
	li	$t1, 1				# Carrega o reg $t1 com o imediato 0
	li	$t0, 101
loop_calc:
	addi	$t1, $t1, 1			# Soma uma unidade em $t1 (contador do loop)
	beq	$t1, $t0, imprimir_erro_2	# Se $t1 = $t0, jump para imprimir_erro_2
	
	add.d	$f4, $f4, $f6			# $f4 = $f4 + $f6
	div.d	$f4, $f4, $f12			# $f4 = $f4 / $f12
	
	div.d	$f6, $f20, $f4			# $f6 = $f20 / $f4
	
	sub.d	$f10, $f4, $f6			# $f10 = $f6 - $f4
	
	abs.d	$f10, $f10			# Valor absoluto de $f10
	
	c.le.d 	$f10, $f8			# Se $f10 <= $f8 cc = 1, cc = 0 caso contrario
	
	bc1t 	fim_calc			# Se flag = 1, jump para fim_calc
	
	j	loop_calc			# Jump para loop_calc 
fim_calc:
	move	$s3, $t1			# Copia o contador para o reg $s3
	
	jr	$ra
imprimir_saida:  ### $s3 = contador
	li 	$v0, 4				# Carrega o valor imediato 4 no registrador $v0
	la 	$a0, saida_1_1			# Imprime a string saida_1_1
	syscall					# Executa a chamada para imprimir uma string
		
	li 	$v0, 1				# Carrega o valor imediato 1 no registrador $v0			
	move 	$a0, $s0			# Imprime o inteiro que está em $s0	
	syscall					# Executa a chamada para imprimir um inteiro
	
	li 	$v0, 4				# Carrega o valor imediato 4 no registrador $v0
	la 	$a0, saida_1_2			# Imprime a string saida_1_2
	syscall					# Executa a chamada para imprimir uma string
	
	li	$v0, 3	
	mov.d 	$f12,$f6
	syscall
	
	li 	$v0, 4				# Carrega o valor imediato 4 no registrador $v0
	la 	$a0, saida_1_3			# Imprime a string saida_1_3
	syscall					# Executa a chamada para imprimir uma string
	
	li 	$v0, 1				# Carrega o valor imediato 1 no registrador $v0			
	move 	$a0, $s3			# Imprime o inteiro que está em $s3	
	syscall					# Executa a chamada para imprimir um inteiro
	
	li 	$v0, 4				# Carrega o valor imediato 4 no registrador $v0
	la 	$a0, saida_1_4			# Imprime a string saida_1_4
	syscall					# Executa a chamada para imprimir uma string
		
	j	exit				# Jump para exit
imprimir_erro_1:
	li	$v0, 4				# Carrega o valor imediato 4 no registrador $v0
	la 	$a0, erro_1			# Imprime a string erro_1
	syscall					# Executa a chamada para imprimir uma string
		
	j 	exit				# Jump para exit
imprimir_erro_2:
	li 	$v0, 4				# Carrega o valor imediato 4 no registrador $v0
	la 	$a0, erro_2_1			# Imprime a string erro_2-1
	syscall					# Executa a chamada para imprimir uma string
		
	li 	$v0, 1				# Carrega o valor imediato 1 no registrador $v0	
	move 	$a0, $s0			# Imprime o inteiro que está em $s0
	syscall					# Executa a chamada para imprimir um inteiro
	
	li 	$v0, 4				# Carrega o valor imediato 4 no registrador $v0
	la 	$a0, erro_2_2			# Imprime a string erro_2-2
	syscall					# Executa a chamada para imprimir uma string
	
	j 	exit				# Jump para exit
exit:
	li	$v0, 10				# Carrega o valor imediato 10 no registrador $v0
	syscall					# Executa a chamada para finalizar o programa
################################################################################################################################
	.data
erro_1:		.asciiz "Entradas invalidas.\n"
erro_2_1:	.asciiz "Nao foi possivel calcular sqrt("
erro_2_2:	.asciiz ").\n"
saida_1_1:	.asciiz "A raiz quadrada de "
saida_1_2:	.asciiz " eh "
saida_1_3:	.asciiz ", calculada em "
saida_1_4:	.asciiz " iteracoes.\n"
