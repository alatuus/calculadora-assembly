.data
	num1: .word 0
	num2: .word 0
	resultado: .word 0
	msg: .asciiz "\nEscolha a operacao:\n "
	pulo: .asciiz "\n"
	msgInicial: .asciiz "Adicao (A), Subtracao (S), Multiplicacao (M), Divisao (D), Potenciacao (P): \n"
	msg1: .asciiz "\nInsira o primeiro numero: "
	msg2: .asciiz "Insira o segundo numero: "
	msg3: .asciiz "\nInsira a base: "
	msg4: .asciiz "Insira a potencia: "
	msgresultado: .asciiz "O resultado eh: "
	zero: .asciiz "O divisor tem que ser diferente de 0.\n"
	
.text
.globl switch

switch:
	lw $s0, num1
	lw $s1, num2
	add $s0, $zero, $zero
	add $s1, $zero, $zero

	la $a0, pulo #um \n
	li $v0, 4 
	syscall
	
	li $v0, 4
	la $a0, msg #mensagem de escolha da operacao
	syscall
	
	la $a0, pulo #um \n
	li $v0, 4 
	syscall
	
	la $a0, msgInicial #mensagem de opcoes para escolha
	li $v0, 4
	syscall    	
    
	la $a0, pulo # outro \n
	li $v0, 4
	syscall
	
	li $v0, 12
	syscall
	move $s4, $v0
    
    	beq $s4, 65, adicao   # Se 'opcao' for igual a 1, pula para caso1
	beq $s4, 83, subtracao    # Se 'opcao' for igual a 2, pula para caso2
	beq $s4, 77, multiplicacao    # Se 'opcao' for igual a 3, pula para caso3
	beq $s4, 68, divisao
	beq $s4, 80, potenciacao
	beq $s4, 97, adicao
    	beq $s4, 115, subtracao
    	beq $s4, 100, divisao
    	beq $s4, 109,  multiplicacao
    	beq $s4, 112, potenciacao
	j fim 
	
adicao:
	li $v0, 4 
	la $a0, msg1
	syscall

	li $v0, 5
	syscall
	move $s0, $v0

	li $v0, 4 
	la $a0, msg2
	syscall

	li $v0, 5
	syscall
	move $s1, $v0

	li $v0, 4 
	la $a0, msgresultado # imprime a mensagem de resultado
	
	add $s2, $s0, $s1 # soma dos conteudos em $s0 e $s1 no reg $s2
	la $s3, resultado # armazena o endereco de resultado em $s3
	sw $s2, 0($s3)  # armazena o resultado na variavel resultado
	syscall
		
	li $v0, 1
	lw $a0, resultado #imprime o resultado
	syscall
	
	li $s2, 0
	
	j switch

subtracao:
	li $v0, 4 
	la $a0, msg1
	syscall

	li $v0, 5
	syscall
	move $s0, $v0

	li $v0, 4 
	la $a0, msg2
	syscall

	li $v0, 5
	syscall
	move $s1, $v0

	li $v0, 4 
	la $a0, msgresultado # imprime a mensagem de resultado
	
	sub $s2, $s0, $s1 # soma dos conteudos em $s0 e $s1 no reg $s2
	la $s3, resultado # armazena o endereco de resultado em $s3
	sw $s2, 0($s3)  # armazena o resultado na variavel resultado
	syscall
		
	li $v0, 1
	lw $a0, resultado #imprime o resultado
	syscall
	
	li $s2, 0
	
	j switch	
	
multiplicacao:
	li $v0, 4 
	la $a0, msg1
	syscall

	li $v0, 5
	syscall
	move $s0, $v0

	li $v0, 4 
	la $a0, msg2
	syscall

	li $v0, 5
	syscall
	move $s1, $v0

	li $v0, 4 
	la $a0, msgresultado # imprime a mensagem de resultado
	
	mul $s2, $s0, $s1 # soma dos conteudos em $s0 e $s1 no reg $s2
	la $s3, resultado # armazena o endereco de resultado em $s3
	sw $s2, 0($s3)  # armazena o resultado na variavel resultado
	syscall
		
	li $v0, 1
	lw $a0, resultado #imprime o resultado
	syscall
	
	li $s2, 0
	
	j switch

divisao:
	li $v0, 4 
	la $a0, msg1
	syscall

	li $v0, 5
	syscall
	move $s0, $v0

	li $v0, 4 
	la $a0, msg2
	syscall

	li $v0, 5
	syscall
	move $s1, $v0
	beqz $s1, igual_zero
	
	li $s2, 0
	bne $s1, $zero, continuacao

igual_zero:
	li $v0, 4
	la $a0, zero
	syscall
	li $v0, 5
	syscall
	move $s1, $v0
	beqz $s1, igual_zero

continuacao:
	li $v0, 4 
	la $a0, msgresultado # imprime a mensagem de resultado
	
	div $s0, $s1 # soma dos conteudos em $s0 e $s1 no reg $s2
	mflo $s2
	la $s3, resultado # armazena o endereīco de resultado em $s3
	sw $s2, 0($s3)  # armazena o resultado na variavel result
	syscall
		
	li $v0, 1
	lw $a0, resultado #imprime o resultado
	syscall
	
	li $s2, 0
	
	j switch
	
potenciacao:	
	lw $s0, num1 # salva o valor de num1 em $s0
	lw $s1, num2 # salva o valor de nm2 em $s1
	
	li $v0, 4
	la $a0, msg3
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0

	li $v0, 4
	la $a0, msg4
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	jal potencia # chama a funcao
	sw $s2, resultado # armazena o endereco de resultado em $s3
	
	li $v0, 4
	la $a0, msgresultado
	syscall
	
	li $v0, 1    
	lw $a0, resultado
	syscall 
	
	li $s2, 0
	
 	# sai do programa
	j switch        
    

.globl potencia
potencia:
	add $t0, $zero, $zero # inicializa o valor de $t0 como zero
	addi $s2, $s2, 1 # valor inicial de $s3 = 1
	
potencia_loop:
	beq $t0, $s1, exit_L # compara o valor de $t0 com o valor do num2. se forem iguais, vai para exit_L
	mul $s2, $s2, $s0 # $s0 = num1 -> x = x * x * x * x .....
	addi $t0, $t0, 1 # atualiza o valor de $t0
	j potencia_loop

exit_L:
	jr $ra	
fim:
	li $v0, 10
	syscall
