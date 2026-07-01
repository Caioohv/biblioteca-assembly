.data
    msginicial: .asciiz "Escolha entre:\n1. Cadastrar livro;\n2. Emprestar livro;\n3. Devolver livro;\n4. Listar livros;\n0. Sair;\n\nSua opção: "
    msgopcaoinvalida: .asciiz "Opção inválida!\n"
    msgcadastrar: .asciiz "Digite o titulo do livro: "
    msg_codigo: .asciiz "Codigo: "
    msglivrocadastrado: .asciiz "  -  Livro cadastrado com sucesso!\n"
    msg_disponivel: .asciiz " | Disponivel\n"
    msg_emprestado: .asciiz " | Emprestado\n"
    livro_buffer: .space 100

    qtd_livros: .word 0
    codigos:    .space 200    # 50 * 4 bytes
    status:     .space 50    # 50 * 1 byte


.text
    menu:
        li $v0, 4
        la $a0, msginicial
        syscall

        li $v0, 5
        syscall
        move $t0, $v0

        beq $t0, 0, exit
        beq $t0, 1, cadastrar
        #beq $t0, 2, emprestar
        #beq $t0, 3, devolver
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
        #print msg
        li $v0, 4
        la $a0, msgcadastrar
        syscall

        #le nome do livro
        li $v0, 8
        la $a0, livro_buffer
        li $a1, 100
        syscall

        #counter + 1
        lw $t1, qtd_livros
        addi $t2, $t1, 1
        sw $t2, qtd_livros

        la $t3, codigos    # puxa o array
        sll $t4, $t1, 2    # mult por 4 (int = 4)
        add $t4, $t3, $t4   # t4 = &codigos[indice]
        sw $t2, 0($t4)     # codigos[indice] = codigo

        la $t5, status
        add $t5, $t5, $t1  # t5 = &status[indice]
        li $t6, 1          # 1 = disponivel, 2 = alugado
        sb $t6, 0($t5)     # status[indice] = livre

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

    listar:
        lw $t0, qtd_livros  # total de livros
        li $t1, 0           # indice atual

    listar_loop:
        beq $t1, $t0, menu   # se indice == total, acabou -> volta pro menu

        #mostra "Codigo: "
        li $v0, 4
        la $a0, msg_codigo
        syscall

        #mostra codigos[indice]
        la $t3, codigos
        sll $t4, $t1, 2 # x 4
        add $t4, $t3, $t4
        
        #print int
        li $v0, 1
        lw $a0, 0($t4)
        syscall

        #pega status[indice]
        la $t5, status
        add $t5, $t5, $t1
        lb $t6, 0($t5)

        beq $t6, 1, listar_disponivel
        j listar_emprestado

    listar_disponivel:
        li $v0, 4
        la $a0, msg_disponivel
        syscall
        j listar_proximo

    listar_emprestado:
        li $v0, 4
        la $a0, msg_emprestado
        syscall

    listar_proximo:
        addi $t1, $t1, 1
        j listar_loop
