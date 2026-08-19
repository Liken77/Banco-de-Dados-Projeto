  -- Sistema de Biblioteca: Controle de Acervo e Empréstimos
-- Nome: Pedro Henrique Andrade 
-- Curso: Análise e Desenvolvimento de Sistemas (ADS)
-- Disciplina: Banco de Dados I

-- Explicação --> = Este trabalho apresenta a análise de um estudo de caso para um Sistema de Biblioteca,
-- incluindo a construção de um Diagrama Entidade-Relacionamento (DER) e a implementação de scripts SQL,
-- para o controle eficiente do acervo de livros e empréstimos. O objetivo é demonstrar como
-- organizar e representar dados em um banco de dados, reduzindo erros e melhorando a eficiência no atendimento bibliotecário.



-- criação da Database.
CREATE DATABASE biblioteca;
USE biblioteca;






-- TABELA CIDADE
CREATE TABLE Cidade (
    idCidade INT PRIMARY KEY AUTO_INCREMENT,
    CEP VARCHAR(10),
    Estado CHAR(2),
    Pais VARCHAR(50),
    Nome VARCHAR(40)
);


-- TABELA ENDEREÇO
CREATE TABLE Endereco (
    idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    Rua VARCHAR(100),
    Bairro VARCHAR(45),
    Numero INT,
    Cidade_idCidade INT NOT NULL,
    FOREIGN KEY (Cidade_idCidade) REFERENCES Cidade(idCidade)
);


-- TABELA USUARIO
CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(45) NOT NULL,
    Email VARCHAR(45),
    Telefone VARCHAR(15),
    Endereco_idEndereco INT NOT NULL,
    FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco(idEndereco)
);


-- TABELA EDITORA
CREATE TABLE Editora (
    idEditora INT PRIMARY KEY AUTO_INCREMENT,
    NomeEditora VARCHAR(45) NOT NULL,
    Telefone VARCHAR(45),
    Email VARCHAR(45)
);


-- TABELA LIVROS
CREATE TABLE Livros (
    idLivros INT PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(45),
    Ano YEAR,
    ISBN VARCHAR(20),
    Editora_idEditora INT,
    FOREIGN KEY (Editora_idEditora) REFERENCES Editora(idEditora)
);


-- TABELA AUTOR
CREATE TABLE Autor (
    idAutor INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    LivrosLançados VARCHAR(100),
    Contrato VARCHAR(100),
    LivrosDistribuidos VARCHAR(100)
);


-- TABELA ASSUNTOS
CREATE TABLE Assuntos (
    idAssuntos INT PRIMARY KEY AUTO_INCREMENT,
    Descricao VARCHAR(45),
    Genero VARCHAR(45),
    Sinopse VARCHAR(45)
);


-- TABELA LIVROS e ASSUNTOS (N:N)
CREATE TABLE Livros_Assuntos (
    idLivrosAssunto INT PRIMARY KEY AUTO_INCREMENT,
    NivelRelevancia VARCHAR(45),
    Livros_idLivros INT NOT NULL,
    Assuntos_idAssuntos INT NOT NULL,
    ComentariosCategoria VARCHAR(100),
    FOREIGN KEY (Livros_idLivros) REFERENCES Livros(idLivros),
    FOREIGN KEY (Assuntos_idAssuntos) REFERENCES Assuntos(idAssuntos)
);


-- TABELA AUTOR e ASSUNTOS (N:N)
CREATE TABLE Autor_Assuntos (
    idAssuntoAutor INT PRIMARY KEY AUTO_INCREMENT,
    idAssuntos INT NOT NULL,
    idAutor INT NOT NULL,
    Ideia VARCHAR(45),
    FOREIGN KEY (idAssuntos) REFERENCES Assuntos(idAssuntos),
    FOREIGN KEY (idAutor) REFERENCES Autor(idAutor)
);


-- TABELA EMPRESTIMO
CREATE TABLE Emprestimo (
    idEmprestimo INT PRIMARY KEY AUTO_INCREMENT,
    DataEmprestimo DATE,
    DataDevolucao DATE,
    Multa DECIMAL(5,2),
    Usuario_idUsuario INT NOT NULL,
    FOREIGN KEY (Usuario_idUsuario) REFERENCES Usuario(idUsuario)
);


-- TABELA EMPRESTIMO e LIVROS (N:N)
CREATE TABLE Emprestimo_Livros (
    idEmprestimoLivros INT PRIMARY KEY AUTO_INCREMENT,
    Emprestimo_idEmprestimo INT NOT NULL,
    Livros_idLivros INT NOT NULL,
    Quantidade INT NOT NULL,
    FOREIGN KEY (Emprestimo_idEmprestimo) REFERENCES Emprestimo(idEmprestimo),
    FOREIGN KEY (Livros_idLivros) REFERENCES Livros(idLivros)
);   

