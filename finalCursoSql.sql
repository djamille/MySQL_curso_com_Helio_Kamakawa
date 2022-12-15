/*  Responda as questões:
01 - O que é JOIN? Quando é necessário?
	RESP: JOIN é a junção das tabelas. Necessário em consultas.

02 - Qual a sintaxe do JOIN? Maiúscula ou minúscula faz diferença? Existe algum padrão? Explique.
	RESP: Todo join deve possuir o comando SELECT (colunas que quero informação), FROM (tabelas onde estão as info) e opcionalmente o WHERE (quais resultados o usuário quer. Uma boa prática são comandos com letras maiusculas e valores com letras minusculas. SQL possue dois padrões: 89 e 92, mas que ao final da junção o resultado é sempre o mesmo. 

04 - O que é primordial para que o resultado tenha sentido em consultas com JOIN? Explique.
	RESP: Que as junções entre tabelas e colunas sejam feitas respeitando a condição de junção, senão ocorrerá um erro ou então a junção de informação será uma bagunça com resultados errados. E que seja feita a descrição completa da tabela/coluna para que o SQL possa entender a informação o usuário quer. 

05 - Existe mais de uma maneira de realizar o JOIN? Quantas? Qual é a mais eficiente? 
	RESP: Existem dois padrões, o SQL89 e SQL92. Os dois são igualmente eficientes.

06 - Para realizar o JOIN de 1523 tabelas, quantas comparações de junções são necessárias? Explique.
	RESP: Depende, pois as vezes serão necessárias 2, 3, 4 ou ate mais junçoes para obter o resultado da pesquisa

07 - O que é análise semântica e de sintaxe? Qual a diferença? Para que serve?
	RESP: 

08 - Em uma consulta com JOIN, há casos em que seja necessário atribuir o nome da tabela na projeção das colunas? Explique.
	RESP: Sim, pois é preciso saber de qual tabela se deseja a informação.

09 - De acordo com o estudo de caso, cite 4 exemplos em que seja possível utilizar o JOIN e 3 exemplos que não seja possível realizar o JOIN.
	RESP:  Exemplos de onde é possivel utilizar o join:
    1) Qual o estoque dos produtos da marca PEPSI?
    2) De que estados são os funcionários?
    3) Quais são as marcas dos produtos da linha ESPORTE E LAZER?
    4) Quais foram os produtos que cada funcionário deu baixa?
    
    Exemplos de onde não é possivel realizar o join:
    1)Não é possível fazer o join entre as tabelas ESTADO e MARCA.
    2)Não é possível fazer o join entre as tabelas CIDADE e CAIXA.
    3)Não é possível fazer o join entre as tabelas CLIENTE E PAGAMENTO.

*/

Conforme o estudo de caso, elabore as consultas solicitadas abaixo:
Link do DER: https://github.com/heliokamakawa/curso_bd/blob/master/00-estudo%20de%20caso%20loja%20-%20DER.png
Link do script: https://github.com/heliokamakawa/curso_bd/blob/master/00-estudo%20de%20caso%20%20loja%20-script.sql
obs: Para cada questão utilize o padrão SQL89 e SQL92

-------------------------------------------------------------------------------
01 - Liste o id e o nome de todas as cidades e as respectivas siglas do estado.
-------------------------------------------------------------------------------
    -- Padrão SQL 89
SELECT 
	cidade.id
    ,cidade.nome
    ,estado.sigla
FROM estado, cidade;


-- Padrão SQL 92 
SELECT 
	cidade.id
    ,cidade.nome
    ,estado.sigla
FROM cidade
INNER JOIN estado;


----------------------------------------------------------------------------------------------------------------------------------------------
02 - Em relação ao resultado do exercício anterior,note que os nomes das colunas não estão claras. Refaça o comando para que torne mais claras.
----------------------------------------------------------------------------------------------------------------------------------------------
    -- Padrão SQL 89 
SELECT 
	cidade.id
    ,cidade.nome
    ,estado.sigla
FROM cidade, estado
WHERE cidade.estado_id = estado.id;


-- Padrão SQL 92   
SELECT 
	cidade.id
    ,cidade.nome
    ,estado.sigla
FROM cidade
INNER JOIN estado 
ON cidade.estado_id = estado.id;


