CREATE DATABASE PJI;
USE PJI;

CREATE TABLE Interessado (
	codigo INT NOT NULL,
    imagem TEXT, -- BLOB, salvar imagem em um disco e dizer no banco onde está a imagem (/usuario/61.jpg ou /61.jpg);
	-- se for web salvar imagem no servidor e copiar o endereço (150x200/215837.fKi2N7DoIJ10.jpg) (150x200 é o tamanho da imagem)
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    cpf CHAR(11) NOT NULL,
    email VARCHAR(100) NOT NULL,
	senha CHAR(60), -- bcryptRaca
    codigo_verificacao CHAR(36), -- UUID
    verificado BOOL,
    PRIMARY KEY (codigo)
);

CREATE TABLE Endereco (
	codigo INT NOT NULL,
    codigo_interessado INT NOT NULL,
    cep INT NOT NULL,
    rua VARCHAR(1000) NOT NULL,
    numero INT NOT NULL,
    complemento VARCHAR(50),
    cidade VARCHAR (100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigo_interessado) REFERENCES Interessado (codigo)
);

CREATE TABLE Alteracao_Senha (
   codigo INT NOT NULL,
   codigo_interessado INT NOT NULL,
   codigo_verificacao CHAR(36), -- UUID
   gerado_em DATETIME NOT NULL,
   utilizado BOOL,
   PRIMARY KEY (codigo),
   FOREIGN KEY (codigo_interessado) REFERENCES Interessado (codigo)
);

CREATE TABLE Ong (
	codigo INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    cnpj CHAR(14),
    email VARCHAR(100) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    descricao VARCHAR(1000) NOT NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE DadosBancarios (
	codigo INT NOT NULL,
    codigo_ong INT NOT NULL,
    num_agencia INT,
    num_conta INT,
    tipo_conta VARCHAR(40),
    tipo_pix VARCHAR(30),
    num_pix BIGINT,
    PRIMARY KEY(codigo),
    FOREIGN KEY (codigo_ong) REFERENCES Ong (codigo)
);
   

CREATE TABLE Familia (
	codigo INT NOT NULL,
    nome VARCHAR(80) NOT NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE Raca (
	codigo INT NOT NULL,
    codigo_familia INT NOT NULL,
    nome VARCHAR(90) NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigo_familia) REFERENCES Familia (codigo)
);

CREATE TABLE Animal(
	codigo INT NOT NULL,
    codigo_raca INT NOT NULL,
    codigo_ong INT NOT NULL,
    cor ENUM('MARROM CLARO', 'MARROM ESCURO', 'BRANCO', 'PRETO', 'LARANJA', 'CINZA', 'AMARELO', 'FRAJOLA', 'MALHADO') NOT NULL,
    porte ENUM('GRANDE','MÉDIO', 'PEQUENO') NOT NULL,
    genero ENUM('MACHO', 'FÊMEA') NOT NULL,
    imagem_p TEXT NOT NULL,
    imagem_g TEXT NOT NULL,
    nome VARCHAR(30) NOT NULL,
    idade INT NOT NULL,
    peso FLOAT NOT NULL,
    origem VARCHAR(100),
    descricao VARCHAR(1000),
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigo_raca) REFERENCES Raca (codigo),
    FOREIGN KEY (codigo_ong) REFERENCES Ong (codigo)
);

CREATE TABLE PedidoAdocao(
	codigo INT NOT NULL,
    codigo_interessado INT NOT NULL,
    codigo_animal INT NOT NULL,
    data_adocao DATE NOT NULL,
    status_adocao ENUM('APROVADO', 'EM ANÁLISE', 'NEGADO') NOT NULL,
    observacao VARCHAR(200) NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigo_interessado) REFERENCES Interessado(codigo),
    FOREIGN KEY (codigo_animal) REFERENCES Animal(codigo)
);

CREATE TABLE Depoimento(
	codigo INT NOT NULL,
    codigo_pedidoadocao INT NOT NULL,
    descricao VARCHAR(100),
    data_depoimento DATE NOT NULL,
    PRIMARY KEY (codigo),
    FOREIGN KEY (codigo_pedidoadocao) REFERENCES PedidoAdocao (codigo)
);

