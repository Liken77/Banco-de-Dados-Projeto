USE biblioteca;

-- 1. Livros com suas editoras.
SELECT
    l.id_livro,
    l.titulo,
    l.ano_publicacao,
    e.nome AS editora
FROM livro AS l
LEFT JOIN editora AS e ON e.id_editora = l.id_editora
ORDER BY l.titulo;

-- 2. Livros e seus autores.
SELECT
    l.titulo,
    a.nome AS autor
FROM livro AS l
INNER JOIN livro_autor AS la ON la.id_livro = l.id_livro
INNER JOIN autor AS a ON a.id_autor = la.id_autor
ORDER BY l.titulo, a.nome;

-- 3. Usuários com endereço completo.
SELECT
    u.nome AS usuario,
    u.email,
    CONCAT(e.rua, ', ', e.numero) AS endereco,
    e.cep,
    c.nome AS cidade,
    c.estado
FROM usuario AS u
INNER JOIN endereco AS e ON e.id_endereco = u.id_endereco
INNER JOIN cidade AS c ON c.id_cidade = e.id_cidade
ORDER BY u.nome;

-- 4. Exemplares e situação atual.
SELECT
    ex.codigo_tombo,
    l.titulo,
    ex.status,
    ex.data_aquisicao
FROM exemplar AS ex
INNER JOIN livro AS l ON l.id_livro = ex.id_livro
ORDER BY l.titulo, ex.codigo_tombo;

-- 5. Empréstimos e seus usuários.
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

-- 6. Quantidade de exemplares em cada empréstimo.
SELECT
    emp.id_emprestimo,
    u.nome AS usuario,
    COUNT(ee.id_exemplar) AS total_exemplares
FROM emprestimo AS emp
INNER JOIN usuario AS u ON u.id_usuario = emp.id_usuario
INNER JOIN emprestimo_exemplar AS ee ON ee.id_emprestimo = emp.id_emprestimo
GROUP BY emp.id_emprestimo, u.nome
ORDER BY emp.id_emprestimo;

-- 7. Disponibilidade do acervo por título.
SELECT
    l.titulo,
    COUNT(ex.id_exemplar) AS total_exemplares,
    COALESCE(SUM(ex.status = 'DISPONIVEL'), 0) AS disponiveis,
    COALESCE(SUM(ex.status = 'EMPRESTADO'), 0) AS emprestados
FROM livro AS l
LEFT JOIN exemplar AS ex ON ex.id_livro = l.id_livro
GROUP BY l.id_livro, l.titulo
ORDER BY l.titulo;

-- 8. Autores associados a cada assunto.
SELECT
    ass.descricao AS assunto,
    COUNT(DISTINCT la.id_autor) AS total_autores
FROM assunto AS ass
INNER JOIN livro_assunto AS ls ON ls.id_assunto = ass.id_assunto
INNER JOIN livro_autor AS la ON la.id_livro = ls.id_livro
GROUP BY ass.id_assunto, ass.descricao
ORDER BY total_autores DESC, ass.descricao;

-- 9. Total de multas por usuário.
SELECT
    u.nome AS usuario,
    COALESCE(SUM(emp.multa), 0) AS total_multas
FROM usuario AS u
LEFT JOIN emprestimo AS emp ON emp.id_usuario = u.id_usuario
GROUP BY u.id_usuario, u.nome
ORDER BY total_multas DESC, u.nome;

-- 10. Empréstimos ainda não devolvidos e status calculado pela data.
SELECT
    emp.id_emprestimo,
    u.nome AS usuario,
    emp.data_prevista,
    CASE
        WHEN emp.data_prevista < CURRENT_DATE THEN 'ATRASADO'
        ELSE emp.status
    END AS status_atual
FROM emprestimo AS emp
INNER JOIN usuario AS u ON u.id_usuario = emp.id_usuario
WHERE emp.data_devolucao IS NULL
ORDER BY emp.data_prevista;

-- 11. Busca de livros por assunto.
SELECT
    l.titulo,
    ass.descricao AS assunto,
    ls.nivel_relevancia
FROM livro AS l
INNER JOIN livro_assunto AS ls ON ls.id_livro = l.id_livro
INNER JOIN assunto AS ass ON ass.id_assunto = ls.id_assunto
WHERE ass.descricao = 'Tecnologia'
ORDER BY ls.nivel_relevancia DESC, l.titulo;