-- INSERTS ABAIXO:
insert INTO cidade (Cep, Estado , Pais ,Nome)
VALUES ('01000-000', 'SP', 'Brasil', 'Sertão'),
('20000-000', 'RJ', 'Brasil', 'Erechim'),
('70000-000', 'DF', 'Brasil', 'Estação'),
('99700-000', 'RS', 'Brasil', 'Erechim'),
('80000-000', 'PR', 'Brasil', 'Carazinho');

INSERT INTO Endereco (Rua , Bairro , Numero , Cidade_idCidade) 
VALUES ('Rua das Flores', 'Centro', 123, 4),
('Rua jõao', 'Bela Vista', 1500, 1),
('Rua Silva', 'Santa fé', 450, 2),
('Rua Pioneiros', 'Centro', 10, 4),
('Rua Vermelha', 'Centro', 800, 5);

INSERT INTO Usuario ( Nome , Email , Telefoen , Endereco_idEndereco)
VALUES ('Marcos Silva', 'marcos@gmail.com', '11999991111', 1),
('Ana Pereira', 'ana.pereira@gmail.com', '11988882222', 2),
('João Dias', 'joaodias@gmail.com', '21977773333', 3),
('Pedro Henrique Andrade', 'pedro.andrade@ifrs.edu.br', '54999990000', 4),
('Carla Mendes', 'carla.mendes@mail.com', '41955554444', 5);

INSERT INTO Editora (NomeEditora, Telefone, Email) VALUES
('Editora Carmesim', '1133330000', 'atlas@edit.com'),
('Editora Moderna', '1122221234', 'moderna@edit.com'),
('Editora Zeus', '1134445678', 'horizonte@edit.com'),
('Editora Sakura', '1145556789', 'saber@edit.com'),
('Editora Cultura', '1156667890', 'cultura@edit.com');

INSERT INTO Livros (Titulo, Ano, ISBN, Editora_idEditora) VALUES
('Banco de Dados', 2020, 'ISBN12345', 1),
('Dados', 2018, 'ISBN54321', 1),
('História Antiga', 2015, 'ISBN99999', 3),
('Historia do Brasileiro', 2012, 'ISBN77777', 5),
('Introdução a Programação', 2021, 'ISBN22222', 2);

INSERT INTO Autor (Nome, LivrosLancados, Contrato, LivrosDistribuidos) VALUES
('Carlos Almeida', '5', 'Ativo', '50000'),
('Fernanda Costa', '8', 'Ativo', '70000'),
('Mariana Rocha', '2', 'Ativo', '15000'),
('Rafael Lima', '3', 'Expirado', '8000'),
('Beatriz Souza', '1', 'Ativo', '3000');

INSERT INTO Assuntos (Descricao, Genero, Sinopse) VALUES
('Tecnologia', 'Educação', 'Livros tecnicos sobre computação e sistemas.'),
('Historia', 'Academico', 'Obras que tratam de eventos históricos.'),
('Romance', 'Ficção', 'Narrativas ficcionais e dramaticas.'),
('Programação', 'Educaçao', 'Livros sobre lógica e linguagens de programação.'),
('Ciências Sociais', 'Academico', 'Textos sobre sociedade e comportamento.');

INSERT INTO Autor_Assuntos (idAssuntos, idAutor, Ideia) VALUES
(1, 1, 'Textos sobre bancos de dados'),
(1, 2, 'Aborda tecnologia e algoritmos'),
(2, 3, 'Pesquisa histórica'),
(3, 4, 'Romances contemporâneos'),
(4, 5, 'Material didático de programação');


INSERT INTO Emprestimo (DataEmprestimo, DataDevolucao, Multa, Usuario_idUsuario) VALUES
('2025-01-10', '2025-01-20', 0.00, 1),
('2025-02-01', '2025-02-11', 5.00, 2),
('2025-03-05', '2025-03-15', 0.00, 3),
('2025-04-10', '2025-04-20', 0.00, 4),
('2025-05-02', '2025-05-12', 2.50, 5);

INSERT INTO Emprestimo_Livros (Emprestimo_idEmprestimo, Livros_idLivros, Quantidade) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 2),
(3, 4, 1),
(4, 5, 1);

-- Alter TABLE: <--- 2 ----->

-- Endereço pra cidade
-- ALTER TABLE Endereco
-- ADD CONSTRAINT fk_Endereco_Cidade
-- FOREIGN KEY (Cidade_idCidade) REFERENCES Cidade(idCidade);

