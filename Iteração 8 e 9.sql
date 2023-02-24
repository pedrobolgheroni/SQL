CREATE DATABASE iteracao4;

USE iteracao4;

CREATE TABLE Usuario (
codigo int NOT NULL,
    nome VARCHAR (100) NOT NULL,
    email VARCHAR (100) NOT NULL,
    senha CHAR(60) NOT NULL,
    codigo_verificacao CHAR(36),
    verificado BOOL,
    PRIMARY KEY (codigo)
);

CREATE TABLE Lista_Tarefas (
	codigo int NOT NULL,
    nome VARCHAR (30) NOT NULL,
    codigo_usuario int NOT NULL,
    cor CHAR (6),
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigo_usuario) REFERENCES Usuario (codigo) ON DELETE CASCADE
);

CREATE TABLE Tarefa(
	codigo int NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    data DATE,
    realizada BOOL NOT NULL,
    codigo_lista int NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigo_lista) REFERENCES Lista_Tarefas (codigo) ON DELETE CASCADE
);

CREATE TABLE alteracao_senha(
codigo int NOT NULL,
    codigo_verificacao CHAR (60) NOT NULL, -- UUID
    codigo_usuario int NOT NULL,
    gerada_em DATETIME NOT NULL,
    utilizada BOOL NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigo_usuario) REFERENCES Usuario (codigo) 
);
 
 INSERT INTO Usuario VALUES
	(1, 'Joaozinho', 'joaozinhocria123@meuemail.com', '$2a$10$O5.vzkUVxobVm9rhFffAA.L4NsV0cDiWEr2o7Sj9vrGpVeGKQV3La', '9e56dd03-65db-4ed3-8a97-9eb106976fc1', false),
    (2, 'Teteu', 'teteu@email.com', '$2a$10$744xOGpXv6x3D6x44iZvZO4lncysqPnfWcWilhV/IcRbAk22yj4HW', '64cae394-dc6f-4c56-9b37-39383313abf0', false),
    (3, 'Maria', 'maria@email.com', '$2a$10$Wn8wjx6v/6tHVslVaTnGDOVPITWqILGgUyswwTGQqRfVHc/0V7f.O', 'a4db300a-44be-4272-9121-ad916d689c4d', false);
   
   INSERT INTO Lista_Tarefas VALUES
   (1, 'Escola', 1, '3a34eb'),
   (2, 'Casa', 1, 'eb3480'),
   (3, 'Trabalho', 1, '37eb34'),
   (4, 'Faculdade', 2, 'ebc034'),
   (5, 'Mercado', 2, 'eb7a34'),
   (6, 'Banco', 2, 'ebc634'),
   (7, 'Farmacia', 3, '34cfeb'),
   (8, 'Apartamento', 3, '34ebb4'),
   (9, 'Limpeza', 3, 'eb34e1');
   
 INSERT INTO Tarefa VALUES
	(1, 'licao de historia', '2022-04-18', true, 1),
    (2, 'trabalho de bdd', '2022-04-14', false, 1),
    (3, 'prova de matematica', '2022-04-18', false, 1),
    (4, 'organizar compras', '2022-04-02', false, 2),
    (5, 'comprar móveis novos', '2022-04-18', false, 2),
    (6, 'pintar parede da sala', '2022-04-18', false, 2),
    (7, 'organizar reuniao', '2022-04-15', true, 3),
    (8, 'fazer relatorio da semana', '2022-04-22', false, 3),
    (9, 'fazer entrevistas', '2022-04-25', false, 3),
    (10, 'trabalho de conclusão', '2022-04-30', false, 4),
    (11, 'seminario de geografia', '2022-04-19', false, 4),
    (12, 'fazer grupo para trabalho', '2022-04-17', true, 4),
    (13, 'comprar carne', '2022-04-18', false, 5),
    (14, 'comprar frango', '2022-04-18', true, 5),
    (15, 'fazer cartao de desconto', '2022-04-19', false, 5),
    (16, 'fazer transferencia para irmã', '2022-04-18', true, 6),
    (17, 'criar pix', '2022-04-17', false, 6),
    (18, 'tirar extrato', '2022-04-18', false, 6),
    (19, 'comprar dipirona', '2022-04-18', true, 7),
    (20, 'pegar receita', '2022-04-17', false, 7),
    (21, 'comprar creme', '2022-04-16', false, 7),
    (22, 'trocar interfone', '2022-04-10', false, 8),
    (23, 'comprar escorredor de pratos', '2022-04-18', false, 8),
    (24, 'trocar chuveiro', '2022-04-19', false, 8),
    (25, 'limpar quarto', '2022-04-17', true, 9),
    (26, 'lavar roupa', '2022-04-18', true, 9),
    (27, 'lavar quintal', '2022-04-19', false, 9);
    
INSERT INTO alteracao_senha VALUES
(1, 'dde0f383-84b6-4723-87ea-5b0926e09e85', 1, '2022-04-04 15:17:00', false);
   
    SELECT * FROM Usuario;
   
    SELECT * FROM Lista_Tarefas;
    
    SELECT * FROM Tarefa;
   
    SELECT * FROM alteracao_senha;
    
    SELECT * FROM Tarefa WHERE data = '2022-04-18' AND codigo_lista IN (4, 5, 6);
    
    SELECT * FROM Tarefa WHERE data < '2022-04-18' AND realizada = false AND codigo_lista IN (1, 2, 3);
    
    DELETE FROM Lista_Tarefas WHERE codigo = 1; -- com ON DELETE CASCADE
    
    DELETE FROM Tarefa WHERE codigo_lista = 1; -- sem ON DELETE CASCADE
    
    