insert into Interessado values(1, 'interessado/1.jpg', 'Vitor Silva', '1990-02-15', '45678912345', 'vitorsilva@gmail.com', '$2a$12$n3eDYWFXNMZmUOqZ4Q8TWepKlRxvrSXCZhPUk479WBcVcM.NbIi6.', '02fe7ca9-f7a8-46e4-8dc9-92db49c5daae', TRUE);
insert into Interessado values (2, 'interessado/2.jpg', 'Ana Vitória', '1998-04-21', '41256987445', 'anavitoria@gmail.com', '$2a$12$PirR4LJJKzMg1i7KsruafOKHjwTXTGZ0D/9tvsaS6rj9p2.N61lZC', 'f4f0c30e-5379-484f-855b-9cbf16c9079b', TRUE);
insert into Interessado values (3, 'interessado/3.jpg', 'Camila Pitanga', '2001-04-14', '98654752110', 'camilapitanga@gmail.com', '$2a$12$rgvsd6SQhIur2Vn4kCUkCO1PDgAK1XgEU36TG2s2BKCMMOotlGd92', '5f431829-70d0-49dc-a88c-e29b797c02d3', TRUE);
insert into Interessado values (4, 'interessado/4.jpg', 'João Gomes', '1985-03-25', '74185296310', 'joaogomes@gmail.com', '$2a$12$qEPYtq5bXm0HsR5ixvJvkeJDolF4IavVSIMS8rlYcLn02HIYawiUW', '7622ffae-103e-44e7-85ff-c3caba98c9eb', TRUE);
insert into Interessado values (5, 'interessado/5.jpg', 'Danilo Ferreira', '1987-08-08', '45678912301', 'daniloferreira@gmail.com', '$2a$12$xSXwaR6sLQH55IYwXTcisuCyCOO0B24Pz1WH8hIn6H66Nem5WKhfC', 'ef19f2ec-645b-4fe2-8828-70ebbf76543c', TRUE);
insert into Interessado values (6, 'interessado/6.jpg', 'Claudio Fernandes', '1974-11-01', '45628549778', 'claudiofernandes@gmail.com', '$2a$12$a3AOtrQ7/Ys30dcNVccpLuRLPiBk7ymNbBVuwBbwHyOqGFMk4niJm', 'ea7bcb00-6a72-4cd8-b136-d577ed118615', TRUE);
insert into Interessado values (7, 'interessado/7.jpg', 'Beatriz Souza', '1958-05-22', '56987412', 'beatrizsouza@gmail.com', '$2a$12$WRnrCoPdHHpEc4nzh2Tf6eiV8rJxNFXxhr5Dfo8BJZQhVXarOa1Ka', 'ca223eb7-114b-4153-a57a-556f26d793fe', FALSE);
insert into Interessado values (8, 'interessado/8.jpg', 'América Pires', '1980-07-09', '42365788988', 'americapires@gmail.com', '$2a$12$pbqflv0DDo7HH3NqXTMvmeFgKY4iAq1wB4w0pHbHgVdms/GMaX.Re', '179b5b9c-c07e-4343-9f15-5ad3f4047361', FALSE);
insert into Interessado values (9, 'interessado/9.jpg', 'Maurício Meireles', '1964-12-04', '46798512385', 'mauriciomeireles@gmail.com', '$2a$12$QCCaYjBamh3bwKskUfWlu.TO3pV.IaS19yPUOm2nv5ev./oPT6dr2', '290624c0-3360-451c-997a-160354ba9448', TRUE);
insert into Interessado values (10, 'interessado/10.jpg', 'Luana Length', '1999-12-12', '78459685478', 'luanalength@gmail.com', '$2a$12$7oCPfOf7uci7qVe2QqmaDuIW8Y0wR4/4/o4jG0s6INfS3D.Up0swG','659ff836-c2b1-475c-8071-9fa18982159d', TRUE);
insert into Interessado values (11, 'interessado/11.jpg', 'Melanie Eblak', '1987-08-19', '52841763456', 'melanieeblak@gmail.com', '$2a$12$Tq8/K8msnUQadqiaPgJvp.J3GjmZGI3Kibcz3atDs/XRkxvDJ8s7W', 'cf4d6476-b753-40b5-b54a-32b1695811ab', FALSE);
insert into Interessado values (12, 'interessado/12.jpg', 'Lucas Vieira', '1997-05-29', '46587789858', 'lucasvieira@gmail.com', '$2a$12$MdwbvYWZwt/QweZrklFb9uuDVPol0Im7Y6vpeZM2SFAyZjl2ttXZG', '56764f5c-5ebd-42ee-9af5-8db29565be82', FALSE);
insert into Interessado values (13, 'interessado/13.jpg', 'Guilherme Colucci', '2000-11-14', '26784596788', 'guilhermecolucci@gmail.com', '$2a$12$XRNzu3.nhsBMOFqffUIhVej9q8cJ78aptbxHWx9Qy0tvUgFVC2.NK', 'f0b8a716-c074-43ba-97b7-aca8128b08b0', TRUE);
insert into Interessado values (14, 'interessado/14.jpg', 'Sofia Silva', '1985-09-01', '42685135988', 'sofiasilva@gmail.com', '$2a$12$/223cyDMaPkmLLOB.yb4gef9tvfw3EKAJg0e0vBVjiMebQRBA1Wf2', 'e8a62158-90f9-48db-9b77-094e602f0f77', TRUE);
insert into Interessado values (15, 'interessado/15.jpg', 'Julia Tonon', '1987-11-30', '26548798526', 'juliatonon@gmail.com', '$2a$12$JJ7SJ8p5sK4os53TYoWtUOYc511lpsLb/9Fky0//iRzOPnjcpCrl2', 'cf2813e5-3c7b-4305-a747-b99c0d440d12',TRUE);
insert into Interessado values (16, 'interessado/16.jpg', 'Letícia Vilela', '1981-01-21', '13589745621', 'leticiavilela@gmail.com', '$2a$12$VP0nPmd3yu374lLvFa/nRO0s4Jed5Exj8VMj5hP59KbtcS/Akr8uG', '1e23e16c-e609-4e2e-b85a-65ae7381ba9d', TRUE);
insert into Interessado values (17, 'interessado/17.jpg', 'Thales Lima', '1962-02-22', '05648978541', 'thaleslima@gmail.com', '$2a$12$MsVqtut2z0fMVmqOUkVNnOLqvk0eC9D4uC6FLbOaL7HnS26QQrAha', '5339ba51-feed-4af3-81e3-e715d19f5f59', TRUE);
insert into Interessado values (18, 'interessado/18,jpg', 'Lucas Oliveira', '2001-03-04', '56897478544', 'lucasoliveira@gmail.com', '$2a$12$BQfRxyseMrxZz/iZzfGLgOSLvd.p6mOdxkLP6F8z6OuZfK9goOTkG', '5c035db6-ecd5-42c2-ac47-1cd648241b2e', TRUE);
insert into Interessado values (19, 'interessado/19,jpg', 'Ana Meireles', '1950-07-29', '23569874856', 'anameireles@gmail.com', '$2a$12$q4QCjoOMWAb3WWEMoSN8sOAIGaR7/yaxza4CO4ShUMk4sfy4fgUsS', '6d489661-a824-4d26-a753-2297ec9d6925', TRUE);
insert into Interessado values (20, 'interessado/20.jpg', 'Fernanda Serrazul', '1999-12-25', '45628598745', 'fernandaserrazul@gmail.com', '$2a$12$jhnfH/o18KvjiB5c9u3UK.GPkWpr4cr15rn4BnuY0U8y7oHgj0NDK', '492f029d-2a69-4a2a-af9b-07c2256bd562', TRUE);

