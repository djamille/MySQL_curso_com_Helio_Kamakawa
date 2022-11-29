/**
Aula 05 - fomrulario #06  Banco Dados Professor Helio Kamakawa
*/
DROP DATABASE IF EXISTS empresa_sinalizacao; -- eliminando base de dados caso exista

CREATE DATABASE empresa_sinalizacao; -- criando a base de dados

USE empresa_sinalizacao; -- selecionando a base em que será trabalhado

CREATE TABLE IF NOT EXISTS estado(
id INT NOT NULL AUTO_INCREMENT -- CONSTRAINT INLINE  regras definidas na mesma linha - sem nome
,nome VARCHAR(200) NOT NULL UNIQUE
,sigla CHAR(2) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
-- ,CHECK (ativo IN ('S', 'N'))
,CONSTRAINT pk_estado PRIMARY KEY (id)
,CONSTRAINT estado_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))  -- CONSTRAINT OUT OF LINE  regras definidas fora da linha - com nome
);

CREATE TABLE IF NOT EXISTS cidade(
id INT NOT NULL AUTO_INCREMENT 
,nome VARCHAR(200) NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,estado_id INT NOT NULL
,CONSTRAINT pk_cidade PRIMARY KEY (id)
,CONSTRAINT fk_cidade_estado FOREIGN KEY (estado_id) REFERENCES estado (id)
,CONSTRAINT cidade_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
,CONSTRAINT cidade_unica UNIQUE(nome, estado_id)
);