---------------------------------------------------------------------------------------------
03 - Refaça o exercício anterior atribuindo o nome completo da tabela em todos os atributos.
---------------------------------------------------------------------------------------------
    -- Padrão SQL 89     
SELECT 
	cidade.id
    ,cidade.nome
    ,cidade.status
    ,cidade.data_cadastro
    ,cidade.estado_id 
	,estado.id
    ,estado.nome
    ,estado.sigla
    ,estado.status
    ,estado.data_cadastro
FROM cidade, estado
WHERE cidade.estado_id = estado.id;


-- Padrão SQL 92   
SELECT 
	cidade.id
    ,cidade.nome
    ,cidade.status
    ,cidade.data_cadastro
    ,cidade.estado_id 
	,estado.id
    ,estado.nome
    ,estado.sigla
    ,estado.status
    ,estado.data_cadastro
FROM cidade
INNER JOIN estado 
ON cidade.estado_id = estado.id;


----------------------------------------------------------------
04 - Refaça o exercício anterior definindo o apelido na tabela.
----------------------------------------------------------------
    -- Padrão SQL 89     
SELECT 
	c.id
    ,c.nome 
    ,c.status 
    ,c.data_cadastro
    ,c.estado_id
	,e.id
    ,e.nome
    ,e.sigla
    ,e.status
    ,e.data_cadastro
FROM cidade AS c, estado AS e
WHERE c.estado_id = e.id;


-- Padrão SQL 92     
SELECT 
	c.id
    ,c.nome 
    ,c.status 
    ,c.data_cadastro
    ,c.estado_id
	,e.id
    ,e.nome
    ,e.sigla
    ,e.status
    ,e.data_cadastro
FROM cidade AS c
INNER JOIN estado AS e 
ON c.estado_id = e.id;


-------------------------------------------------------------------------------------------
05 - Explique a diferença entre o exercício 03 e 04. Qual é a melhor? Qual devemos estudar?
-------------------------------------------------------------------------------------------
	RESP No exercício 03 as tabelas e colunas estão com nome completo, já no exercício 04 temos as tabelas e colunas com apelido definido pelo usuário.
	   Ao utilizar apelidos, as consultas se tornam mais ageis/rápidas, pois você não precisa "perder tempo" digitando tanta informação.
       As duas alternativas estão certas, deve-se ter conhecimento das duas, mas acho que vai mais da escolha do usuário que estará utilizando optar por que achar melhor.
    

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
06 - Quantos registros foram gerados no resultado do exercício 02? O comando do exercício anterior pode ser utilizado para descobrir as cidades da região sul? Justifique/explique o que ocorre.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
	 RESP Foram gerados o número máximo para consultas, 1000 registros.
    Os estados não possuem registro de região, logo não se pode realizar consulta por região. A não ser que o usuário saiba quais são os estados que façam parte da região em questão e pesquise estado por estado.
    
    
--------------------------------------------------------------------------------------------
07 - Liste o id e o nome de todas as cidades e as respectivas siglas do estado de São Paulo
--------------------------------------------------------------------------------------------
Professor Hélio, ha um erro no BD no cadastro de cidade/estado. Foram trocados as cidades de Sergipe pelas cidades de São Paulo.
Se der um select from dos estados verá o id de SAO PAULO e SERGIPE. A cidade de Guarulhos e Araraquara são de SP.


-- Padrão SQL 89
SELECT      --  Cidades de São Paulo
	cidade.id
    ,cidade.nome
    ,estado.sigla
FROM cidade, estado
WHERE cidade.estado_id = estado.id
AND estado.sigla = 'SE';

SELECT    -- Cidades de Sergipe
	cidade.id
    ,cidade.nome
    ,estado.sigla
FROM cidade, estado
WHERE cidade.estado_id = estado.id
AND estado.sigla = 'SP';



-- Padrão SQL 92
SELECT     --  Cidades de Sergipe
	cidade.id
    ,cidade.nome
    ,estado.sigla
FROM cidade
INNER JOIN estado 
ON cidade.estado_id = estado.id
WHERE estado.sigla = 'SP';

SELECT   -- Cidades de São Paulo
	c.id
    ,c.nome
    ,e.sigla
FROM cidade c
JOIN estado e
ON c.estado_id = e.id
WHERE e.sigla = 'SE';