insert into Endereco values (1, 1, 245454545, 'Rua dos girassóis', 998, null, 'SP', 'SP');
insert into Endereco values (2, 2, 05187540, 'Rua nabius', 765, null, 'SP', 'SP');
insert into Endereco values (3, 3, 02158654, 'Rua pinherais', 456, null, 'Uberlandia', 'MG' );
insert into Endereco values (4, 4, 02158964, 'Rua flor em flor', 103, null, 'SP', 'SP');
insert into Endereco values (5, 5, 02158741, 'Rua pimenteis', 123, null, 'SP', 'SP');
insert into Endereco values (6, 6, 08542036, 'Rua ameixeiras', 001, null, 'SP', 'SP');
insert into Endereco values (7, 7, 20145896, ' Rua doutor piza', 54, null, 'SP', 'SP');
insert into Endereco values (8, 8, 01144778, 'Rua Manoel Prata', 845, null, 'Curitiba', 'PR');
insert into Endereco values (9, 9, 0011445, 'Rua Eldorado', 3388, null, 'Belo Horizonte', 'MG');
insert into Endereco values (10, 10, 05175420, ' Rua Doutora Jeiser', 876, null, 'Itapeva', 'SP');
insert into Endereco values (11, 11, 11896520, 'Rua Cabral Medeiros', 56 , null, 'Congonhal', 'MG');
insert into Endereco values (12, 12, 01478520, 'Rua Ipês', 99, null, 'Florianópolis', 'SC' );
insert into Endereco values (13, 13, 4785960, 'Rua Samambaia', 189, null, 'SP', 'SP' );
insert into Endereco values (14, 14, 02158630, 'Rua Sambaiba', 3254, null, 'Curitiba', 'PR');
insert into Endereco values (15, 15, 04789520, 'Rua Clarice', 441, null, 'Itapetininga', 'SP');
insert into Endereco values (16, 16, 02158960, 'Rua Conselheiro', 598, null, 'Capão Bonito', 'SP' );
insert into Endereco values (17, 17, 02178960, 'Rua Itaici', 88, null, 'SP', 'SP');
insert into Endereco values (18, 18, 82178054, 'Rua Moreira de Barros', 201, null, 'Buri', 'SP');
insert into Endereco values (19, 19, 005865000, 'Rua Santo Egídio', 992, null, 'SP', 'SP');
insert into Endereco values (20, 20, 3020111, 'Rua Brás Leme', 456, null, 'SP', 'SP');

