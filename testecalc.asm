.data
	num1: .word 0
	num2: .word 0
	resultado: .word 0
	msg1: .asciiz "\nInsira o primeiro numero: "
	msg2: .asciiz "\nInsira o segundo numero: "
	msg3: .asciiz "\nO resultado da soma eh: "

.text
.globl main
main:
	lw $s0, num1
	lw $s1, num2

	li $v0, 4 
	la $a0, msg1 # imprime a msg1
	syscall
	li $v0, 5 # le o numero dado
	syscall
	move $s0, $v0 # move o valor armazenado em $v0 para o $s0
	
	# mesma coisa de antes abaixo:
	li $v0, 4 
	la $a0, msg2 # imprime a msg2
	syscall
	li $v0, 5 # le o numero dado
	syscall
	move $s1, $v0 # move o valor em $v0 pro $s1
	
	li $v0, 4 
	la $a0, msg3 # imprime a msg3
	
	add $s2, $s0, $s1 # soma dos conteudos em $s0 e $s1 no reg $s0
	la $s3, resultado # armazena o endereço de resultado em $s3
	sw $s2, 0($s3)  # armazena o resultado na variavel result
	syscall
	
	
	li $v0, 1
	lw $a0, resultado
	syscall
	j main
	
	li $v0, 10
	syscall
	