-- Usuario pra endereço
-- ALTER TABLE Usuario
-- ADD CONSTRAINT fk_Usuario_Endereco
-- FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco(idEndereco);

-- Livros pra editora
-- ALTER TABLE Livros
-- ADD CONSTRAINT fk_Livros_Editora
-- FOREIGN KEY (Editora_idEditora) REFERENCES Editora(idEditora);

-- livros_assuntos pra livros
-- ALTER TABLE Livros_Assuntos
-- ADD CONSTRAINT fk_LivrosAssuntos_Livros
-- FOREIGN KEY (Livros_idLivros) REFERENCES Livros(idLivros);

-- Livros_assuntos pra Assuntos
-- ALTER TABLE Livros_Assuntos
-- ADD CONSTRAINT fk_LivrosAssuntos_Assuntos
-- FOREIGN KEY (Assuntos_idAssuntos) REFERENCES Assuntos(idAssuntos);

-- Autor_assuntos pra Autor
-- ALTER TABLE Autor_Assuntos
-- ADD CONSTRAINT fk_AutorAssuntos_Autor
-- FOREIGN KEY (idAutor) REFERENCES Autor(idAutor);

-- Autor_assuntos pra Assuntos
-- ALTER TABLE Autor_Assuntos
-- ADD CONSTRAINT fk_AutorAssuntos_Assuntos
-- FOREIGN KEY (idAssuntos) REFERENCES Assuntos(idAssuntos);

-- Emprestimo pra Usuario
-- ALTER TABLE Emprestimo
-- ADD CONSTRAINT fk_Emprestimo_Usuario
-- FOREIGN KEY (Usuario_idUsuario) REFERENCES Usuario(idUsuario);

-- Emprestimo_livros pra Emprestimo
-- ALTER TABLE Emprestimo_Livros
-- ADD CONSTRAINT fk_EmpLiv_Emprestimo
-- FOREIGN KEY (Emprestimo_idEmprestimo) REFERENCES Emprestimo(idEmprestimo);

-- Emprestimo_livros pra livros
-- ALTER TABLE Emprestimo_Livros
-- ADD CONSTRAINT fk_EmpLiv_Livros
-- FOREIGN KEY (Livros_idLivros) REFERENCES Livros(idLivros);



-- UPdates
-- TELEFONe
UPDATE Usuario 
SET TELEFONE = '120'
WHERE idUsuario = 1;

-- Nome da editora
UPDATE Editora
SET NomeEditora = 'Editora Carmesim Nova Era'
Where idEditora = 1;

-- Atualizar O nome de um livro
UPDATE Livros
SET Titulo = 'Zé do pão'
Where idLivros = 2;

-- Atualizar ano de publicação do livro
UPDATE Livros
Set Ano = 2020
WHERE idLivros =2;

-- Atualizar endereço
UPDATE Usuario
SET Endereco_idEndereco =3
WHERE idUsuario =2;

-- Trocar o CEP
UPDATE Cidade 
SET Cep = '6969'
WHERE idCidade =4;

-- Atualizar a multa de alguém
UPDATE Emprestimo
SET Multa = 10.50
WHERE idEmprestimo =2;

-- Atualizar quantidade de livros emprestados de alguém
UPDATE Emprestimo_Livros
SET Quantidade = 3
WHERE idEmprestimoLivros =3;

-- Alterar a ideia associada a um autor e assunto
UPDATE Autor_assuntos
SET ideia = 'enfoque tecnico mais detalhado'
WHERE idAssuntoAutor = 1;

-- Atualizar genero de um assunto
UPDATE Assuntos
SET Genero = 'Tecnologico'
WHERE idAssuntos = 1;


-- SELECTS

-- Usuario com o nome que começa em A
SELECT * FROM Usuario
WHERE Nome LIKe 'a%';

-- Livro entre 2015 a 2021
SELECT * FROM Livros
WHERE Ano BETWEEN 2015 AND 2021;

-- VER editoras especificas 
SELECT * FROM Editora 
WHERE idEditora IN ( 1,3,5); -- entre

-- Usuario não Ta nesses endereços
SELECT Nome , Email FROM Usuario
WHERE Endereco_idEndereco NOT IN ( 1,3);

-- Buscar Autores que contém 'a'
SELECT * FROM  Autor
WHERE Nome LIKE '%a%';

-- Buscar cidades com Cep entre dois valores
SELECT * FROM Cidades
WHERE CEP BETWEEN '01000-000' AND '70000-000';

SELECT id, Livros FROM Livros
WHERE idLivros IN (1 ,2 , 5)
ORDER BY TITULO ASC;