insert into Alteracao_Senha values (1, 2, 'e8a82760-27b6-4790-81c1-af8e97351cd7', '2022-06-29 20:18:30', false);
insert into Alteracao_Senha values (2, 4, '910df30c-ee53-4c48-b5aa-2102becbf586', '2022-06-28 14:23:07', false);
insert into Alteracao_Senha values (3, 7, '8f69cf63-ddae-4a9c-a950-ec04bacc424d', '2022-06-29 17:34:43', false);
insert into Alteracao_Senha values (4, 13, '8ca08e06-06c4-4553-8d1e-3e5c38b1634f', '2022-06-26 18:12:16', false);
insert into Alteracao_Senha values (5, 19, '69e7ac04-21db-406b-9c7c-f2c6e694fcf8', '2022-06-27 19:43:15', false);

insert into Ong values (1, 'Instituto Resgate', '76342765000143', 'institutoresgate@gmail.com', 'rua antonio tibo 96 - São Paulo, SP', 'Realizamos o resgate de animais em situação de abandono e violência, cuidamos e os deixamos prontos para adoção, todos estão devidamente castrados e vacinados, apenas esperando um lar, venha fazer parte disso!' );
insert into Ong values (2, 'Instituto Aline', '54876985000198', 'alineinstituto@gmail.com', 'rua ribeiro lemos 43 - São Paulo, SP', 'Temos muitos animais variados disponiveis para adoção, todos aguardando anciosamente um lar e uma familia amorosa!' );
insert into Ong values (3, 'Instituto animals', '12564872000184', 'institutoanimals@gmail.com', 'rua ivone dos santos 98 - São Paulo, SP', 'Trabalhamos a mais de 30 anos salvado a vida de milhares de animais e os direcionando para vidas cheias de amor e carinho, venha participar dessa corrente do bem, dando um lar para um bichinho!' );

insert into DadosBancarios values (1, 1, '1234', '546450', 'conta-corrente', 'CNPJ', '76342765000143');
insert into DadosBancarios values (2, 2, '2314', '543650', 'conta-corrente', 'CNPJ', '54876985000198');
insert into DadosBancarios values (3, 3, '3214', '678540', 'conta-corrente', 'CNPJ', '12564872000184');

insert into Familia values (1, 'Canídeos');
insert into Familia values (2, 'Felídeos');

insert into Raca values (1, 1, 'Akita');
insert into Raca values (2, 1, 'Basset hound');
insert into Raca values (3, 1, 'Beagle');
insert into Raca values (4, 1, 'Bichon frisé');
insert into Raca values (5, 1, 'Boiadeiro australiano');
insert into Raca values (6, 1, 'Border collie');
insert into Raca values (7, 1, 'Boston terrier');
insert into Raca values (8, 1, 'Boxer');
insert into Raca values (9, 1, 'Buldogue francês');
insert into Raca values (10, 1, 'Buldogue inglês');

insert into Raca values (11, 2, 'Persa');
insert into Raca values (12, 2, 'British Shorthair');
insert into Raca values (13, 2, 'Sphynx');
insert into Raca values (14, 2, 'Siamês');
insert into Raca values (15, 2, 'Angorá');
insert into Raca values (16, 2, 'Maine Coon');
insert into Raca values (17, 2, 'Himalaio');
insert into Raca values (18, 2, 'Bengal');
insert into Raca values (19, 2, 'Ragdoll');
insert into Raca values (20, 2, 'Munchkin');

