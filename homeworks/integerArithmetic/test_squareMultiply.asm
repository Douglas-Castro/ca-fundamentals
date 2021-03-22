.text
	li $t2, 65521
	
	li $t1,1

        lbu $t2, ($a0)      #$t2 = $a0[i]
        
        beq $t2, $t1, squaremultiply  #se $t2 == 1, jump to squaremultiply
        
        beq $t2, $zero, square      #se $t2 == 0, jump to square

        squaremultiply:
      	li 	$v0, 4			
	la 	$a0, um
	syscall		       

        square:
      	li 	$v0, 4			
	la 	$a0, zero
	syscall	
.data
zero: .asciiz	"zero\n"
um: .asciiz	"um\n"