-- Seleciona Pesosas ordendando alfabeticamente 
SELECT Nome , Email FROM Usuario
ORDER BY NOME ASC;

-- Ver Genero que não é academico
SELECT * FROM Assuntos
WHERE Genero NOT IN ('academico');

-- Buscar emprestimo datas
SELECT * FROM Emprestimo
WHERE DataEmprestimo BETWEEN '2025-02-01' AND '2025-04-30';

-- SELECT COM GROUP BY , INNER

-- QUANTIDADE DE LIVRO POR EDITORA
-- SELECT Editora.NomeEditora , COUNT(Livros.idLivros) AS TotalLivros
-- fROM livros
-- INNER JOIN Editora ON Livros.Editora_idEditora = Editora.idEditora
-- GROUP BY Editora.NomeEditora;


-- QUANTIDADE DE EMPRESTIMO POR CADA USUARIO
-- SELECT Usuario.nome , COUNT (Emprestimo.idEmprestimo) AS TOTAL EMPRESTIMO
-- FROM Emprestimo
-- INNTER JOIN Usuario ON Emprestimo.idEmprestimo = Usuario.idUsuario
-- GROUP BY Usuario.nome;


-- QUANTIDADE DE LIVROS EMPRESTADOS EM CADA EMPRESTIMO
-- SELECT Emprestimo_idEMprestimo AS Emprestimo , SUM(Quantidade AS LivrosTOTAIS
-- FROM Empresitmo_Livros
-- GROUP BY Emprestimo_idEmprestimo;

-- QUANTIDADE DE AUTORES POR ASSUNTO
-- SELECT Assuntos.Descricao AS Assunto , COUNT(Autor_Assuntos.idAutor) AS TotalAutores
-- FROM Autor_Assuntos
-- INNTER JOIN Assuntos ON Autor_Assuntos.idAssuntos = Assuntos.idAssuntos
-- GROUP BY Assuntos.Descricao;


-- QUANTIDADE DE LIVROS POR CADA ASSUNTO
-- SELECT Assuntos.Descricao AS Assunto, COUNT(Livros_Assuntos.idLivrosAssunto) AS TotalLivros
-- FROM Livros_Assuntos
-- INNER JOIN Assuntos ON Livros_Assuntos.Assuntos_idAssuntos = Assuntos.idAssuntos
-- GROUP BY Assuntos.Descricao;

-- TOTAL DA MULTA DE CADA USER 
-- SELECT Usuario.Nome, SUM(Emprestimo.Multa) AS MultaTotal
-- FROM Emprestimo
-- INNER JOIN Usuario ON Emprestimo.Usuario_idUsuario = Usuario.idUsuario
-- GROUP BY Usuario.Nome;


-- USANDO INNER JOIN


-- livros e editora 
SELECT Livros.Titulo , Editora.NomeEditora
from livros
INNER JOIN Editora ON Livros.Editora_idEditora = Editora.idEditora;

-- Usuario + endereço + cidade
SELECT Usuario.nome , Endereco.rua , Cidade.nome as Cidade
FROM usuario
INNER JOIN Endereco ON Usuario.Endereco_idEndereco = Endereco.idEndereco
INNER JOIN Cidade on Endereco.cidade_idCidade = cidade.idCidade;

-- EMPRESTIMO + USUARIO quem fez cada emprestimo
SELECT Emprestimo.idEmprestimo, Usuario.Nome, Emprestimo.DataEmprestimo
FROM Emprestimo
INNER JOIN Usuario ON Emprestimo.Usuario_idUsuario = Usuario.idUsuario;

-- livros emprestados + titulo (N:N)
SELECT Emprestimo_Livros.Emprestimo_idEmprestimo, Livros.Titulo,
Emprestimo_Livros.Quantidade
FROM Emprestimo_Livros
INNER JOIN Livros ON Emprestimo_Livros.Livros_idLivros = Livros.idLivros;

-- Autores + Assuntos
SELECT Autor.Nome AS Autor, Assuntos.Descricao AS Assunto
FROM Autor_Assuntos
INNER JOIN Autor ON Autor_Assuntos.idAutor = Autor.idAutor
INNER JOIN Assuntos ON Autor_Assuntos.idAssuntos = Assuntos.idAssuntos;

-- Livros + assuntos
SELECT Autor.Nome AS Autor, Assuntos.Descricao AS Assunto
FROM Autor_Assuntos
INNER JOIN Autor ON Autor_Assuntos.idAutor = Autor.idAutor
INNER JOIN Assuntos ON Autor_Assuntos.idAssuntos = Assuntos.idAssuntos;