insert into Animal values ( 1, 1, 1, 'MARROM CLARO', 'GRANDE', 'FÊMEA', '/institutoresgate/1_p.jpg', '/institutoresgate/1_g.jpg', 'Alexia', 2, '35.0', 'São Bernado do Campo', 'Leal, amigo e brincalhão');
insert into Animal values ( 2, 2, 1, 'LARANJA', 'GRANDE', 'FÊMEA', '/institutoresgate/2_p.jpg', '/institutoresgate/2_g.jpg', 'Ana', 5, '21.4', 'Araras', 'Alegre, teimoso e charmoso');
insert into Animal values ( 3, 3, 1, 'CINZA', 'MÉDIO', 'FÊMEA', '/institutoresgate/3_p.jpg', '/institutoresgate/3_g.jpg', 'Julia', 1, '9.5', 'Araraquara','companheiro e aventureiro');
insert into Animal values ( 4, 4, 2, 'PRETO', 'MÉDIO', 'FÊMEA', '/institutoaline/4_p.jpg', '/institutoaline/4_g.jpg', 'Lola', 6, '5.0', 'Jundiai', 'Brincalhão, curioso e afetivo');
insert into Animal values ( 5, 5, 2, 'FRAJOLA', 'MÉDIO', 'MACHO', '/institutoaline/5_p.jpg', '/institutoaline/5_g.jpg', 'Enzo', 2, '20.0', 'Guaruja', 'Alerta, curioso e leal');
insert into Animal values ( 6, 6, 2, 'BRANCO', 'GRANDE', 'MACHO', '/institutoaline/6_p.jpg', '/institutoaline/6_g.jpg', 'Toby', 3, '13.0' , 'Ubatuba', 'Inteligente, leal e cheio de energia');
insert into Animal values ( 7, 7, 2, 'MARROM ESCURO', 'MÉDIO', 'FÊMEA', '/institutoaline/7_p.jpg', '/institutoaline/8_g.jpg', 'Jully', 4, '5.0', 'Atibaia', 'Amigável, inteligente e vivaz');
insert into Animal values ( 8, 8, 3, 'BRANCO', 'GRANDE', 'MACHO', '/institutoanimals/8_p.jpg', '/institutoanimals/8_g.jpg', 'Negão', 1, '27.8',  'São Pedro', ' Leal, afetuoso e brincalhão');
insert into Animal values ( 9, 9, 3, 'PRETO', 'PEQUENO', 'MACHO', '/institutoanimals/9_p.jpg', '/institutoanimals/9_g.jpg', 'Sandro', 6, '25.0',  'São Roque', 'Carinhoso, leal e brincalhão');
insert into Animal values ( 10, 10, 3, 'CINZA', 'PEQUENO', 'MACHO', '/institutoanimals/10_p.jpg', '/institutoanimals/10_g.jpg', 'Iron', 3, '24.0', 'Itu', 'Calmo, divertido e dócil');

insert into Animal values (11, 11, 1, 'AMARELO', 'MÉDIO', 'FÊMEA', '/institutoresgate/11_p.jpg', '/institutoresgate/11_g.jpg', 'Anita', 1, '4.0', 'Campinas', 'Tranquila, se da bem com crianças e com outros animais e gosta de brincar' );
insert into Animal values (12, 12, 1, 'MARROM CLARO', 'MÉDIO','MACHO','/institutoresgate/12_p.jpg','/institutoresgate/12_g.jpg', 'Alladin', 7, '5.0', 'São Paulo', 'Muito sociável, bem apegado ao tutor e companheiro');
insert into Animal values (13, 13, 1, 'PRETO', 'MÉDIO','MACHO', '/institutoresgate/13_p.jpg', '/institutoresgate/14_g.jpg','Marley', 2, '4.5', 'Boituva', 'extremamente amigável e brincalhão');
insert into Animal values (14, 14, 2, 'FRAJOLA', 'MÉDIO', 'FÊMEA', '/institutoaline/14_p.jpg', '/institutoaline/14_g.jpg', 'Diana', 1, '3.0', 'Socorro',  'inteligente, dócil, altamente sociável , gosta de chamar atenção e busca interatividade com adultos, crianças e outros animais.');
insert into Animal values (15, 15, 2, 'LARANJA', 'MÉDIO', 'MACHO', '/institutoaline/15_p.jpg', '/institutoaline/15_g.jpg', 'Rá', 1 ,'6.5', 'Campos do Jordão', 'Ele é inteligentes, dóceis, brincalhões, amorosos e ama carinho.');
insert into Animal values (16, 16, 2, 'BRANCO', 'MÉDIO', 'FÊMEA', '/institutoaline/16_p.jpg', '/institutoaline/16_g.jpg', 'Maia', 10, '5.0', 'Cunha', 'bom companheiro, não exige tanta atenção e, raramente, gosta de ser mimado pelos donos' );
insert into Animal values (17, 17, 2, 'MALHADO', 'MÉDIO','MACHO', '/institutoaline/17_p.jpg', '/institutoaline/17_g.jpg', 'Tróia', 5, '4.5', 'Ribeirão Preto', 'adorável, dócil, cheio de energia e muito afetuoso.');
insert into Animal values (18, 18, 3, 'BRANCO', 'MÉDIO', 'FÊMEA', '/institutoanimals/18_p.jpg', '/institutoanimals/18_g.jpg', 'Helena', 4, '7.0', 'Olimpia', 'É extrovertido, seguro e adora brincar e se dá bem com crianças e outros tipos de animais domésticos.');
insert into Animal values (19, 19, 3, 'CINZA', 'GRANDE', 'MACHO', '/institutoanimals/19_p.jpg', '/institutoanimals/19_g.jpg', 'Dionosio', 3, '8.5', 'Eldorado', 'bastante amigável, companhia tranquila, gosta de contato físico e de brincar');
insert into Animal values (20, 20, 3, 'MARROM CLARO', 'PEQUENO', 'MACHO', '/institutoanimals/20_p.jpg', '/institutoanimals/20_g.jpg','Negão',  1, '2.5', 'Monte Alegre do Sul', 'afetuoso, tranquilo, feliz e inteligente');

