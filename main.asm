.data
    msginicial: .asciiz "Escolha entre:\n1. Cadastrar livro;\n2. Emprestar livro;\n3. Devolver livro;\n4. Listar livros;\n0. Sair;\n\nSua opção: "
    msgopcaoinvalida: .asciiz "Opção inválida!\n"
    msgcadastrar: .asciiz "Digite o titulo do livro: "
    msg_codigo: .asciiz "Codigo: "
    msglivrocadastrado: .asciiz "Livro cadastrado com sucesso!\n"
    livro_buffer: .space 100

    qtd_livros: .word 0
    codigos:    .space 200    # 50 * 4 bytes
    status:     .space 10    # 10 * 1 byte


.text
    #########
    # $t0 = opção escolhida pelo usuário
    # $t1 = nome do livro
    # $t2 = id do livro
    # $t3 = status do livro
    #########
    
    menu: 
        li $v0, 4
        la $a0, msginicial
        syscall
    
        li $v0, 5
        syscall
        move $t0, $v0
    
        beq $t0, 0, exit
        beq $t0, 1, cadastrar
        beq $t0, 2, emprestar
        beq $t0, 3, devolver
        beq $t0, 4, listar
        j opcaoinvalida

    opcaoinvalida:
        li $v0, 4
        la $a0, msgopcaoinvalida
        syscall
        j menu
    
        exit:
        li $v0, 10
        syscall

    cadastrar:
        #counter +1
        lw $t2, qtd_livros
        addi $t2, $t2, 1

        #print msg
        li $v0, 4
        la $a0, msgcadastrar
        syscall

        #le nome do livro
        li $v0, 8
        la $a0, livro_buffer
        li $a1, 100
        syscall

        #mostra o codigo do livro
        li $v0, 4
        la $a0, msg_codigo
        syscall
        li $v0, 1
        move $a0, $t2
        syscall


        #mostra que o livro foi cadastrado
        li $v0, 4
        la $a0, msglivrocadastrado
        syscall

        j menu
