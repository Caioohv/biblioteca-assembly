# Biblioteca Assembly

Sistema de biblioteca simples, feito em assembly mips

### Introdução

O bibliotecário precisa de um sistema para gerir sua biblioteca, sendo necessário saber quais livros estão disponíveis e quais estão emprestados.
Deve ser impossível emprestar um livro já emprestado e devolver um livro que não esteja emprestado.

### Especificação técnica

O sistema deve permitir:
- [ ] Cadastrar livros
- [ ] Listar livros e seus estados
- [ ] Emprestar livros
- [ ] Devolver livros

Cada livro terá:
- Código numérico
- Status (disponível (0), emprestado (1))

O sistema possui dois arrays:
- `codigos`: armazena os livros cadastrados
- `status`: armazena os status dos livros