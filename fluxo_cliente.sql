
// 1. Limpar o banco antes de tudo
-- Deletar tabelas caso já existam

DROP TABLE Endereco CASCADE CONSTRAINTS;
DROP TABLE Genero CASCADE CONSTRAINTS;
DROP TABLE EnderecoPreferencia CASCADE CONSTRAINTS;
DROP TABLE Turno CASCADE CONSTRAINTS;
DROP TABLE PreferenciaDia CASCADE CONSTRAINTS;
DROP TABLE PreferenciaHorario CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;


// 2. Criar tabelas

-- Tabela Endereco (Residencial)

CREATE TABLE Endereco (
    id_endereco INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    cep VARCHAR2(255) NOT NULL,
    estado VARCHAR2(255) NOT NULL,
    cidade VARCHAR2(255) NOT NULL,
    bairro VARCHAR2(255) NOT NULL,
    rua VARCHAR2(255) NOT NULL,
    numero VARCHAR2(20) NOT NULL
);

-- Tabela Genero

CREATE TABLE Genero (
    id_genero INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL -- Masculino e Feminino.
);

-- Tabela EnderecoPreferencia (Endereço de Preferência)

CREATE TABLE EnderecoPreferencia (
    id_endereco_preferencia INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    cep VARCHAR2(255) NOT NULL,
    estado VARCHAR2(255) NOT NULL,
    cidade VARCHAR2(255) NOT NULL,
    bairro VARCHAR2(255) NOT NULL,
    rua VARCHAR2(255) NOT NULL,
    numero VARCHAR2(20) NOT NULL
);


-- Tabela Turno

CREATE TABLE Turno (
    id_turno INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL -- Manhã, Tarde, Noite
);

-- Tabela PreferenciaDia

CREATE TABLE PreferenciaDia (
    id_preferencia_dia INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    dia VARCHAR2(10) NOT NULL -- 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo'
);



-- Tabela PreferenciaHorario

CREATE TABLE PreferenciaHorario (
    id_preferencia_horario INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    horario VARCHAR2(5) NOT NULL -- Horários específicos, formato HH:MM (Ex: '06:00', '20:00')
);


-- Tabela Cliente

CREATE TABLE Cliente (
    id_cliente INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome_completo VARCHAR2(100) NOT NULL, 
    email VARCHAR2(100) CONSTRAINT email_unique UNIQUE NOT NULL, 
    telefone VARCHAR2(15) NOT NULL, 
    data_nasc DATE NOT NULL, -- formato: AAAA-MM-DD
    fk_id_endereco INTEGER, -- FK para o endereço residencial
    fk_id_genero INTEGER, -- FK para a tabela Genero
    fk_id_endereco_preferencia INTEGER, -- FK para o endereço de preferência
    fk_id_turno INTEGER, -- FK para a tabela Turno
    fk_id_preferencia_dia INTEGER, -- FK para a tabela PreferenciaDia
    fk_id_preferencia_horario INTEGER, -- FK para a tabela PreferenciaHorario, pode ser NULL
    CONSTRAINT fk_cliente_endereco FOREIGN KEY (fk_id_endereco) REFERENCES Endereco(id_endereco),
    CONSTRAINT fk_cliente_genero FOREIGN KEY (fk_id_genero) REFERENCES Genero(id_genero),
    CONSTRAINT fk_cliente_endereco_preferencia FOREIGN KEY (fk_id_endereco_preferencia) REFERENCES EnderecoPreferencia(id_endereco_preferencia),
    CONSTRAINT fk_cliente_turno FOREIGN KEY (fk_id_turno) REFERENCES Turno(id_turno),
    CONSTRAINT fk_cliente_preferencia_dia FOREIGN KEY (fk_id_preferencia_dia) REFERENCES PreferenciaDia(id_preferencia_dia),
    CONSTRAINT fk_cliente_preferencia_horario FOREIGN KEY (fk_id_preferencia_horario) REFERENCES PreferenciaHorario(id_preferencia_horario)
);


// 3. Inserir dados

-- Inserindo dados na tabela Endereco

INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01000-000', 'SP', 'São Paulo', 'Centro', 'Rua A', '100');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('02000-000', 'SP', 'São Paulo', 'Santana', 'Rua B', '200');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03000-000', 'SP', 'São Paulo', 'Brás', 'Rua C', '300');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04000-000', 'SP', 'São Paulo', 'Vila Mariana', 'Rua D', '400');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('05000-000', 'SP', 'São Paulo', 'Liberdade', 'Rua E', '500');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('06000-000', 'SP', 'São Paulo', 'Mooca', 'Rua F', '600');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('07000-000', 'SP', 'São Paulo', 'Itaquera', 'Rua G', '700');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('08000-000', 'SP', 'São Paulo', 'Pirituba', 'Rua H', '800');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('09000-000', 'SP', 'São Paulo', 'Tatuapé', 'Rua I', '900');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('10000-000', 'SP', 'São Paulo', 'Perdizes', 'Rua J', '1000');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('11000-000', 'SP', 'São Paulo', 'Vila Sônia', 'Rua K', '1100');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('12000-000', 'SP', 'São Paulo', 'Vila Madalena', 'Rua L', '1200');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('13000-000', 'SP', 'São Paulo', 'Butantã', 'Rua M', '1300');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('14000-000', 'SP', 'São Paulo', 'Grajaú', 'Rua N', '1400');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('15000-000', 'SP', 'São Paulo', 'Vila Olímpia', 'Rua O', '1500');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('16000-000', 'SP', 'São Paulo', 'Vila Prudente', 'Rua P', '1600');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('17000-000', 'SP', 'São Paulo', 'Campo Belo', 'Rua Q', '1700');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('18000-000', 'SP', 'São Paulo', 'Jardins', 'Rua R', '1800');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('19000-000', 'SP', 'São Paulo', 'Vila Nova Conceição', 'Rua S', '1900');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('20000-000', 'SP', 'São Paulo', 'Chácara Klabin', 'Rua T', '2000');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01001-000', 'SP', 'São Paulo', 'Centro', 'Praça da Sé', '1');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01002-000', 'SP', 'São Paulo', 'Centro', 'Rua da Consolação', '123');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01003-000', 'SP', 'São Paulo', 'Centro', 'Avenida São João', '456');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01004-000', 'SP', 'São Paulo', 'Centro', 'Rua XV de Novembro', '789');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01005-000', 'SP', 'São Paulo', 'Liberdade', 'Rua da Glória', '25');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01006-000', 'SP', 'São Paulo', 'Liberdade', 'Rua da Paz', '50');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01007-000', 'SP', 'São Paulo', 'Jardins', 'Avenida Rebouças', '200');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01008-000', 'SP', 'São Paulo', 'Vila Mariana', 'Rua Domingos de Morais', '1000');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01009-000', 'SP', 'São Paulo', 'Pinheiros', 'Rua dos Três Irmãos', '10');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01010-000', 'SP', 'São Paulo', 'Vila Madalena', 'Rua Harmonia', '300');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01011-000', 'SP', 'São Paulo', 'Bela Vista', 'Rua da Paz', '50');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01012-000', 'SP', 'São Paulo', 'Vila Gomes Cardim', 'Rua D. João VI', '15');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01013-000', 'SP', 'São Paulo', 'Mooca', 'Rua da Mooca', '170');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01014-000', 'SP', 'São Paulo', 'Itaim Bibi', 'Avenida João Cachoeira', '150');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01015-000', 'SP', 'São Paulo', 'Campo Belo', 'Rua Dr. Álvaro de Souza Lima', '400');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01016-000', 'SP', 'São Paulo', 'Vila Andrade', 'Rua João Lourenço', '250');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01017-000', 'SP', 'São Paulo', 'Tatuapé', 'Rua Serra do Japi', '23');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01018-000', 'SP', 'São Paulo', 'Itaquera', 'Rua Arnaldo de Almeida', '800');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01019-000', 'SP', 'São Paulo', 'Lapa', 'Rua Teodoro Sampaio', '900');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01020-000', 'SP', 'São Paulo', 'Jardim Paulista', 'Avenida Brigadeiro Luiz Antônio', '1800');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01021-000', 'SP', 'São Paulo', 'Vila Nova Conceição', 'Rua Domingos Ferreira', '100');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01022-000', 'SP', 'São Paulo', 'Jardins', 'Rua da Consolação', '200');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01023-000', 'SP', 'São Paulo', 'Vila Olímpia', 'Avenida Faria Lima', '1500');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01024-000', 'SP', 'São Paulo', 'Higienópolis', 'Rua Barão de Capanema', '300');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01025-000', 'SP', 'São Paulo', 'Aclimação', 'Rua Abílio Soares', '10');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01026-000', 'SP', 'São Paulo', 'Tatuapé', 'Rua Tuiuti', '50');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01027-000', 'SP', 'São Paulo', 'Saúde', 'Rua Silva Bueno', '250');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01028-000', 'SP', 'São Paulo', 'Vila Sônia', 'Rua São Paulo', '75');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01029-000', 'SP', 'São Paulo', 'Vila Maria', 'Avenida São Miguel', '130');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01030-000', 'SP', 'São Paulo', 'Campo Limpo', 'Rua Doutor Nelson G. Pinto', '400');