CREATE TABLE IF NOT EXISTS departamento(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(100) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_departamento PRIMARY KEY (id)
,CONSTRAINT departamento_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

CREATE TABLE IF NOT EXISTS funcionario(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE
,CPF VARCHAR(14) NOT NULL UNIQUE
,endereço  VARCHAR(200) NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,cidade_id INT NOT NULL
,departamento_id INT NOT NULL
,CONSTRAINT pk_funcionario PRIMARY KEY (id)
,CONSTRAINT fk_funcionario_cidade FOREIGN KEY (cidade_id) REFERENCES cidade (id)
,CONSTRAINT fk_funcionario_departamento FOREIGN KEY (departamento_id) REFERENCES departamento (id)
,CONSTRAINT funcionario_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

CREATE TABLE IF NOT EXISTS cliente(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE
,razao_social VARCHAR(200) NOT NULL UNIQUE
,CNPJ_CPF VARCHAR(18) NOT NULL UNIQUE
,endereço  VARCHAR(200) NOT NULL
,telefone VARCHAR(14) NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,cidade_id INT NOT NULL
,CONSTRAINT pk_cliente PRIMARY KEY (id)
,CONSTRAINT fk_cliente_cidade FOREIGN KEY (cidade_id) REFERENCES cidade (id)
,CONSTRAINT cliente_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

CREATE TABLE IF NOT EXISTS fornecedor(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE
,razao_social VARCHAR(200) NOT NULL UNIQUE
,CNPJ_CPF VARCHAR(18) NOT NULL UNIQUE
,endereço  VARCHAR(200) NOT NULL
,telefone VARCHAR(14) NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,cidade_id INT NOT NULL
,CONSTRAINT pk_fornecedor PRIMARY KEY (id)
,CONSTRAINT fk_fornecedor_cidade FOREIGN KEY (cidade_id) REFERENCES cidade (id)
,CONSTRAINT fornecedor_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

CREATE TABLE IF NOT EXISTS motorista(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE
,CPF VARCHAR(14) NOT NULL UNIQUE
,endereço  VARCHAR(200) NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,cidade_id INT NOT NULL
,departamento_id INT NOT NULL
,CONSTRAINT pk_motorista PRIMARY KEY (id)
,CONSTRAINT fk_motorista_cidade FOREIGN KEY (cidade_id) REFERENCES cidade (id)
,CONSTRAINT fk_motorista_departamento FOREIGN KEY (departamento_id) REFERENCES departamento (id)
,CONSTRAINT motorista_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

CREATE TABLE IF NOT EXISTS engenheiro(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(200) NOT NULL UNIQUE
,CPF VARCHAR(14) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_engenheiro PRIMARY KEY (id)
,CONSTRAINT engenheiro_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

CREATE TABLE IF NOT EXISTS caminhao(
id INT NOT NULL AUTO_INCREMENT
,placa VARCHAR(7) NOT NULL UNIQUE
,apelido VARCHAR(40) NOT NULL UNIQUE
,tara INT NOT NULL
,lotacao INT NOT NULL
,peso_bruto INT NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,motorista_id INT NOT NULL
,estado_id INT NOT NULL
,CONSTRAINT pk_caminhao PRIMARY KEY (id)
,CONSTRAINT fk_caminhao_motorista FOREIGN KEY (motorista_id) REFERENCES motorista (id)
,CONSTRAINT fk_caminhao_estado FOREIGN KEY (estado_id) REFERENCES estado (id)
,CONSTRAINT caminhao_ativo_deve_ser_S_ou_N CHECK (ativo IN ('S', 'N'))
);

CREATE TABLE IF NOT EXISTS fabrica(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(45) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_fabrica PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS Produto(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(100) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,preco_atual FLOAT NOT NULL
,estoque INT NOT NULL
,fabrica_id INT NOT NULL
,CONSTRAINT pk_produto PRIMARY KEY (id)
,CONSTRAINT fk_produto_fabrica FOREIGN KEY (fabrica_id) REFERENCES fabrica (id)
);

CREATE TABLE IF NOT EXISTS venda(
id INT NOT NULL AUTO_INCREMENT
,desconto INT NOT NULL
,total_com_desconto FLOAT NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,cliente_id INT NOT NULL
,funcionario_id INT NOT NULL
,CONSTRAINT pk_venda PRIMARY KEY (id)
,CONSTRAINT fk_venda_cliente FOREIGN KEY (cliente_id) REFERENCES cliente (id)
,CONSTRAINT fk_venda_funcionario FOREIGN KEY (funcionario_id) REFERENCES funcionario (id)
);

CREATE TABLE IF NOT EXISTS compra(
id INT NOT NULL AUTO_INCREMENT
,desconto INT NOT NULL
,total_com_desconto FLOAT NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,fornecedor_id INT NOT NULL
,funcionario_id INT NOT NULL
,CONSTRAINT pk_compra PRIMARY KEY (id)
,CONSTRAINT fk_compra_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedor (id)
,CONSTRAINT fk_compra_funcionario FOREIGN KEY (funcionario_id) REFERENCES funcionario (id)
);

CREATE TABLE IF NOT EXISTS obra(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(45) NOT NULL UNIQUE
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,engenheiro_id INT NOT NULL
,venda_id INT NOT NULL
,CONSTRAINT pk_obra PRIMARY KEY (id)
,CONSTRAINT fk_obra_venda FOREIGN KEY (venda_id) REFERENCES venda (id)
,CONSTRAINT fk_obra_engenheiro FOREIGN KEY (engenheiro_id) REFERENCES engenheiro (id)
);

CREATE TABLE IF NOT EXISTS itens_compra(
quantidade INT NOT NULL
,preco FLOAT NOT NULL
,compra_id INT NOT NULL
,produto_id INT NOT NULL
,CONSTRAINT fk_itens_compra_compra FOREIGN KEY (compra_id) REFERENCES compra(id)
,CONSTRAINT fk_itens_compra_produto FOREIGN KEY (produto_id) REFERENCES produto(id)
);

CREATE TABLE IF NOT EXISTS itens_venda(
quantidade INT NOT NULL
,preco FLOAT NOT NULL
,venda_id INT NOT NULL
,produto_id INT NOT NULL
,CONSTRAINT fk_itens_venda_venda FOREIGN KEY (venda_id) REFERENCES venda(id)
,CONSTRAINT fk_itens_venda_produto FOREIGN KEY (produto_id) REFERENCES produto(id)
);

CREATE TABLE IF NOT EXISTS itens_obra(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(45) NOT NULL UNIQUE
,endereço VARCHAR(200) NOT NULL
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
,caminhao_id INT NOT NULL
,funcionario_id INT NOT NULL
,obra_id INT NOT NULL
,cidade_id INT NOT NULL
,produto_id INT NOT NULL
,CONSTRAINT pk_itens_obra PRIMARY KEY (id)
,CONSTRAINT fk_itens_obra_caminhao FOREIGN KEY (caminhao_id) REFERENCES caminhao (id)
,CONSTRAINT fk_itens_obra_funcionario FOREIGN KEY (funcionario_id) REFERENCES funcionario (id)
,CONSTRAINT fk_itens_obra_obra FOREIGN KEY (obra_id) REFERENCES obra (id)
,CONSTRAINT fk_itens_obra_produto FOREIGN KEY (produto_id) REFERENCES produto (id)
,CONSTRAINT fk_itens_obra_cidade FOREIGN KEY (cidade_id) REFERENCES cidade (id)
);

CREATE TABLE IF NOT EXISTS recebimento(
id INT NOT NULL AUTO_INCREMENT
,condicao VARCHAR(45) NOT NULL
,valor FLOAT(45) NOT NULL
,numero_da_parcela INT NOT NULL
,desconto VARCHAR(4) NOT NULL
,juros VARCHAR(4) NOT NULL
,total_final FLOAT NOT NULL
,venda_id INT NOT NULL
,CONSTRAINT pk_recebimento PRIMARY KEY (id)
,CONSTRAINT fk_recebimento_venda FOREIGN KEY (venda_id) REFERENCES venda (id)
);

ALTER TABLE recebimento MODIFY COLUMN valor INT NOT NULL;
ALTER TABLE recebimento MODIFY COLUMN valor FLOAT NOT NULL;
ALTER TABLE recebimento MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT;

CREATE TABLE IF NOT EXISTS pagamento(
id INT NOT NULL AUTO_INCREMENT
,condicao VARCHAR(45) NOT NULL
,valor VARCHAR(45) NOT NULL
,numero_da_parcela INT NOT NULL
,desconto VARCHAR(4) NOT NULL
,juros VARCHAR(45) NOT NULL
,total_final FLOAT NOT NULL
,compra_id INT NOT NULL
,CONSTRAINT pk_pagamento PRIMARY KEY (id)
,CONSTRAINT fk_pagamento_compra FOREIGN KEY (compra_id) REFERENCES compra (id)
);

CREATE TABLE IF NOT EXISTS caixa(
id INT NOT NULL AUTO_INCREMENT
,data_operacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,condicao VARCHAR(45) NOT NULL
,saldo FLOAT NOT NULL
,funcionario_id INT NOT NULL
,CONSTRAINT pk_caixa PRIMARY KEY (id)
,CONSTRAINT fk_caixa_funcionario FOREIGN KEY (funcionario_id) REFERENCES funcionario (id)
);

CREATE TABLE IF NOT EXISTS item_caixa_pagamento(
id INT NOT NULL AUTO_INCREMENT
,descricao VARCHAR(50)
,valor FLOAT NOT NULL
,natureza VARCHAR(45)
,caixa_id INT NOT NULL
,pagamento_id INT NOT NULL
,CONSTRAINT pk_item_caixa_pagamento PRIMARY KEY (id)
,CONSTRAINT fk_item_caixa_pagamento_caixa FOREIGN KEY (caixa_id) REFERENCES caixa (id)
,CONSTRAINT fk_item_caixa_pagamento_pagamento FOREIGN KEY (pagamento_id) REFERENCES pagamento (id)
);

CREATE TABLE IF NOT EXISTS item_caixa_recebimento(
id INT NOT NULL AUTO_INCREMENT
,descricao VARCHAR(50)
,valor FLOAT NOT NULL
,natureza VARCHAR(45)
,caixa_id INT NOT NULL
,recebimento_id INT NOT NULL
,CONSTRAINT pk_item_caixa_recebimento PRIMARY KEY (id)
,CONSTRAINT fk_item_caixa_recebimento_caixa FOREIGN KEY (caixa_id) REFERENCES caixa (id)
,CONSTRAINT fk_item_caixa_recebimento_recebimento FOREIGN KEY (recebimento_id) REFERENCES recebimento (id)
);

CREATE TABLE IF NOT EXISTS item_caixa_pagamento(
id INT NOT NULL AUTO_INCREMENT
,descricao VARCHAR(50) NOT NULL
,valor FLOAT NOT NULL
,natureza VARCHAR(45)
,caixa_id INT NOT NULL
,pagamento_id INT NOT NULL
,CONSTRAINT pk_item_caixa_pagamento PRIMARY KEY (id)
,CONSTRAINT fk_item_caixa_pagamento_caixa FOREIGN KEY (caixa_id) REFERENCES caixa (id)
,CONSTRAINT fk_item_caixa_pagamento_pagamento FOREIGN KEY (pagamento_id) REFERENCES pagamento (id)
);
-- inserindo estados 
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('PARANÁ','PR','S','2015-2-25');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('SÃO PAULO','SP','S','2015-10-31');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('MATO GROSSO','MT','N','2015-12-02');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('SANTA CATARINA','SC','S','2016-08-13');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('RIO GRANDE DO SUL','RS','N','2016-08-30');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('ACRE','AC','N','2017-01-22');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('TOCANTINS','TO','S','2018-03-01');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('ALAGOAS','AL','N','2018-04-25');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('SERGIPE','SE','N','2019-03-12');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('PARÁ','PA','S','2019-03-15');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('RORAIMA','RR','S','2019-04-04');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('DISTRITO FEDERAL','DF','N','2019-10-26');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('BAHIA','BA','N','2020-4-03');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('PIAUÍ','PI','S','2020-6-13');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('ESPÍRITO SANTO','ES','N','2020-6-15');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('RIO DE JANEIRO','RJ','S','2020-7-18');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('MARANHÃO','MA','S','2020-8-22');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('CEARÁ','CE','S','2020-9-16');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('RIO GRANDE DO NORTE','RN','N','2020-9-20');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('GOIÁS','GO','S','2020-10-19'); 

-- inserindo cidades 
INSERT INTO cidade (nome, estado_id) VALUES ('BAURU',2); 
INSERT INTO cidade (nome, estado_id) VALUES ('MARINGÁ',1); 
INSERT INTO cidade (nome, estado_id) VALUES ('GUARULHOS',2); 
INSERT INTO cidade (nome, estado_id) VALUES ('CAMPINAS',2); 
INSERT INTO cidade (nome, estado_id) VALUES ('FLORIANÓPOLIS',4); 
INSERT INTO cidade (nome, estado_id) VALUES ('PARANAVAÍ',1); 
INSERT INTO cidade (nome, estado_id) VALUES ('CUIABA',3); 
INSERT INTO cidade (nome, estado_id) VALUES ('BALNEÁRIO CAMBORIÚ',4); 
INSERT INTO cidade (nome, estado_id) VALUES ('LONDRINA',1); 
INSERT INTO cidade (nome, estado_id) VALUES ('CASCAVEL',1); 
INSERT INTO cidade (nome, estado_id) VALUES ('JOINVILLE',4); 
INSERT INTO cidade (nome, estado_id) VALUES ('PORTO ALEGRE',5); 
INSERT INTO cidade (nome, estado_id) VALUES ('BLUMENAL',4); 
INSERT INTO cidade (nome, estado_id) VALUES ('BARRA DOS GARÇAS',3); 
INSERT INTO cidade (nome, estado_id) VALUES ('CHAPECÓ',4); 
INSERT INTO cidade (nome, estado_id) VALUES ('ITAJAÍ',4);


-- EXERCICIOS PROPOSTOS PELO PROFESSOR HELIO KAMAKAWA - aula 05 curso SQL - formulario #06

-- Escreva o comando para inserir 3 registros da tabela estado com todas as colunas. 
INSERT INTO estado (id, nome, sigla, ativo, data_cadastro) VALUES (NULL, 'PARAÍBA', 'PB', 'S', '2022-11-28');
INSERT INTO estado VALUES (NULL, 'PERNAMBUCO', 'PE', 'S', '2022-11-28');
INSERT INTO estado VALUES (NULL, 'RONDONIA', 'RO', 'S', '2022-11-28');

-- Escreva o comando para inserir 2 registros da tabela estado, definindo todos os dados, exceto a chave  primária que é auto incremento.
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('MATO GROSSO DO SUL','MS','S','2022-11-28');
INSERT INTO estado (nome, sigla, ativo, data_cadastro) VALUES ('MINAS GERAIS', 'MG', 'S', '2022-11-28');
 
-- Escreva o comando para inserir 2 registros da tabela estado, definindo somente os dados necessários. 
INSERT INTO estado (nome, sigla) VALUES ('AMAPÁ','AP');
INSERT INTO estado (nome, sigla) VALUES ('AMAZONAS','AM');

-- Escreva o comando para inserir registros da tabela cidade das 3 formas apresentadas nos exercícios  anteriores.
INSERT INTO cidade VALUES (NULL, 'PALHOÇA', 'S', '2022-11-28', '4');
INSERT INTO cidade (nome, ativo, data_cadastro, estado_id) VALUES  ('OSASCO', 'S', '2022-11-28', '2');
INSERT INTO cidade (nome, estado_id) VALUES ('ALEGRETE', '5');

-- Faça a inserção de 2 registros de cliente.
INSERT INTO cliente VALUES (NULL, 'PÃO DA MILLE', 'PADARIA E CONFEITARIA DJAMILLE LTDA', '47.258.369/0001-00', 'AVENIDA ANICETO ZACCHI, 68 - PONTE DO IMARUIM', '(48) 1111-1111', DEFAULT, DEFAULT, '19');
INSERT INTO cliente VALUES (NULL, 'MARIA JOSÉ SOUZA', 'MARIA JOSÉ SOUZA', '111.111.111-12', 'AVENIDA MAURO RAMOS, S/N - CENTRO', '(48)99999-8888', DEFAULT, DEFAULT, '5');
INSERT INTO cliente VALUES (NULL, 'PREFEITURA DE ALEGRETE', 'PREFEITURA DE ALEGRETE', '12.345.678/0009-10', 'RUA MAJOR JOÃO CEZIMBRA JAQUES, 200 - MEDIANEIRA', '(55)3961-1603', DEFAULT, DEFAULT, '18');
INSERT INTO cliente VALUES (NULL, 'MARCOS SILVA', 'MARCOS SILVA', '222.222.222-22', 'RUA IRINEU JOÃO DE SOUZA, 52 - CENTRO', '(65)4444-4444', DEFAULT, DEFAULT, '7'); 
INSERT INTO cliente VALUES (NUll, 'DUBAI CONSTRUTORA', 'DUBAI CONSTRUTORA E INCORPORADORA LTDA', '32.123.321/0001-23', 'AVENIDA DAS PALMEIRAS, 258 - PEDRAS GRANDES', '(11)99999-8888', DEFAULT, DEFAULT,'3');  

-- DESAFIO!!! Tente fazer todas as inserções necessárias para que se tenha um item de caixa. Na medida  que esteja digitando o código, tente associar os dados inseridos com o contexto real.
-- DESAFIO ACEITO!!!!!!!!!!! 

-- Inserindo registro na tabela departamento
INSERT INTO departamento(nome) VALUES ('OBRAS');
INSERT INTO departamento(nome) VALUES ('COMERCIAL');
INSERT INTO departamento(nome) VALUES ('COMPRAS');

-- Inserindo registro na tabela fabrica
INSERT INTO fabrica(nome) VALUES ('PLACAS');
INSERT INTO fabrica(nome) VALUES ('TACHAS');
INSERT INTO fabrica(nome) VALUES ('TINTA');
INSERT INTO fabrica(nome) VALUES ('METALÚRGICA');
INSERT INTO fabrica(nome) VALUES ('MICROESFERA');

-- Inserindo registr em produto
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('TACHA BI AMARELO', '1.58', '3250','2');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('TACHA BI BRANCO/VERMELHO', '1.60', '2100','2');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('TACHA MONO BRANCO', '1.20', '1650','2');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('TACHA MONO AMARELO', '1.15', '5320','2');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('TACHAO BI AMARELO', '2.15', '1100','2');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('TACHAO BI BRANCO', '2.20', '754','2');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('SEGREGADOR', '3.74', '300','2');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('MICROESFERA AC12', '3.16', '10125', '5');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('MICROESFERA AC04', '2.78', '4050', '5');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('COLUNA SEMI PORTICO', '367.88', '15', '4');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('BRAÇO SEMI PORTICO', '231.16', '12', '4');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('COLUNA GALV 3,15M', '69.96', '312', '4');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('ABRAÇADEIRA', '3.10', '320', '4');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('LAMINA DEFENSA METALICA 4M', '679.90', '45', '4');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('TINTA BASE AGUA BRANCO 36L', '312.15', '220', '3');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('TINTA BASE AGUA BRANCO 18L', '197.07', '49', '3');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('TINTA BASE AGUA AMARELO 36L', '330.58', '185', '3');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('TINTA BASE AGUA AMARELO 18L', '194.10', '22', '3');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('TINTA BASE AGUA CINZA 36L', '358.46', '41', '3');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('TINTA BASE AGUA CINZA 18L', '188.49', '18', '3');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('TINTA BASE AGUA CINZA 3.6L', '82.00', '9', '3');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('PLACA ADV A14', '22.19', '40', '1');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('PLACA ADV A15', '20.92', '27', '1');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('PLACA ADV A13A', '20.54', '45', '1');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('PLACA REG R1', '26.19', '60', '1');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('PLACA REG R6B', '24.01', '40', '1');
INSERT INTO produto (nome, preco_atual, estoque, fabrica_id) VALUES ('PLACA REG R28', '20.55', '35', '1');

-- Inserindo registro de funcionario
INSERT INTO funcionario (nome, CPF, endereço, cidade_id, departamento_id) VALUES ('ANDREA MULLER', '444.777.888-99','AVENIDA ELZA LUCCHI, 22 - PONTE DO IMARUIM', '18', '1');
INSERT INTO funcionario (nome, CPF, endereço, cidade_id, departamento_id) VALUES ('JOAO BARCELLOS', '987.789.999-00','RUA BEIRA RIOMAR, 841 - PONTE DO IMARUIM', '18', '2');
INSERT INTO funcionario (nome, CPF, endereço, cidade_id, departamento_id) VALUES ('ALEXANDRA VIEIRA', '001.000.002-99','RUA DAS FLORES, 19 - CENTRO', '17', '2');
INSERT INTO funcionario (nome, CPF, endereço, cidade_id, departamento_id) VALUES ('DEVAIR SILVA', '222.456.888-77','RUA CORONEL PEDRO DEMORO, 433 - ESTREITO', '5', '1');

-- Inserindo registro de caixa
INSERT INTO caixa (id, data_operacao, condicao, saldo, funcionario_id) VALUES (NULL, DEFAULT,'aberto', '58411.67', '2');

-- Inserindo registro de venda
INSERT INTO venda (desconto, total_com_desconto, cliente_id, funcionario_id) VALUES ('157.39', '6000.00', '3', '2');

-- Inserindo registro de itens_venda
INSERT INTO itens_venda(quantidade, preco, venda_id, produto_id) VALUES ('25', '22.19', '1', '22');
INSERT INTO itens_venda(quantidade, preco, venda_id, produto_id) VALUES ('50', '69.96', '1', '12');
INSERT INTO itens_venda(quantidade, preco, venda_id, produto_id) VALUES ('15', '20.55', '1', '27');
INSERT INTO itens_venda(quantidade, preco, venda_id, produto_id) VALUES ('10', '26.19', '1', '25');
INSERT INTO itens_venda(quantidade, preco, venda_id, produto_id) VALUES ('50', '3.1', '1', '13');
INSERT INTO itens_venda(quantidade, preco, venda_id, produto_id) VALUES ('7', '197.07', '1', '16');

-- Inserindo registro de recebimento
INSERT INTO recebimento(id, condicao, valor, numero_da_parcela, desconto, juros, total_final, venda_id) VALUES (NULL,'A VISTA', '6000.00', '1','100', '4', '6000.00', '1');

-- Inserindo registro de item caixa
INSERT INTO item_caixa_recebimento(id, descricao, valor, natureza, caixa_id, recebimento_id) VALUES (NULL, '','6000.00', 'PAGAMENTO A VISTA', '1', '1'); 

SELECT * FROM estado, cidade WHERE cidade.estado_id = estado.id;
SELECT * FROM funcionario, cidade WHERE funcionario.cidade_id = cidade.id;
SELECT * FROM funcionario, departamento WHERE funcionario.departamento_id = departamento.id;
SELECT * FROM cliente, cidade WHERE cliente.cidade_id = cidade.id;
SELECT * FROM venda, funcionario WHERE venda.funcionario_id = funcionario.id;
SELECT * FROM venda, cliente WHERE venda.cliente_id = cliente.id;
SELECT * FROM produto, fabrica WHERE produto.fabrica_id = fabrica.id;
SELECT * FROM itens_venda, venda WHERE itens_venda.venda_id = venda.id;
SELECT * FROM itens_venda, produto WHERE itens_venda.produto_id = produto.id;
SELECT * FROM recebimento, venda WHERE recebimento.venda_id = venda.id;
SELECT * FROM caixa, funcionario WHERE caixa.funcionario_id = funcionario.id;
SELECT * FROM item_caixa_recebimento, recebimento WHERE item_caixa_recebimento.recebimento_id = recebimento.id;
SELECT * FROM item_caixa_recebimento, caixa WHERE item_caixa_recebimento.caixa_id = caixa.id;

