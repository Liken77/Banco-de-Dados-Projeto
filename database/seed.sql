USE biblioteca;

INSERT IGNORE INTO cidade (id_cidade, nome, estado, pais) VALUES
(1, 'Erechim', 'RS', 'Brasil'),
(2, 'Estação', 'RS', 'Brasil'),
(3, 'Passo Fundo', 'RS', 'Brasil');

INSERT IGNORE INTO endereco (
    id_endereco, cep, rua, bairro, numero, complemento, id_cidade
) VALUES
(1, '99700-000', 'Rua das Flores', 'Centro', '123', NULL, 1),
(2, '99930-000', 'Rua dos Pioneiros', 'Centro', '45', 'Apartamento 2', 2),
(3, '99010-000', 'Avenida Brasil', 'Bela Vista', '900', NULL, 3);

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

INSERT IGNORE INTO livro_assunto (
    id_livro, id_assunto, nivel_relevancia, comentario
) VALUES
(1, 1, 5, 'Banco de dados e modelagem relacional.'),
(2, 2, 5, 'Introdução aos fundamentos de programação.'),
(3, 3, 5, 'Conteúdo histórico.'),
(4, 1, 4, 'Arquitetura aplicada ao desenvolvimento de sistemas.'),
(4, 2, 3, 'Relaciona programação e organização de software.');

INSERT IGNORE INTO exemplar (
    id_exemplar, id_livro, codigo_tombo, data_aquisicao, status
) VALUES
(1, 1, 'BDR-001', '2024-02-10', 'DISPONIVEL'),
(2, 1, 'BDR-002', '2024-02-10', 'DISPONIVEL'),
(3, 2, 'PRG-001', '2024-03-15', 'DISPONIVEL'),
(4, 3, 'HIS-001', '2024-04-20', 'EMPRESTADO'),
(5, 4, 'ARQ-001', '2025-01-12', 'EMPRESTADO'),
(6, 4, 'ARQ-002', '2025-01-12', 'MANUTENCAO');

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

INSERT IGNORE INTO emprestimo_exemplar (id_emprestimo, id_exemplar) VALUES
(1, 1),
(1, 3),
(2, 4),
(3, 5);