select * from Endereco;

-- Tabela Genero

INSERT INTO Genero (descricao) VALUES ('Masculino');
INSERT INTO Genero (descricao) VALUES ('Feminino');

select * from Genero;

-- Inserção de Dados na Tabela EnderecoPreferencia

INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02010-000', 'SP', 'São Paulo', 'Vila Mariana', 'Rua Domingos de Moraes', '500');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02020-000', 'SP', 'São Paulo', 'Itaim Bibi', 'Avenida João Dias', '150');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02030-000', 'SP', 'São Paulo', 'Alto da Lapa', 'Rua Pio XI', '800');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02040-000', 'SP', 'São Paulo', 'Morumbi', 'Rua Doutor Alberto Seabra', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02050-000', 'SP', 'São Paulo', 'Vila Clementino', 'Rua Domingos Ferreira', '150');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02060-000', 'SP', 'São Paulo', 'Vila Andrade', 'Avenida João Dias', '450');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02070-000', 'SP', 'São Paulo', 'Perdizes', 'Rua Monte Alegre', '400');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02080-000', 'SP', 'São Paulo', 'Campo Belo', 'Rua José Maria Whitaker', '550');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02090-000', 'SP', 'São Paulo', 'Pacaembu', 'Avenida Pacaembu', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02100-000', 'SP', 'São Paulo', 'Jardim Paulista', 'Rua da Consolação', '200');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02101-000', 'SP', 'São Paulo', 'Higienópolis', 'Rua Barão de Tatuí', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02102-000', 'SP', 'São Paulo', 'Jardim das Bandeiras', 'Rua Professor Carvalho', '75');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02103-000', 'SP', 'São Paulo', 'Santa Cecília', 'Avenida São João', '600');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02104-000', 'SP', 'São Paulo', 'Liberdade', 'Rua da Glória', '500');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02105-000', 'SP', 'São Paulo', 'Moema', 'Avenida Moaci', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02106-000', 'SP', 'São Paulo', 'Vila Olímpia', 'Rua dos Três Irmãos', '400');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02107-000', 'SP', 'São Paulo', 'Ipanema', 'Rua Pedro de Toledo', '250');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02108-000', 'SP', 'São Paulo', 'Vila Madalena', 'Rua Harmonia', '150');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02109-000', 'SP', 'São Paulo', 'Jardim São Paulo', 'Rua Pedro Vicente', '200');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02110-000', 'SP', 'São Paulo', 'Jardim Paulista', 'Rua Itápolis', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02111-000', 'SP', 'São Paulo', 'Pirituba', 'Rua Desembargador Paulo Duran', '350');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02112-000', 'SP', 'São Paulo', 'Brooklin', 'Rua João Freire', '400');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02113-000', 'SP', 'São Paulo', 'Cangaíba', 'Avenida Alberto Ramos', '600');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02114-000', 'SP', 'São Paulo', 'São Miguel Paulista', 'Rua Jardim São Paulo', '100');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02115-000', 'SP', 'São Paulo', 'Brás', 'Rua São Caetano', '250');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02116-000', 'SP', 'São Paulo', 'Lapa', 'Rua Guaicurus', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02117-000', 'SP', 'São Paulo', 'Saúde', 'Avenida Doutor Ricardo Jafet', '200');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02118-000', 'SP', 'São Paulo', 'Vila Mariana', 'Rua Vergueiro', '150');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02119-000', 'SP', 'São Paulo', 'Vila Formosa', 'Rua Arnaldo Pires de Almeida', '80');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02120-000', 'SP', 'São Paulo', 'Itaquera', 'Avenida Aricanduva', '1000');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02121-000', 'SP', 'São Paulo', 'Jardim São Paulo', 'Rua Álvaro Ramos', '75');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02122-000', 'SP', 'São Paulo', 'Vila Progredior', 'Rua Progresso', '250');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02123-000', 'SP', 'São Paulo', 'Tatuapé', 'Avenida Celso Garcia', '500');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02124-000', 'SP', 'São Paulo', 'Vila Carrão', 'Rua Apucarana', '200');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02125-000', 'SP', 'São Paulo', 'Vila Madalena', 'Rua João Moura', '400');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02126-000', 'SP', 'São Paulo', 'Mooca', 'Rua da Mooca', '800');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02127-000', 'SP', 'São Paulo', 'Pacaembu', 'Rua João Ramalho', '150');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02128-000', 'SP', 'São Paulo', 'Bela Vista', 'Rua da Consolação', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02129-000', 'SP', 'São Paulo', 'Barra Funda', 'Rua Peixoto Gomide', '600');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02130-000', 'SP', 'São Paulo', 'Santana', 'Rua Voluntários da Pátria', '700');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02131-000', 'SP', 'São Paulo', 'Jardim Angela', 'Rua José Rocco', '250');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02132-000', 'SP', 'São Paulo', 'Lapa', 'Rua da Lapa', '500');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02133-000', 'SP', 'São Paulo', 'Vila Pompéia', 'Rua Pompéia', '350');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02134-000', 'SP', 'São Paulo', 'Capão Redondo', 'Rua Mairiporã', '450');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02135-000', 'SP', 'São Paulo', 'Perus', 'Rua Fagundes', '600');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02136-000', 'SP', 'São Paulo', 'São Miguel', 'Rua São Miguel', '200');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02137-000', 'SP', 'São Paulo', 'Ipiranga', 'Rua do Lago', '150');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02138-000', 'SP', 'São Paulo', 'Vila Joaniza', 'Rua Eduardo Gomes', '300');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02139-000', 'SP', 'São Paulo', 'Vila Andrade', 'Rua São Bartolomeu', '400');
INSERT INTO EnderecoPreferencia (cep, estado, cidade, bairro, rua, numero) VALUES ('02140-000', 'SP', 'São Paulo', 'Tremembé', 'Rua Tremembé', '500');