insert into PedidoAdocao values (1, 1, 1, '2022-04-05', 'APROVADO', 'Pedido aprovado! Parabéns!');
insert into PedidoAdocao values (2, 2, 3, '2022-01-26', 'APROVADO', 'Pedido aprovado! Parabéns!');
insert into PedidoAdocao values (3, 2, 2, '2021-12-25', 'NEGADO', 'Infelizmente seu pedido foi negado...');
insert into PedidoAdocao values (4, 5, 4, '2020-11-21', 'APROVADO', 'Pedido aprovado! Parabéns!');
insert into PedidoAdocao values (5, 3, 5, '2022-01-01', 'APROVADO', 'Pedido aprovado!Parabéns!');
insert into PedidoAdocao values (6, 4, 6, '2022-06-15', 'EM ANÁLISE', 'Seu pedido está sendo analisado.');
insert into PedidoAdocao values (7, 5, 7, '2022-06-20', 'EM ANÁLISE', 'Seu pedido está sendo analisado.');
insert into PedidoAdocao values (8, 5, 8, '2019-12-12', 'NEGADO', 'Infelizmente seu pedido foi negado...');
insert into PedidoAdocao values (9, 6, 9, '2022-02-20', 'APROVADO', 'Pedido aprovado! Parabéns!');
insert into PedidoAdocao values (10, 6, 10, '2021-09-11', 'APROVADO', 'Pedido aprovado! Parabéns!');
insert into PedidoAdocao values (11, 7, 11, '2020-09-04', 'APROVADO', 'Pedido aprovado! Parabéns!');
insert into PedidoAdocao values (12, 7, 12, '2021-06-11', 'NEGADO', 'Infelizmente su pedido foi negado...');
insert into PedidoAdocao values (13, 8, 13, '2022-05-06', 'APROVADO', 'Seu pedido foi aprovado! Parabéns!');
insert into PedidoAdocao values (14, 8, 14, '2020-12-13', 'APROVADO', 'Seu pedido foi aprovado! Parabéns!');
insert into PedidoAdocao values (15, 9,15, '2021-04-09', 'NEGADO', 'Infelizmente seu pedido foi negado...');
insert into PedidoAdocao values (16, 10, 16, '2022-06-21', 'EM ANÁLISE', 'Seu pedido está sendo analisado.');

insert into Depoimento values (1, 1, 'Trouxe um novo brilho para nossa família, excelente animal!!!', '2022-05-10');
insert into Depoimento values (2, 2, 'Eu não poderia estar mais grata por ter realizado esta adoção!', '2022-02-20');
insert into Depoimento values (4, 4, 'Sou muito grato por ter a Lola na minha vida!','2020-12-05');
insert into Depoimento values (5, 5, 'A adoção foi super tranquila! Muito obrigada!', '2022-01-25');
insert into Depoimento values (6, 6, 'Muito obrugado pela dedicação!','2022-07-01');
insert into Depoimento values (7, 7, 'Não tenho como agradecer o carinho de vocês pelos animais!', '2022-07-05');
insert into Depoimento values (9, 9, 'Foi uma ótima experiência! Recomendo!', '2022-03-02');
insert into Depoimento values (10, 10, 'Estou super realizada com essa adoção', '2021-09-29');
insert into Depoimento values (11, 11, 'Já adotei dois e pretendo adotar mais! Incrível!', '2020-10-01');
insert into Depoimento values (12, 12, 'Melhor site de adoção que já me recomendaram', '2021-07-01');
insert into Depoimento values (13, 13, 'Meus dias se tornaram melhores!', '2022-05-29');
insert into Depoimento values (15, 15, 'Adotem! É importantíssimo!', '2021-04-29');

