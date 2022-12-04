-- EXERCÍCIOS 

-----------------------------------------------
-- SELECT
-----------------------------------------------
-- Escreva o comando para seleccionar todos os registros da tabela cidade com todas as colunas.
SELECT * FROM cidade;
DESC cidade;

-- Escreva o comando para seleccionar o nome de todos os registros da tabela cidade.
SELECT id, nome, ativo, data_cadastro, estado_id FROM cidade;

-- Escreva o comando para seleccionar o nome de todos os registros da tabela cidade.  Associe a tabela nas definições das colunas.
SELECT
	cidade.id
	,cidade.nome
    ,cidade.ativo
    ,cidade.data_cadastro
    ,cidade.estado_id
FROM
	cidade;

----------------------------------------------------
-- DELETE e UPDATE
---------------------------------------------------

-- Escreva o comando para alterar o valor de uma coluna de um único registro de uma tabela utilizando como filtro, o Primary Key.
UPDATE cidade SET nome = 'BLUMENAU' WHERE id = 13;

-- Refaça o exercício anterior alterando os dados de mais que uma coluna de um único registro sem utilizar como filtro a chave primária. A escolha da coluna do filtro é muito importante – TOME CUIDADO.
UPDATE estado SET nome = 'SANTA E BELA CATARINA' WHERE nome = 'SANTA CATARINA';

-- Altere o valor de uma coluna de todos os registros.
UPDATE cidade SET  ativo = 'N';

-- Exclua um único registro de uma tabela sem utilizar como filtro, a chave primária.
DELETE FROM cidade WHERE id=15;

SELECT * FROM estado;

----------------------------------------------------
-- INSERT
---------------------------------------------------

-- Escreva o comando para inserir 3 registros da tabela estado com todas as colunas.
INSERT INTO estado VALUES (NULL, 'MINAS GERAIS', 'MG', 'S', '2022-12-04');
INSERT INTO estado VALUES (NULL, 'MATO GROSSO DO SUL', 'MS', 'S', '2022-12-04');
INSERT INTO estado VALUES (NULL, 'RIO DE JANEIRO', 'RJ', 'S', '2022-12-04');

-- Escreva o comando para inserir 2 registros da tabela estado, definindo todos os dados, exceto a chave  primária que é auto incremento. 
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('RONDÔNIA', 'RO', 'S', '2022-12-04');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('RORAIMA', 'RR', 'S', '2022-12-04');

-- Escreva o comando para inserir 2 registros da tabela estado, definindo somente os dados necessários. 
INSERT INTO estado (nome, sigla) VALUES ('GOIÁS', 'GO');
INSERT INTO estado (nome, sigla) VALUES ('PERNAMBUCO', 'PE');
