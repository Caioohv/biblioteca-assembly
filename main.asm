.data
    msginicial: .asciiz "Escolha entre:\n1. Cadastrar livro;\n2. Emprestar livro;\n3. Devolver livro;\n4. Listar livros;\n0. Sair;\n\nSua opção: "
    msgopcaoinvalida: .asciiz "Opção inválida!\n"


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
