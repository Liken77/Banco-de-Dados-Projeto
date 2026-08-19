USE biblioteca;

-- 1. Lista livros com suas editoras.
SELECT
    l.id_livro,
    l.titulo,
    l.ano_publicacao,
    e.nome AS editora
FROM livro AS l
LEFT JOIN editora AS e ON e.id_editora = l.id_editora
ORDER BY l.titulo;

-- 2. Lista livros e seus autores.
SELECT
    l.titulo,
    a.nome AS autor
FROM livro AS l
INNER JOIN livro_autor AS la ON la.id_livro = l.id_livro
INNER JOIN autor AS a ON a.id_autor = la.id_autor
ORDER BY l.titulo, a.nome;

-- 3. Lista usuários com endereço e cidade.
SELECT
    u.nome AS usuario,
    u.email,
    CONCAT(e.rua, ', ', e.numero) AS endereco,
    c.nome AS cidade,
    c.estado
FROM usuario AS u
INNER JOIN endereco AS e ON e.id_endereco = u.id_endereco
INNER JOIN cidade AS c ON c.id_cidade = e.id_cidade
ORDER BY u.nome;

-- 4. Mostra os empréstimos e seus respectivos usuários.
SELECT
    emp.id_emprestimo,
    u.nome AS usuario,
    emp.data_emprestimo,
    emp.data_prevista,
    emp.data_devolucao,
    emp.status,
    emp.multa
FROM emprestimo AS emp
INNER JOIN usuario AS u ON u.id_usuario = emp.id_usuario
ORDER BY emp.data_emprestimo DESC;

-- 5. Quantidade de livros vinculados a cada empréstimo.
SELECT
    emp.id_emprestimo,
    u.nome AS usuario,
    SUM(el.quantidade) AS total_livros
FROM emprestimo AS emp
INNER JOIN usuario AS u ON u.id_usuario = emp.id_usuario
INNER JOIN emprestimo_livro AS el ON el.id_emprestimo = emp.id_emprestimo
GROUP BY emp.id_emprestimo, u.nome
ORDER BY emp.id_emprestimo;

-- 6. Quantidade de livros publicados por editora.
SELECT
    e.nome AS editora,
    COUNT(l.id_livro) AS total_livros
FROM editora AS e
LEFT JOIN livro AS l ON l.id_editora = e.id_editora
GROUP BY e.id_editora, e.nome
ORDER BY total_livros DESC, e.nome;

-- 7. Quantidade de autores associados a cada assunto.
SELECT
    ass.descricao AS assunto,
    COUNT(DISTINCT la.id_autor) AS total_autores
FROM assunto AS ass
INNER JOIN livro_assunto AS ls ON ls.id_assunto = ass.id_assunto
INNER JOIN livro_autor AS la ON la.id_livro = ls.id_livro
GROUP BY ass.id_assunto, ass.descricao
ORDER BY total_autores DESC, ass.descricao;

-- 8. Total de multas por usuário.
SELECT
    u.nome AS usuario,
    COALESCE(SUM(emp.multa), 0) AS total_multas
FROM usuario AS u
LEFT JOIN emprestimo AS emp ON emp.id_usuario = u.id_usuario
GROUP BY u.id_usuario, u.nome
ORDER BY total_multas DESC, u.nome;

-- 9. Empréstimos ainda não devolvidos.
SELECT
    emp.id_emprestimo,
    u.nome AS usuario,
    emp.data_prevista,
    emp.status
FROM emprestimo AS emp
INNER JOIN usuario AS u ON u.id_usuario = emp.id_usuario
WHERE emp.data_devolucao IS NULL
ORDER BY emp.data_prevista;

-- 10. Busca livros por assunto.
SELECT
    l.titulo,
    ass.descricao AS assunto,
    ls.nivel_relevancia
FROM livro AS l
INNER JOIN livro_assunto AS ls ON ls.id_livro = l.id_livro
INNER JOIN assunto AS ass ON ass.id_assunto = ls.id_assunto
WHERE ass.descricao = 'Tecnologia'
ORDER BY ls.nivel_relevancia DESC, l.titulo;