-- exibir pedido de adoção e depoimento
CREATE OR REPLACE VIEW pedido_depoimento AS
select i.nome,  d.descricao as depoimento, d.data_depoimento, d.codigo as id_depoimento
from Depoimento d
inner join PedidoAdocao p ON d.codigo_pedidoadocao = p.codigo
inner join Interessado i on i.codigo = p.codigo_interessado
order by i.nome;

SELECT * FROM pedido_depoimento WHERE id_depoimento = 4;
SELECT * FROM pedido_depoimento WHERE id_depoimento = 7;

-- exibir status da adoção e animal
CREATE VIEW status_adocao AS
select a.nome, p.status_adocao
from PedidoAdocao p
left join Animal a on p.codigo_animal = a.codigo;

SELECT * FROM status_adocao;

-- exibir dados bancários das ONGs
CREATE VIEW dados_bancarios AS
SELECT o.nome, o.cnpj, d.num_agencia, d.num_conta, d.tipo_conta, d.tipo_pix, d.num_pix
FROM Ong o
LEFT JOIN DadosBancarios d ON d.codigo_ong = o.codigo;

SELECT * FROM dados_bancarios;

-- exibir animais da Ong;
CREATE OR REPLACE VIEW lista_animais AS
SELECT o.nome as Ong, a.imagem_p, a.nome, a.genero, o.codigo as id_ong
FROM Ong o
LEFT JOIN Animal a ON a.codigo_ong = o.codigo;

SELECT * FROM lista_animais WHERE id_ong = 1;
SELECT * FROM lista_animais WHERE id_ong = 2;
SELECT * FROM lista_animais WHERE id_ong = 3;


-- detalhar o perfil de um animal
CREATE OR REPLACE VIEW detalhar_animal AS
SELECT o.nome as Ong, a.imagem_g, a.codigo as codigo_animal, a.nome, a.idade, a.peso, c.nome AS Raca, a.cor, a.porte, a.genero, a.origem, a.descricao, o.codigo as codigo_ong
FROM Ong o
LEFT JOIN Animal a ON a.codigo_ong = o.codigo
left join Raca c on c.codigo = a.codigo_raca;

SELECT * FROM detalhar_animal WHERE codigo_animal = 12;
SELECT * FROM detalhar_animal WHERE codigo_animal = 16;
SELECT * FROM detalhar_animal WHERE codigo_animal = 8;

-- quantidade de animais em cada ONG
SELECT o.nome as Ong, COUNT(a.codigo) as num_animais
FROM Ong o
LEFT JOIN Animal a ON a.codigo_ong = o.codigo
GROUP BY o.nome;

-- média de idade e máximo dos animais de cada ONG
SELECT o.nome as Ong, FORMAT (AVG(a.idade) ,0) as media_idade_animais, MAX(a.idade) as idade_máxima_animais
FROM Ong o
LEFT JOIN Animal a ON a.codigo_ong = o.codigo
GROUP BY o.nome;

-- quantidade de adoções por raça
SELECT r.nome as Raca, COUNT(p.codigo) AS Quantidade_adocao
FROM PedidoAdocao p
INNER JOIN Animal a ON p.codigo_animal = a.codigo
INNER JOIN Raca r ON r.codigo = a.codigo_raca
GROUP BY r.nome
ORDER BY r.nome;

-- url animais ongs
DELIMITER $$

CREATE FUNCTION fn_slug(nome TEXT)

RETURNS TEXT DETERMINISTIC

