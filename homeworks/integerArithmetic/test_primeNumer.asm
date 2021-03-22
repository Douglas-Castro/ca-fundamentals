.data
erro:		.asciiz "O modulo nao eh primo.\n"
saida:		.asciiz "Eh primo.\n"
.text
main:
		li	$v0, 5
		syscall
		
		move	$a0, $v0
		move	$a1, $v0
		
		j	exit
eh_primo:
		li	$t0,  2				# carrega o $t0 com o valor 2
		
		beq	$a0, $t0, fim_loop_eh_primo	# se $a0 = $t0, jump para fim_loop_eh_primo
		
		li	$t2,1				# carrega em $t2 o valor 1
		
		beq	$t2, $a0, imprimir_erro	# se $t2 = $a0, jump para imprimir_erro
		
		li	$t1, 0				# carrega com 0 o reg $t1
		
		divu	$a0, $t0			# divide $a0 por $t0
		
		mfhi	$t3				# carrega $t3 com o resto da divisão
		
		beq	$t3, $zero, imprimir_erro	# se $t3 = $zero, jump imprimir_erro2
		
		li	$t1, 3 # i = 3
		li	$t2, 256 # i < 256
		move	$t3, $a1 # num
loop_eh_primo:
		beq	$t1, $t3, fim_loop_eh_primo

		divu	$t3, $t1
		
		mfhi	$t4
		
		beq	$t4, $zero, imprimir_erro
		
		addi	$t1, $t1, 2
		
		beq	$t1, $t2, fim_loop_eh_primo	
		
		j	loop_eh_primo			# jump para  loop_eh_primo
fim_loop_eh_primo:
		jr 	$ra				# jump para PC+4
imprimir_erro:
		li	$v0, 4				# Carrega $vo com o código para imprimir uma string
		la 	$a0, erro			# imprime a string erro_1
		syscall
		j	exit
imprimir_saida:
		li	$v0, 4				# Carrega $vo com o código para imprimir uma string
		la 	$a0, saida			# imprime a string erro_1
		syscall
exit:
		li	$v0, 10
		syscall