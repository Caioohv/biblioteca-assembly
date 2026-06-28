.data
    msginicial: .asciiz "Escolha entre:\n1. Cadastrar livro;\n2. Emprestar livro;\n3. Devolver livro;\n4. Listar livros;\n0. Sair;\n\nSua opção: "



.text
    li $v0, 4
    la $a0, msginicial
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 10
    syscall
