USE biblioteca;

INSERT IGNORE INTO cidade (id_cidade, cep, estado, pais, nome) VALUES
(1, '99700-000', 'RS', 'Brasil', 'Erechim'),
(2, '99930-000', 'RS', 'Brasil', 'Estação'),
(3, '99010-000', 'RS', 'Brasil', 'Passo Fundo');

INSERT IGNORE INTO endereco (id_endereco, rua, bairro, numero, id_cidade) VALUES
(1, 'Rua das Flores', 'Centro', '123', 1),
(2, 'Rua dos Pioneiros', 'Centro', '45', 2),
(3, 'Avenida Brasil', 'Bela Vista', '900', 3);

INSERT IGNORE INTO usuario (id_usuario, nome, email, telefone, id_endereco) VALUES
(1, 'Ana Pereira', 'ana.pereira@example.com', '54999990001', 1),
(2, 'João Dias', 'joao.dias@example.com', '54999990002', 2),
(3, 'Carla Mendes', 'carla.mendes@example.com', '54999990003', 3);

INSERT IGNORE INTO editora (id_editora, nome, telefone, email) VALUES
(1, 'Editora Horizonte', '1133330000', 'contato@horizonte.example'),
(2, 'Editora Saber', '1144440000', 'contato@saber.example'),
(3, 'Editora Cultura', '1155550000', 'contato@cultura.example');

INSERT IGNORE INTO livro (id_livro, titulo, ano_publicacao, isbn, id_editora) VALUES
(1, 'Banco de Dados Relacionais', 2023, '9780000000001', 1),
(2, 'Introdução à Programação', 2022, '9780000000002', 2),
(3, 'História Antiga', 2020, '9780000000003', 3),
(4, 'Arquitetura de Software', 2024, '9780000000004', 1);

INSERT IGNORE INTO autor (id_autor, nome) VALUES
(1, 'Carlos Almeida'),
(2, 'Fernanda Costa'),
(3, 'Mariana Rocha');

INSERT IGNORE INTO assunto (id_assunto, descricao, genero, sinopse) VALUES
(1, 'Tecnologia', 'Educação', 'Obras relacionadas à computação e sistemas.'),
(2, 'Programação', 'Educação', 'Conteúdo sobre lógica e desenvolvimento de software.'),
(3, 'História', 'Acadêmico', 'Obras relacionadas a períodos e acontecimentos históricos.');

INSERT IGNORE INTO livro_autor (id_livro, id_autor) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(4, 2);

INSERT IGNORE INTO livro_assunto (id_livro, id_assunto, nivel_relevancia, comentario) VALUES
(1, 1, 5, 'Banco de dados e modelagem relacional.'),
(2, 2, 5, 'Introdução aos fundamentos de programação.'),
(3, 3, 5, 'Conteúdo histórico.'),
(4, 1, 4, 'Arquitetura aplicada ao desenvolvimento de sistemas.'),
(4, 2, 3, 'Relaciona conceitos de programação e organização de software.');

INSERT IGNORE INTO emprestimo (
    id_emprestimo,
    id_usuario,
    data_emprestimo,
    data_prevista,
    data_devolucao,
    multa,
    status
) VALUES
(1, 1, '2026-08-01', '2026-08-08', '2026-08-07', 0.00, 'DEVOLVIDO'),
(2, 2, '2026-08-10', '2026-08-17', NULL, 5.00, 'ATRASADO'),
(3, 3, '2026-08-15', '2026-08-22', NULL, 0.00, 'ABERTO');

INSERT IGNORE INTO emprestimo_livro (id_emprestimo, id_livro, quantidade) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 1),
(3, 4, 1);
