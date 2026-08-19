CREATE DATABASE IF NOT EXISTS biblioteca
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE biblioteca;

CREATE TABLE IF NOT EXISTS cidade (
    id_cidade INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    estado CHAR(2) NOT NULL,
    pais VARCHAR(50) NOT NULL DEFAULT 'Brasil',
    PRIMARY KEY (id_cidade),
    CONSTRAINT uq_cidade_nome_estado_pais UNIQUE (nome, estado, pais)
);

CREATE TABLE IF NOT EXISTS endereco (
    id_endereco INT UNSIGNED NOT NULL AUTO_INCREMENT,
    cep CHAR(9) NOT NULL,
    rua VARCHAR(120) NOT NULL,
    bairro VARCHAR(80) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(80),
    id_cidade INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_endereco),
    CONSTRAINT fk_endereco_cidade
        FOREIGN KEY (id_cidade) REFERENCES cidade (id_cidade)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS usuario (
    id_usuario INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL,
    telefone VARCHAR(20),
    id_endereco INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_usuario),
    CONSTRAINT uq_usuario_email UNIQUE (email),
    CONSTRAINT fk_usuario_endereco
        FOREIGN KEY (id_endereco) REFERENCES endereco (id_endereco)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS editora (
    id_editora INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome VARCHAR(120) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(150),
    PRIMARY KEY (id_editora),
    CONSTRAINT uq_editora_nome UNIQUE (nome)
);

CREATE TABLE IF NOT EXISTS livro (
    id_livro INT UNSIGNED NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(180) NOT NULL,
    ano_publicacao YEAR,
    isbn VARCHAR(20),
    id_editora INT UNSIGNED,
    PRIMARY KEY (id_livro),
    CONSTRAINT uq_livro_isbn UNIQUE (isbn),
    CONSTRAINT fk_livro_editora
        FOREIGN KEY (id_editora) REFERENCES editora (id_editora)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS autor (
    id_autor INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome VARCHAR(120) NOT NULL,
    PRIMARY KEY (id_autor)
);

CREATE TABLE IF NOT EXISTS assunto (
    id_assunto INT UNSIGNED NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(100) NOT NULL,
    genero VARCHAR(80),
    sinopse VARCHAR(500),
    PRIMARY KEY (id_assunto),
    CONSTRAINT uq_assunto_descricao UNIQUE (descricao)
);

CREATE TABLE IF NOT EXISTS livro_autor (
    id_livro INT UNSIGNED NOT NULL,
    id_autor INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_livro, id_autor),
    CONSTRAINT fk_livro_autor_livro
        FOREIGN KEY (id_livro) REFERENCES livro (id_livro)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_livro_autor_autor
        FOREIGN KEY (id_autor) REFERENCES autor (id_autor)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS livro_assunto (
    id_livro INT UNSIGNED NOT NULL,
    id_assunto INT UNSIGNED NOT NULL,
    nivel_relevancia TINYINT UNSIGNED NOT NULL DEFAULT 1,
    comentario VARCHAR(255),
    PRIMARY KEY (id_livro, id_assunto),
    CONSTRAINT chk_livro_assunto_relevancia CHECK (nivel_relevancia BETWEEN 1 AND 5),
    CONSTRAINT fk_livro_assunto_livro
        FOREIGN KEY (id_livro) REFERENCES livro (id_livro)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_livro_assunto_assunto
        FOREIGN KEY (id_assunto) REFERENCES assunto (id_assunto)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS exemplar (
    id_exemplar INT UNSIGNED NOT NULL AUTO_INCREMENT,
    id_livro INT UNSIGNED NOT NULL,
    codigo_tombo VARCHAR(40) NOT NULL,
    data_aquisicao DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'DISPONIVEL',
    PRIMARY KEY (id_exemplar),
    CONSTRAINT uq_exemplar_codigo_tombo UNIQUE (codigo_tombo),
    CONSTRAINT chk_exemplar_status
        CHECK (status IN ('DISPONIVEL', 'EMPRESTADO', 'MANUTENCAO', 'BAIXADO')),
    CONSTRAINT fk_exemplar_livro
        FOREIGN KEY (id_livro) REFERENCES livro (id_livro)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS emprestimo (
    id_emprestimo INT UNSIGNED NOT NULL AUTO_INCREMENT,
    id_usuario INT UNSIGNED NOT NULL,
    data_emprestimo DATE NOT NULL,
    data_prevista DATE NOT NULL,
    data_devolucao DATE,
    multa DECIMAL(10, 2) UNSIGNED NOT NULL DEFAULT 0.00,
    status VARCHAR(20) NOT NULL DEFAULT 'ABERTO',
    PRIMARY KEY (id_emprestimo),
    CONSTRAINT chk_emprestimo_periodo
        CHECK (data_prevista >= data_emprestimo),
    CONSTRAINT chk_emprestimo_devolucao
        CHECK (data_devolucao IS NULL OR data_devolucao >= data_emprestimo),
    CONSTRAINT chk_emprestimo_status
        CHECK (status IN ('ABERTO', 'DEVOLVIDO', 'ATRASADO')),
    CONSTRAINT fk_emprestimo_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS emprestimo_exemplar (
    id_emprestimo INT UNSIGNED NOT NULL,
    id_exemplar INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_emprestimo, id_exemplar),
    CONSTRAINT fk_emprestimo_exemplar_emprestimo
        FOREIGN KEY (id_emprestimo) REFERENCES emprestimo (id_emprestimo)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_emprestimo_exemplar_exemplar
        FOREIGN KEY (id_exemplar) REFERENCES exemplar (id_exemplar)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