-------------------------------------------------------------------------------------------------
08 - Liste o id e o nome de todas as cidades da região sudeste e as respectivas siglas do estado.   
-------------------------------------------------------------------------------------------------
Professor, as cidades não estão de acordo com os estados. Os ID's corretos são: RJ=21, MG=13, SP=25, mas estão cadastrados com os ID's  RJ=19, MG=11, SP=26. SOMENTE Espirito Santo esta correto.

-- Padrão SQL 89
SELECT
    estado.sigla
    ,cidade.id
    ,cidade.nome
FROM cidade,estado
WHERE cidade.estado_id = estado.id
AND estado.sigla IN ('RJ','MG','SP','ES');


-- Padrão SQL 92
SELECT
    estado.sigla
    ,cidade.id
    ,cidade.nome
FROM cidade
INNER JOIN estado 
ON cidade.estado_id = estado.id
WHERE estado.sigla IN ('RJ','MG','SP','ES');

---------------------------------------------------------------------------
09 - Escreva a consulta que liste o nome dos Funcionários do estado Paraná. 
---------------------------------------------------------------------------
-- Padrão SQL 89
SELECT
	f.nome
FROM funcionario f, cidade c, estado e
WHERE f.cidade_id = c.id
AND c.estado_id = e.id
AND e.sigla = 'PR';


-- Padrão SQL 92
SELECT
	f.nome
FROM funcionario f
LEFT JOIN cidade c
ON f.cidade_id = c.id
JOIN estado e
ON c.estado_id = e.id
WHERE e.sigla = 'PR';

----------------------------------------------------------------------------------------------
10 - Escreva a consulta que liste o nome e o telefone dos Fornecedores da cidade de São Paulo.  
----------------------------------------------------------------------------------------------
-- Estão cadastradas quatro cidades com nome SAO PAULO em diferentes estados e nenhuma tem fornecedor

-- Padrão SQL 89
SELECT
	f.nome 'FORNECEDOR'
    ,f.fone 'FONE'
    ,c.nome 'CIDADE'
    ,c.id
FROM fornecedor f, cidade c
WHERE f.cidade_id = c.id
AND c.nome = 'SÃO PAULO';


-- Padrão SQL 92
SELECT
	f.nome 'FORNECEDOR'
    ,f.fone 'FONE'
    ,c.nome 'CIDADE'
    ,c.id
FROM fornecedor f
JOIN cidade c
ON f.cidade_id = c.id
WHERE c.nome = 'SAO PAULO';

-----------------------------------------------------------------------------------------
-- 11 - Liste os produtos da categoria BEBEIDA NÃO ALCÓOLICA e da linha ALIMENTOS E BEBIDAS.  
-----------------------------------------------------------------------------------------
-- Padrão SQL 89
SELECT p.nome 'PRODUTO', l.nome 'LINHA', c.nome 'CATEGORIA'
FROM linha l, linha_categoria lc, categoria c, produto_categoria pc, produto p
WHERE lc.linha_id = l.id
AND lc.categoria_id = c.id
AND pc.categoria_id = c.id
AND pc.produto_id = p.id
AND c.nome = 'BEBIDA NÃO ALCOÓLICA'
AND l.nome = 'ALIMENTOS E BEBIDAS';


-- Padrão SQL 92
SELECT
	p.nome 'PRODUTO'
    ,l.nome 'LINHA'
    ,c.nome 'CATEGORIA'
FROM linha l
JOIN linha_categoria lc
ON lc.linha_id = l.id
JOIN categoria c
ON lc.categoria_id = c.id
JOIN produto_categoria pc
ON pc.categoria_id = c.id
JOIN produto p
ON pc.produto_id = p.id
WHERE c.nome = 'BEBIDA NÃO ALCOÓLICA' AND l.nome = 'ALIMENTOS E BEBIDAS';

---------------------------------------------------------------------
12 - Liste os produtos que possuem a unidade de medida em QUILOGRAMA.  
---------------------------------------------------------------------
 -- Não exitem produtos cadastrados com a unidade de medida QUILOGRAMA
 
-- Padrão SQL 89
SELECT
	p.nome
    ,um.nome
FROM produto p, umedida um
WHERE p.umedida_id = um.id
AND um.nome = 'QUILOGRAMA';


-- Padrão SQL 92
SELECT
	p.nome
    ,um.nome