BEGIN

    DECLARE resultado TEXT;

    SET resultado = REPLACE(nome, '.', ' ');

    SET resultado = REPLACE(resultado, ' ', '-');

    SET resultado = REPLACE(resultado, '--', '-') ;

    SET resultado = REPLACE(resultado, '\'', '-');

    SET resultado = REPLACE(resultado, 'œ', 'oe');

    SET resultado = REPLACE(resultado, '€', 'euro');

    SET resultado = REPLACE(resultado, '$', 'dollars');

    SET resultado = REPLACE(resultado, '£', '');

    SET resultado = TRIM(resultado);

    SET resultado = REPLACE(resultado,'à','a');

    SET resultado = REPLACE(resultado,'á','a');

    SET resultado = REPLACE(resultado,'â','a');

    SET resultado = REPLACE(resultado,'ã','a');

    SET resultado = REPLACE(resultado,'ä','a');

    SET resultado = REPLACE(resultado,'å', 'a');

    SET resultado = REPLACE(resultado,'æ','a');

    SET resultado = REPLACE(resultado,'è','e');

    SET resultado = REPLACE(resultado,'é','e');

    SET resultado = REPLACE(resultado,'ê','e');

    SET resultado = REPLACE(resultado,'ë','e');

    SET resultado = REPLACE(resultado,'ì','i');

    SET resultado = REPLACE(resultado,'í','i');

    SET resultado = REPLACE(resultado,'î','i');

    SET resultado = REPLACE(resultado,'ï','i');

    SET resultado = REPLACE(resultado,'ð','o');

    SET resultado = REPLACE(resultado,'ñ','n');

    SET resultado = REPLACE(resultado,'ò','o');

    SET resultado = REPLACE(resultado,'ó','o');

    SET resultado = REPLACE(resultado,'ô','o');

    SET resultado = REPLACE(resultado,'õ','o');

    SET resultado = REPLACE(resultado,'ö','o');

    SET resultado = REPLACE(resultado,'ø','o');

    SET resultado = REPLACE(resultado,'ù','u');

    SET resultado = REPLACE(resultado,'ú','u');

    SET resultado = REPLACE(resultado,'û','u');

    SET resultado = REPLACE(resultado,'ý','y');

    SET resultado = REPLACE(resultado,'ý','y');

    SET resultado = REPLACE(resultado,'þ','b');

    SET resultado = REPLACE(resultado,'ÿ','y');

    SET resultado = REPLACE(resultado,'ƒ','f');

    SET resultado = REPLACE(resultado,'À','A');

    SET resultado = REPLACE(resultado,'Á','A');

    SET resultado = REPLACE(resultado,'Â','A');

    SET resultado = REPLACE(resultado,'Ã','A');

    SET resultado = REPLACE(resultado,'Ä','A');

    SET resultado = REPLACE(resultado,'Å','A');

    SET resultado = REPLACE(resultado,'È','E');

    SET resultado = REPLACE(resultado,'É','E');

    SET resultado = REPLACE(resultado,'Ê','E');

    SET resultado = REPLACE(resultado,'Ë','E');

    SET resultado = REPLACE(resultado,'Ì','I');

    SET resultado = REPLACE(resultado,'Í','I');

    SET resultado = REPLACE(resultado,'Î','I');

    SET resultado = REPLACE(resultado,'Ï','I');

    SET resultado = REPLACE(resultado,'Ò','O');

    SET resultado = REPLACE(resultado,'Ó','O');

    SET resultado = REPLACE(resultado,'Ô','O');

    SET resultado = REPLACE(resultado,'Õ','O');

    SET resultado = REPLACE(resultado,'Ö','O');

    SET resultado = REPLACE(resultado,'Ù','U');

    SET resultado = REPLACE(resultado,'Ú','U');

    SET resultado = REPLACE(resultado,'Û','U');

    SET resultado = REPLACE(resultado,'Ü','U');

    SET resultado = REPLACE(resultado,'Ø','O');

    SET resultado = REPLACE(resultado,'Æ','A');

    SET resultado = REPLACE(resultado,'Ð','D');

    SET resultado = REPLACE(resultado,'Ñ','N');

    SET resultado = REPLACE(resultado,'Ý','Y');

    SET resultado = REPLACE(resultado,'Þ','B');

    SET resultado = REPLACE(resultado,'ß','S');

    SET resultado = REPLACE(resultado,'ç','c');

    SET resultado = REPLACE(resultado,'Ç','C');

    SET resultado = REPLACE(resultado,'š','s');

    SET resultado = REPLACE(resultado,'Ð','Dj');

    SET resultado = REPLACE(resultado,'ž','z');

    SET resultado = REPLACE(resultado,'Þ','B');

    SET resultado = REPLACE(resultado,'ß','Ss');

    SET resultado = CONCAT('adotapets.com/', resultado, '/animais');
   
    RETURN LOWER(resultado);
 
END

$$

    SELECT o.nome as Ong, fn_slug(o.nome) as Slug, a.imagem_p, a.nome, a.genero, o.codigo as id_ong
    FROM Ong o
    LEFT JOIN Animal a ON a.codigo_ong = o.codigo;
    
    