select * from EnderecoPreferencia;

-- Inserts para a Tabela Turno

INSERT INTO Turno (descricao) VALUES ('Manhã');
INSERT INTO Turno (descricao) VALUES ('Tarde');
INSERT INTO Turno (descricao) VALUES ('Noite');

select * from Turno;

-- Inserts para a Tabela PreferenciaDia

INSERT INTO PreferenciaDia (dia) VALUES ('Segunda');
INSERT INTO PreferenciaDia (dia) VALUES ('Terça');
INSERT INTO PreferenciaDia (dia) VALUES ('Quarta');
INSERT INTO PreferenciaDia (dia) VALUES ('Quinta');
INSERT INTO PreferenciaDia (dia) VALUES ('Sexta');
INSERT INTO PreferenciaDia (dia) VALUES ('Sábado');
INSERT INTO PreferenciaDia (dia) VALUES ('Domingo');

select * from PreferenciaDia;

-- Inserts para a Tabela PreferenciaHorario

INSERT INTO PreferenciaHorario (horario) VALUES ('06:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('07:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('08:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('09:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('10:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('11:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('12:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('13:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('14:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('15:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('16:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('17:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('18:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('19:00');
INSERT INTO PreferenciaHorario (horario) VALUES ('20:00');

select * from PreferenciaHorario;

-- Inserts para a Tabela Cliente

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Carlos Silva', 'carlos.silva@example.com', '11987654321', TO_DATE('1990-01-15', 'YYYY-MM-DD'), 1, 1, 2, 1, 1, 1);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Maria Oliveira', 'maria.oliveira@example.com', '11987654322', TO_DATE('1985-05-20', 'YYYY-MM-DD'), 2, 2, 1, 2, 2, 12);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('João Pereira', 'joao.pereira@example.com', '11987654323', TO_DATE('1992-11-30', 'YYYY-MM-DD'), 3, 1, 2, 3, 3, 14);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Ana Costa', 'ana.costa@example.com', '11987654324', TO_DATE('1995-03-10', 'YYYY-MM-DD'), 4, 2, 1, 1, 4, 9);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Lucas Santos', 'lucas.santos@example.com', '11987654325', TO_DATE('1988-09-21', 'YYYY-MM-DD'), 5, 1, 2, 2, 5, 8);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Fernanda Lima', 'fernanda.lima@example.com', '11987654326', TO_DATE('1993-07-22', 'YYYY-MM-DD'), 6, 2, 1, 1, 1, 2);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Ricardo Almeida', 'ricardo.almeida@example.com', '11987654327', TO_DATE('1990-12-05', 'YYYY-MM-DD'), 7, 1, 2, 2, 2, 13);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Tatiane Rocha', 'tatiane.rocha@example.com', '11987654328', TO_DATE('1996-04-18', 'YYYY-MM-DD'), 8, 2, 1, 3, 3, 13);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Bruno Mendes', 'bruno.mendes@example.com', '11987654329', TO_DATE('1987-08-12', 'YYYY-MM-DD'), 9, 1, 2, 1, 4, 5);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Juliana Ferreira', 'juliana.ferreira@example.com', '11987654330', TO_DATE('1991-06-30', 'YYYY-MM-DD'), 10, 2, 1, 2, 5, 12);

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Diego Cardoso', 'diego.cardoso@example.com', '11987654331', TO_DATE('1989-02-15', 'YYYY-MM-DD'), 11, 1, 2, 3, 1, 15);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Patrícia Souza', 'patricia.souza@example.com', '11987654332', TO_DATE('1986-11-28', 'YYYY-MM-DD'), 12, 2, 1, 1, 2, 3);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Gustavo Silva', 'gustavo.silva@example.com', '11987654333', TO_DATE('1984-05-05', 'YYYY-MM-DD'), 13, 1, 2, 2, 3, 8);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Camila Lima', 'camila.lima@example.com', '11987654334', TO_DATE('1994-09-09', 'YYYY-MM-DD'), 14, 2, 1, 3, 4, 15);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Leonardo Martins', 'leonardo.martins@example.com', '11987654335', TO_DATE('1992-01-01', 'YYYY-MM-DD'), 15, 1, 2, 1, 5, 1);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Renata Barbosa', 'renata.barbosa@example.com', '11987654336', TO_DATE('1987-03-22', 'YYYY-MM-DD'), 16, 2, 1, 2, 1, 9);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Samuel Almeida', 'samuel.almeida@example.com', '11987654337', TO_DATE('1995-06-30', 'YYYY-MM-DD'), 17, 1, 2, 3, 2, 14);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Mariana Costa', 'mariana.costa@example.com', '11987654338', TO_DATE('1989-02-11', 'YYYY-MM-DD'), 18, 2, 1, 1, 3, 4);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Thiago Mendes', 'thiago.mendes@example.com', '11987654339', TO_DATE('1988-12-25', 'YYYY-MM-DD'), 19, 1, 2, 2, 4, 9);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Isabela Santos', 'isabela.santos@example.com', '11987654340', TO_DATE('1990-04-19', 'YYYY-MM-DD'), 20, 2, 1, 3, 5, 15);

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Paulo Henrique', 'paulo.henrique@example.com', '11987654341', TO_DATE('1991-08-15', 'YYYY-MM-DD'), 21, 1, 2, 1, 1, 2);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Luciana Ferreira', 'luciana.ferreira@example.com', '11987654342', TO_DATE('1986-11-28', 'YYYY-MM-DD'), 22, 2, 1, 2, 2, 12);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Felipe Carvalho', 'felipe.carvalho@example.com', '11987654343', TO_DATE('1985-10-07', 'YYYY-MM-DD'), 23, 1, 2, 3, 3, 14);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('André Oliveira', 'andre.oliveira@example.com', '11987654344', TO_DATE('1995-03-12', 'YYYY-MM-DD'), 1, 1, 1, 1, 1, 2);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Monique Silva', 'monique.silva@example.com', '11987654345', TO_DATE('1998-06-20', 'YYYY-MM-DD'), 2, 2, 2, 2, 2, 11);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Lucas Ferreira', 'lucas.ferreira@example.com', '11987654346', TO_DATE('1992-08-15', 'YYYY-MM-DD'), 3, 1, 1, 3, 3, 14);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Natália Costa', 'natalia.costa@example.com', '11987654347', TO_DATE('1994-02-05', 'YYYY-MM-DD'), 4, 2, 2, 1, 4, 5);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Rafael Gomes', 'rafael.gomes@example.com', '11987654348', TO_DATE('1993-11-30', 'YYYY-MM-DD'), 5, 1, 1, 2, 5, 11);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Sofia Santos', 'sofia.santos@example.com', '11987654349', TO_DATE('1997-07-22', 'YYYY-MM-DD'), 6, 2, 2, 3, 1, 15);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Thiago Lima', 'thiago.lima@example.com', '11987654350', TO_DATE('1988-05-11', 'YYYY-MM-DD'), 7, 1, 1, 1, 2, 3);

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Gabi Pereira', 'gabi.pereira@example.com', '11987654351', TO_DATE('1990-10-17', 'YYYY-MM-DD'), 8, 2, 2, 2, 3, 10);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Matheus Rocha', 'matheus.rocha@example.com', '11987654352', TO_DATE('1991-01-09', 'YYYY-MM-DD'), 9, 1, 1, 3, 4, 15);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Fernanda Martins', 'fernanda.martins@example.com', '11987654353', TO_DATE('1995-06-21', 'YYYY-MM-DD'), 10, 2, 2, 1, 5, 1);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Eduardo Almeida', 'eduardo.almeida@example.com', '11987654354', TO_DATE('1996-03-15', 'YYYY-MM-DD'), 11, 1, 1, 2, 1, 8);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Carla Santos', 'carla.santos@example.com', '11987654355', TO_DATE('1989-12-11', 'YYYY-MM-DD'), 12, 2, 2, 3, 2, 13);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Gabriel Costa', 'gabriel.costa@example.com', '11987654356', TO_DATE('1994-04-22', 'YYYY-MM-DD'), 13, 1, 1, 1, 3, 4);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Camila Almeida', 'camila.almeida@example.com', '11987654357', TO_DATE('1993-10-05', 'YYYY-MM-DD'), 14, 2, 2, 2, 4, 5);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Lucas Ferreira', 'lucas.ferreira@example.com', '11987654358', TO_DATE('1988-02-13', 'YYYY-MM-DD'), 15, 1, 1, 3, 5, 8);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Mariana Lima', 'mariana.lima@example.com', '11987654359', TO_DATE('1992-09-29', 'YYYY-MM-DD'), 16, 2, 2, 1, 1, 2);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('José Almeida', 'jose.almeida@example.com', '11987654360', TO_DATE('1996-07-17', 'YYYY-MM-DD'), 17, 1, 1, 2, 2, 9);

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Aline Martins', 'aline.martins@example.com', '11987654361', TO_DATE('1990-05-21', 'YYYY-MM-DD'), 18, 2, 2, 3, 3, 14);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Samuel Rocha', 'samuel.rocha@example.com', '11987654362', TO_DATE('1989-11-10', 'YYYY-MM-DD'), 19, 1, 1, 1, 4, 5);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Tânia Mendes', 'tania.mendes@example.com', '11987654363', TO_DATE('1991-08-25', 'YYYY-MM-DD'), 20, 2, 2, 2, 5, 13);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Renato Lima', 'renato.lima@example.com', '11987654364', TO_DATE('1995-04-30', 'YYYY-MM-DD'), 21, 1, 1, 3, 1, 15);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Cláudia Dias', 'claudia.dias@example.com', '11987654365', TO_DATE('1994-12-12', 'YYYY-MM-DD'), 22, 2, 2, 1, 2, 3);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Felipe Gomes', 'felipe.gomes@example.com', '11987654366', TO_DATE('1990-03-18', 'YYYY-MM-DD'), 23, 1, 1, 2, 3, 11);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Beatriz Costa', 'beatriz.costa@example.com', '11987654367', TO_DATE('1987-09-03', 'YYYY-MM-DD'), 24, 2, 2, 3, 4, 15);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Bruno Santos', 'bruno.santos@example.com', '11987654368', TO_DATE('1993-10-25', 'YYYY-MM-DD'), 25, 1, 1, 1, 5, 1);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Larissa Almeida', 'larissa.almeida@example.com', '11987654369', TO_DATE('1998-02-14', 'YYYY-MM-DD'), 26, 2, 2, 2, 1, 13);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Eduardo Silva', 'eduardo.silva@example.com', '11987654370', TO_DATE('1991-01-29', 'YYYY-MM-DD'), 27, 1, 1, 3, 2, 14);

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Patrícia Rocha', 'patricia.rocha@example.com', '11987654371', TO_DATE('1992-05-20', 'YYYY-MM-DD'), 28, 2, 2, 1, 3, 4);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Ricardo Mendes', 'ricardo.mendes@example.com', '11987654372', TO_DATE('1990-07-04', 'YYYY-MM-DD'), 29, 1, 1, 2, 4, 12);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Sérgio Santos', 'sergio.santos@example.com', '11987654374', TO_DATE('1986-03-21', 'YYYY-MM-DD'), 31, 1, 1, 1, 1, 2);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Amanda Ferreira', 'amanda.ferreira@example.com', '11987654375', TO_DATE('1995-09-18', 'YYYY-MM-DD'), 32, 2, 2, 2, 2, 3);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Tatiane Alves', 'tatiane.alves@example.com', '11987654376', TO_DATE('1990-12-01', 'YYYY-MM-DD'), 33, 2, 2, 1, 1, 12);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Juliana Rocha', 'juliana.rocha@example.com', '11987654378', TO_DATE('1992-08-10', 'YYYY-MM-DD'), 35, 2, 2, 3, 3, 4);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Gabriel Santos', 'gabriel.santos@example.com', '11987654379', TO_DATE('1988-02-24', 'YYYY-MM-DD'), 36, 1, 1, 1, 4, 5);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Ana Clara Lima', 'anaclara.lima@example.com', '11987654380', TO_DATE('1995-03-30', 'YYYY-MM-DD'), 37, 2, 2, 2, 5, 11);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Renan Mendes', 'renan.mendes@example.com', '11987654381', TO_DATE('1990-06-18', 'YYYY-MM-DD'), 38, 1, 1, 3, 1, 14);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Isabela Oliveira', 'isabela.oliveira@example.com', '11987654382', TO_DATE('1997-09-29', 'YYYY-MM-DD'), 39, 2, 2, 1, 2, 3);

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Matheus Pereira', 'matheus.pereira@example.com', '11987654383', TO_DATE('1991-01-14', 'YYYY-MM-DD'), 40, 1, 1, 2, 3, 8);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Jéssica Costa', 'jessica.costa@example.com', '11987654384', TO_DATE('1994-04-11', 'YYYY-MM-DD'), 41, 2, 2, 3, 4, 15);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Thiago Martins', 'thiago.martins@example.com', '11987654385', TO_DATE('1996-11-05', 'YYYY-MM-DD'), 42, 1, 1, 1, 5, 1);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Simone Nascimento', 'simone.nascimento@example.com', '11987654386', TO_DATE('1989-02-20', 'YYYY-MM-DD'), 43, 2, 2, 2, 1, 12);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Fernando Almeida', 'fernando.almeida@example.com', '11987654387', TO_DATE('1993-07-17', 'YYYY-MM-DD'), 44, 1, 1, 3, 2, 14);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Camila Gomes', 'camila.gomes@example.com', '11987654388', TO_DATE('1992-10-24', 'YYYY-MM-DD'), 45, 2, 2, 1, 3, 4);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('João Vitor Sousa', 'joaovitor.sousa@example.com', '11987654389', TO_DATE('1995-08-15', 'YYYY-MM-DD'), 46, 1, 1, 2, 4, 8);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Larissa Martins', 'larissa.martins@example.com', '11987654390', TO_DATE('1987-03-09', 'YYYY-MM-DD'), 47, 2, 2, 3, 5, 15);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('André Santos', 'andre.santos@example.com', '11987654391', TO_DATE('1994-12-28', 'YYYY-MM-DD'), 48, 1, 1, 1, 1, 2);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Bianca Rodrigues', 'bianca.rodrigues@example.com', '11987654392', TO_DATE('1990-06-15', 'YYYY-MM-DD'), 49, 2, 2, 2, 2, 13);

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Eduarda Ferreira', 'eduarda.ferreira@example.com', '11987654393', TO_DATE('1989-09-10', 'YYYY-MM-DD'), 50, 1, 1, 3, 3, 14);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Ana Clara', 'ana.clara@example.com', '11999999902', TO_DATE('1995-02-20', 'YYYY-MM-DD'), 2, 2, 3, 2, 2, 12);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('João Paulo', 'joao.paulo@example.com', '11999999903', TO_DATE('1988-03-25', 'YYYY-MM-DD'), 3, 1, 4, 1, 3, 3);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Mariana Ferreira', 'mariana.ferreira@example.com', '11999999904', TO_DATE('1992-04-30', 'YYYY-MM-DD'), 4, 2, 1, 2, 4, 13);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Carla Mendes', 'carla.mendes@example.com', '11999999906', TO_DATE('1993-06-10', 'YYYY-MM-DD'), 6, 2, 4, 2, 1, 12);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Ricardo Oliveira', 'ricardo.oliveira@example.com', '11999999907', TO_DATE('1987-07-15', 'YYYY-MM-DD'), 7, 1, 2, 1, 2, 3);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Juliana Costa', 'juliana.costa@example.com', '11999999908', TO_DATE('1991-08-20', 'YYYY-MM-DD'), 8, 2, 1, 2, 3, 9);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Roberto Silva', 'roberto.silva@example.com', '11999999909', TO_DATE('1986-09-25', 'YYYY-MM-DD'), 9, 1, 3, 1, 4, 1);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Patrícia Lima', 'patricia.lima@example.com', '11999999910', TO_DATE('1994-10-30', 'YYYY-MM-DD'), 10, 2, 4, 2, 5, 10);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Marcos Paulo', 'marcos.paulo@example.com', '11999999911', TO_DATE('1983-11-05', 'YYYY-MM-DD'), 11, 1, 1, 1, 6, 3);

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Fernanda Sousa', 'fernanda.sousa@example.com', '11999999912', TO_DATE('1990-12-10', 'YYYY-MM-DD'), 12, 2, 2, 2, 7, 12);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Vinícius Cardoso', 'vinicius.cardoso@example.com', '11999999913', TO_DATE('1992-01-15', 'YYYY-MM-DD'), 13, 1, 3, 1, 1, 1);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Beatriz Rocha', 'beatriz.rocha@example.com', '11999999914', TO_DATE('1989-02-20', 'YYYY-MM-DD'), 14, 2, 4, 2, 2, 12);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Diego Nascimento', 'diego.nascimento@example.com', '11999999915', TO_DATE('1988-03-25', 'YYYY-MM-DD'), 15, 1, 1, 1, 3, 3);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Sofia Almeida', 'sofia.almeida@example.com', '11999999916', TO_DATE('1994-04-30', 'YYYY-MM-DD'), 16, 2, 2, 2, 4, 9);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Isabela Dias', 'isabela.dias@example.com', '11999999918', TO_DATE('1987-06-10', 'YYYY-MM-DD'), 18, 2, 4, 2, 1, 10);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Amanda Ribeiro', 'amanda.ribeiro@example.com', '11999999920', TO_DATE('1995-08-20', 'YYYY-MM-DD'), 20, 2, 1, 2, 3, 4);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Leandro Pires', 'leandro.pires@example.com', '11999999921', TO_DATE('1992-09-15', 'YYYY-MM-DD'), 21, 1, 2, 1, 1, 1);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Juliana Martins', 'juliana.martins@example.com', '11999999922', TO_DATE('1990-10-20', 'YYYY-MM-DD'), 22, 2, 3, 2, 2, 13);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Victor Hugo', 'victor.hugo@example.com', '11999999923', TO_DATE('1988-11-25', 'YYYY-MM-DD'), 23, 1, 4, 1, 3, 3);

INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Natalia Silva', 'natalia.silva@example.com', '11999999924', TO_DATE('1993-12-30', 'YYYY-MM-DD'), 24, 2, 1, 2, 4, 13);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Fábio Costa', 'fabio.costa@example.com', '11999999925', TO_DATE('1985-01-05', 'YYYY-MM-DD'), 25, 1, 2, 1, 5, 1);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Simone Rocha', 'simone.rocha@example.com', '11999999926', TO_DATE('1991-02-10', 'YYYY-MM-DD'), 26, 2, 3, 2, 1, 12);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Henrique Almeida', 'henrique.almeida@example.com', '11999999927', TO_DATE('1994-03-15', 'YYYY-MM-DD'), 27, 1, 4, 1, 2, 3);
INSERT INTO Cliente (nome_completo, email, telefone, data_nasc, fk_id_endereco, fk_id_genero, fk_id_endereco_preferencia, fk_id_turno, fk_id_preferencia_dia, fk_id_preferencia_horario) VALUES ('Tânia Martins', 'tania.martins@example.com', '11999999928', TO_DATE('1990-04-20', 'YYYY-MM-DD'), 28, 2, 1, 2, 3, 8);

select * from Cliente;

-- Montar query e gerar uma tabela fato_cliente
SELECT 
    c.id_cliente,
    c.nome_completo,
    c.email,
    c.telefone,
    TO_CHAR(c.data_nasc, 'YYYY-MM-DD') AS data_nasc,
    e.cep,
    e.estado,
    e.cidade,
    e.bairro,
    e.rua,
    e.numero AS numero_endereco,
    ep.cep AS cep_preferencia,
    ep.estado AS estado_preferencia,
    ep.cidade AS cidade_preferencia,
    ep.bairro AS bairro_preferencia,
    ep.rua AS rua_preferencia,
    ep.numero AS numero_endereco_preferencia,
    t.descricao AS turno,
    pd.dia AS dia_preferencia,
    ph.horario AS horario_preferencia
FROM 
    Cliente c
LEFT JOIN 
    Endereco e ON c.fk_id_endereco = e.id_endereco
LEFT JOIN 
    EnderecoPreferencia ep ON c.fk_id_endereco_preferencia = ep.id_endereco_preferencia
LEFT JOIN 
    Turno t ON c.fk_id_turno = t.id_turno
LEFT JOIN 
    PreferenciaDia pd ON c.fk_id_preferencia_dia = pd.id_preferencia_dia
LEFT JOIN 
    PreferenciaHorario ph ON c.fk_id_preferencia_horario = ph.id_preferencia_horario

WHERE c.id_cliente BETWEEN 91 AND 99

ORDER BY c.id_cliente asc;