FROM produto p
JOIN umedida um
ON p.umedida_id = um.id
WHERE um.nome = 'QUILOGRAMA';


-----------------------------------------------------------------------------------------
13 - Em qual categoria e linha pertence o produto REFRIGERANTE COCA-COLA GARRAFA PET 2 L? 
-----------------------------------------------------------------------------------------
 -- O produto REFRIGERANTE COCA-COLA GARRAFA PET 2 L esta localizado na linha ALIMENTOS E BEBIDAS e categoria BEBIDA NÃO ALCOÓLICA

-- Padrão SQL 89
SELECT l.nome 'LINHA', p.nome 'PRODUTO', c.nome 'CATEGORIA'
FROM linha l, linha_categoria lc, categoria c, produto_categoria pc, produto p
WHERE lc.linha_id = l.id
AND lc.categoria_id = c.id
AND pc.categoria_id = c.id
AND pc.produto_id = p.id
AND p.nome = 'REFRIGERANTE COCA-COLA GARRAFA PET 2 L';

-- Padrão SQL 92
SELECT
	l.nome 'LINHA'
    ,p.nome 'PRODUTO'
    ,c.nome 'CATEGORIA'
FROM linha l
JOIN linha_categoria lc
ON lc.linha_id = l.id
JOIN categoria c
ON lc.categoria_id = c.id
JOIN produto_categoria pc
ON pc.categoria_id = c.id
JOIN produto p
ON pc.produto_id = p.id
WHERE p.nome = 'REFRIGERANTE COCA-COLA GARRAFA PET 2 L';

----------------------------------------------------------
14 - Qual o nome da linha onde estão todos os refrigentes? 
-----------------------------------------------------------
-- Refrigerantes esta localizado na linha ALIMENTOS E BEBIDAS 

-- Padrão SQL 89
SELECT l.nome 'LINHA', p.nome 'PRODUTO'
FROM linha l, linha_categoria lc, categoria c, produto_categoria pc, produto p
WHERE lc.linha_id = l.id
AND lc.categoria_id = c.id
AND pc.categoria_id = c.id
AND pc.produto_id = p.id
AND p.nome LIKE 'REFRIGERANTE%';


-- Padrão SQL 92
SELECT
	l.nome 'LINHA'
    ,p.nome 'PRODUTO'
FROM linha l
JOIN linha_categoria lc
ON lc.linha_id = l.id
JOIN categoria c
ON lc.categoria_id = c.id
JOIN produto_categoria pc
ON pc.categoria_id = c.id
JOIN produto p
ON pc.produto_id = p.id
WHERE p.nome LIKE 'REFRIGERANTE%';

----------------------------------------------------------------------------------
15 - Qual o produto (preço de venda) mais caro da categoria BEBIDA NÃO ALCÓOLICA?  
----------------------------------------------------------------------------------

-- Padrão SQL 89
SELECT MAX(preco_venda)
FROM produto p, produto_categoria pc, categoria c
WHERE pc.produto_id = p.id
AND pc.categoria_id = c.id
AND c.nome = 'BEBIDA NÂO ALCOÓLICA';


-- Padrão SQL 92
SELECT
	MAX(preco_venda)
FROM produto p
JOIN produto_categoria pc
ON pc.produto_id = p.id
JOIN categoria c
ON pc.categoria_id = c.id
WHERE c.nome = 'BEBIDA NÂO ALCOÓLICA';

-----------------------------------------------------------------------
16 - Escreva o comando que apresente a quantidade de produtos líquidos?  
-----------------------------------------------------------------------

-- Padrão SQL 89
SELECT um.nome, COUNT(um.sigla) 'QTDE PROD LIQ'
FROM produto p, umedida um
WHERE p.umedida_id = um.id
AND um.sigla IN ('L', 'ML')
GROUP BY um.sigla;


-- Padrão SQL 92
SELECT um.nome, COUNT(um.sigla) 'QTDE PROD LIQ'
FROM produto p
JOIN umedida um
ON p.umedida_id = um.id
WHERE um.sigla IN ('L', 'ML')
GROUP BY um.sigla;

--------------------------------------------------------------------------------------------------------
17 - Escreva o comando que apresente a quantidade de BEBIDA ALCÓOLICA que estão cadastrados em produtos? 
--------------------------------------------------------------------------------------------------------

-- Padrão SQL 89
SELECT c.nome, COUNT(c.nome) 'QTDE BEBIDA ALCOÓLICA'
FROM produto p, produto_categoria pc, categoria c
WHERE pc.produto_id = p.id
AND pc.categoria_id = c.id
AND c.nome = 'BEBIDA ALCOÓLICA';


-- Padrão SQL 92
SELECT c.nome, COUNT(c.nome) 'QTDE BEBIDA ALCOÓLICA'
FROM produto p
JOIN produto_categoria pc
ON pc.produto_id = p.id
JOIN categoria c
ON pc.categoria_id = c.id
WHERE c.nome = 'BEBIDA ALCOÓLICA';
 
-----------------------------------------------------------------
18 - Escreva o comando que liste o nome dos Refrigerantes de 2 L?  
-----------------------------------------------------------------

-- Padrão SQL 89
SELECT p.nome
FROM linha l, linha_categoria lc, categoria c, produto_categoria pc, produto p
WHERE lc.linha_id = l.id
AND lc.categoria_id = c.id
AND pc.categoria_id = c.id
AND pc.produto_id = p.id
AND p.nome LIKE 'REFRIGERANTE%2 L%';


-- Padrão SQL 92
SELECT
	p.nome
FROM linha l
JOIN linha_categoria lc
ON lc.linha_id = l.id
JOIN categoria c
ON lc.categoria_id = c.id
JOIN produto_categoria pc
ON pc.categoria_id = c.id
JOIN produto p
ON pc.produto_id = p.id
WHERE p.nome LIKE 'REFRIGERANTE%2 L%';

----------------------------------------------------------------------------------------
19 - Escreva o comando que apresente a média do preço de venda dos Refrigerantes de 2 L?
----------------------------------------------------------------------------------------

-- Padrão SQL 89
SELECT AVG(preco_venda)
FROM linha l, linha_categoria lc, categoria c, produto_categoria pc, produto p
WHERE lc.linha_id = l.id
AND lc.categoria_id = c.id
AND pc.categoria_id = c.id
AND pc.produto_id = p.id
AND p.nome LIKE 'REFRIGERANTE%2 L%';


-- Padrão SQL 92
SELECT
	AVG(preco_venda)
FROM linha l
JOIN linha_categoria lc
ON lc.linha_id = l.id
JOIN categoria c
ON lc.categoria_id = c.id
JOIN produto_categoria pc
ON pc.categoria_id = c.id
JOIN produto p
ON pc.produto_id = p.id
WHERE p.nome LIKE 'REFRIGERANTE%2 L%';
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
20 - Com base do estudo de caso, elabore um exercício de sua autoria que envolva pelo menos 3 tabelas, no qual, o resultado possa ajudar o usuário. Em seguida resolva o exercício elaborado.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VOU ABRIR UMA LOJA DE MATERIAIS DE CONSTRUÇÃO E GOSTARIA DE SABER QUAIS FORNECEDORES PODEM ME VENDER PRODUTOS DA LINHA 'CONSTRUÇÃO E FERRAMENTAS'

-- Padrão SQL 89
SELECT f.nome 'FORNECEDOR', l.nome 'LINHA'
FROM fornecedor f, compra c, icompra ic, produto p, produto_categoria pc, categoria ct, linha_categoria lc, linha l
WHERE f.id = c.fornecedor_id
AND ic.compra_id = c.id
AND ic.produto_id = p.id
AND pc.produto_id = p.id
AND pc.categoria_id = ct.id
AND lc.categoria_id = ct.id
AND lc.linha_id = l.id
AND l.nome = 'CONSTRUÇÃO E FERRAMENTAS';


-- Padrão SQL 92
SELECT 
	f.nome 'FORNECEDOR'
    ,l.nome 'LINHA'
FROM fornecedor f
JOIN compra c
ON f.id = c.fornecedor_id
JOIN icompra ic
ON ic.compra_id = c.id
JOIN produto p
ON ic.produto_id = p.id
JOIN produto_categoria pc
ON pc.produto_id = p.id
JOIN categoria ct
ON pc.categoria_id = ct.id
JOIN linha_categoria lc
ON lc.categoria_id = ct.id
JOIN linha l
ON lc.linha_id = l.id
WHERE l.nome = 'CONSTRUÇÃO E FERRAMENTAS';
*/