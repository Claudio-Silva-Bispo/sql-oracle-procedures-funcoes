
// 1. Limpar o banco antes de tudo
-- Deletar tabelas caso já existam

-- Fluxo Cliente
DROP TABLE Endereco CASCADE CONSTRAINTS;
DROP TABLE Genero CASCADE CONSTRAINTS;
DROP TABLE EnderecoPreferencia CASCADE CONSTRAINTS;
DROP TABLE Turno CASCADE CONSTRAINTS;
DROP TABLE PreferenciaDia CASCADE CONSTRAINTS;
DROP TABLE PreferenciaHorario CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;

-- Fluxo Clinica
DROP TABLE Especialidade CASCADE CONSTRAINTS;
DROP TABLE Especialista CASCADE CONSTRAINTS;
DROP TABLE Clinica CASCADE CONSTRAINTS;
DROP TABLE ClinicaTurno CASCADE CONSTRAINTS;
DROP TABLE ClinicaDia CASCADE CONSTRAINTS;
DROP TABLE ClinicaHorario CASCADE CONSTRAINTS;
DROP TABLE ClinicaEspecialidade CASCADE CONSTRAINTS;
DROP TABLE ClinicaEspecialista CASCADE CONSTRAINTS;

-- Fluxo Feedback
DROP TABLE Feedback CASCADE CONSTRAINTS;

// 2. Criar tabelas para fluxo de Cliente

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


// 3. Criar tabelas para fluxo da Clinica

-- Criação da Tabela Especialidade

CREATE TABLE Especialidade (
    id_especialidade INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL CONSTRAINT especialidade_unique UNIQUE -- Nome da especialidade
);


-- Criação da Tabela Especialista

CREATE TABLE Especialista (
    id_especialista INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    crm VARCHAR2(20) NOT NULL CONSTRAINT crm_unique UNIQUE, -- Registro do conselho regional de medicina
    fk_id_especialidade INTEGER, -- FK para a tabela Especialidade
    CONSTRAINT fk_especialidade FOREIGN KEY (fk_id_especialidade) REFERENCES Especialidade(id_especialidade)
);

-- Criação da Tabela Clinica

CREATE TABLE Clinica (
    id_clinica INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    telefone VARCHAR2(20) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    fk_id_endereco INTEGER, -- FK para a tabela Endereco
    CONSTRAINT fk_endereco FOREIGN KEY (fk_id_endereco) REFERENCES Endereco(id_endereco)
);



// Tabelas de relacionamento de Muitos para Muitos

-- ClinicaTurno para estabelecer relação entre os turnos que ela atende (Clinica e tabela Turno)

CREATE TABLE ClinicaTurno (
    id_clinica INTEGER,
    id_turno INTEGER,
    CONSTRAINT fk_clinica FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_turno FOREIGN KEY (id_turno) REFERENCES Turno(id_turno),
    PRIMARY KEY (id_clinica, id_turno)
);

-- Esta tabela relaciona Clinica com PreferenciaDia

CREATE TABLE ClinicaDia (
    id_clinica INTEGER,
    id_preferencia_dia INTEGER,
    CONSTRAINT fk_clinica_relacionamento FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_dia_relacionamento FOREIGN KEY (id_preferencia_dia) REFERENCES PreferenciaDia(id_preferencia_dia),
    PRIMARY KEY (id_clinica, id_preferencia_dia)
);

-- Esta tabela relaciona Clinica com PreferenciaHorario

CREATE TABLE ClinicaHorario (
    id_clinica INTEGER,
    id_preferencia_horario INTEGER,
    CONSTRAINT fk_clinica_relacionamento_horario FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_horario_relacionamento FOREIGN KEY (id_preferencia_horario) REFERENCES PreferenciaHorario(id_preferencia_horario),
    PRIMARY KEY (id_clinica, id_preferencia_horario)
);

-- Esta tabela relaciona Clinica com Especialidade

CREATE TABLE ClinicaEspecialidade (
    id_clinica INTEGER,
    id_especialidade INTEGER,
    CONSTRAINT fk_clinica_relacionamento_especialidade FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_especialidade_relacionamento FOREIGN KEY (id_especialidade) REFERENCES Especialidade(id_especialidade),
    PRIMARY KEY (id_clinica, id_especialidade)
);

-- Esta tabela relaciona Clinica com Especialista

CREATE TABLE ClinicaEspecialista (
    id_clinica INTEGER,
    id_especialista INTEGER,
    CONSTRAINT fk_clinica_relacionamento_especialista FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_especialista_relacionamento_especialista FOREIGN KEY (id_especialista) REFERENCES Especialista(id_especialista),
    PRIMARY KEY (id_clinica, id_especialista)
);

// 4. Criar tabelas para fluxo de Feedabck

-- Criação da Tabela Feedback

CREATE TABLE Feedback (
    id_feedback INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    fk_id_cliente INTEGER NOT NULL,
    fk_id_especialista INTEGER NOT NULL,
    fk_id_clinica INTEGER NOT NULL,
    nota INTEGER NOT NULL, -- nota de 1 até 5
    comentario VARCHAR2(250), -- descrição do feedback
  
    CONSTRAINT fk_feedback_cliente FOREIGN KEY (fk_id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_feedback_clinica FOREIGN KEY (fk_id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_feedback_especialista FOREIGN KEY (fk_id_especialista) REFERENCES Dentista(id_dentista)
);


// 3. Inserir dados

-- Inserindo dados na tabela Endereco

INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('01000-000', 'SP', 'São Paulo', 'Centro', 'Avenida São João', '100');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('02000-000', 'SP', 'São Paulo', 'Santana', 'Rua Voluntários da Pátria', '200');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('03000-000', 'SP', 'São Paulo', 'Brás', 'Rua da Glória', '300');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('04000-000', 'SP', 'São Paulo', 'Vila Mariana', 'Avenida Dom José de Barros', '400');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('05000-000', 'SP', 'São Paulo', 'Liberdade', 'Rua da Liberdade', '500');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('06000-000', 'SP', 'São Paulo', 'Moema', 'Avenida Moaci', '600');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('07000-000', 'SP', 'São Paulo', 'Tatuapé', 'Rua Tuiuti', '700');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('08000-000', 'SP', 'São Paulo', 'Itaquera', 'Rua São Miguel', '800');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('09000-000', 'SP', 'São Paulo', 'Osasco', 'Avenida dos Autonomistas', '900');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('10000-000', 'SP', 'São Paulo', 'Pinheiros', 'Rua dos Três Irmãos', '101');

select * from Endereco;

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

-- Inserts para a Tabela Especialidade

INSERT INTO Especialidade (nome) VALUES ('Odontologia');
INSERT INTO Especialidade (nome) VALUES ('Ortodontia');
INSERT INTO Especialidade (nome) VALUES ('Endodontia');
INSERT INTO Especialidade (nome) VALUES ('Periodontia');
INSERT INTO Especialidade (nome) VALUES ('Implantodontia');
INSERT INTO Especialidade (nome) VALUES ('Cirurgia Bucomaxilofacial');
INSERT INTO Especialidade (nome) VALUES ('Pediatria Odontológica');
INSERT INTO Especialidade (nome) VALUES ('Odontologia Estética');
INSERT INTO Especialidade (nome) VALUES ('Dentística');
INSERT INTO Especialidade (nome) VALUES ('Prostodontia');

select * from Especialidade;

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

select * from EnderecoPreferencia;

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

select * from Cliente;

-- Inserts para a Tabela Especialista

INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dr. João Silva', '123456', 1);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dra. Maria Oliveira', '234567', 2);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dr. Carlos Santos', '345678', 3);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dra. Ana Costa', '456789', 4);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dr. Pedro Almeida', '567890', 5);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dra. Fernanda Lima', '678901', 6);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dr. Roberto Ferreira', '789012', 7);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dra. Juliana Rocha', '890123', 8);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dr. Ricardo Mendes', '901234', 9);
INSERT INTO Especialista (nome, crm, fk_id_especialidade) VALUES ('Dra. Tatiane Martins', '012345', 10);

select * from Especialista;

-- Inserts para a Tabela Clinica

INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Saúde e Sorriso', '11-1234-5678', 'contato@saudesorriso.com.br', 1);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica OdontoPlus', '11-2345-6789', 'contato@odontoplus.com.br', 2);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Bem Estar', '11-3456-7890', 'info@bemenstar.com.br', 3);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica DentalCare', '11-4567-8901', 'suporte@dentalcare.com.br', 4);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso Feliz', '11-5678-9012', 'atendimento@sorrisofeliz.com.br', 5);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Nova Vida', '11-6789-0123', 'contato@novavida.com.br', 6);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica OdontoCenter', '11-7890-1234', 'info@odontocenter.com.br', 7);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Família Saudável', '11-8901-2345', 'contato@familiasaudavel.com.br', 8);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Sorriso do Futuro', '11-9012-3456', 'suporte@sorrisodofuturo.com.br', 9);
INSERT INTO Clinica (nome, telefone, email, fk_id_endereco) VALUES ('Clínica Vida Nova', '11-0123-4567', 'contato@vidanova.com.br', 10);

select * from Clinica;

-- Inserts para a Tabela Feedback

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 5, 'Excelente atendimento!');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 2, 4, 'Bom serviço, mas o tempo de espera foi longo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 3, 3, 'Atendimento razoável, poderia ser melhor.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 4, 4, 2, 'Não fiquei satisfeito com o atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 5, 5, 1, 'Péssimo serviço, não recomendo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 6, 6, 5, 'Ótimo, super recomendo!');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 7, 7, 4, 'Bom atendimento, mas poderia melhorar a comunicação.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 8, 8, 3, 'Regular, atendeu as minhas necessidades.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 9, 9, 5, 'Melhor especialista que já fui, super atencioso!');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 10, 10, 2, 'O especialista estava apressado, não gostei muito.');

select * from Feedback;




INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 1, 'Atendimento horrível.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 1, 'Muito tempo de espera e atendimento ruim.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 1, 'Não fui bem atendido.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 1, 2, 1, 'Não recomendo, péssima experiência.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 2, 2, 1, 'Desorganização total.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 3, 2, 1, 'Fui ignorado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 1, 3, 1, 'O atendimento foi muito ruim.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 2, 3, 1, 'Não gostei, total falta de profissionalismo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 3, 3, 1, 'Não resolveram o meu problema.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 1, 1, 1, 'Atendimento péssimo, demorado e sem qualidade.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 1, 1, 'A clínica estava suja.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 3, 1, 1, 'Não voltaria nunca.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 1, 2, 1, 'Completamente insatisfeito com o serviço.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 2, 2, 1, 'Não consegui resolver meu problema com eles.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 3, 2, 1, 'Muito insatisfeito com o atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 1, 3, 1, 'Falta de respeito com o cliente.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 2, 3, 1, 'Pior consulta que já tive.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 3, 3, 1, 'Profissional despreparado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 1, 1, 1, 'Atendimento muito aquém do esperado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 2, 1, 1, 'Atendimento razoável.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 1, 1, 'Uma experiência desastrosa.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 1, 1, 2, 'Esperava mais do atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 2, 1, 2, 'Fui atendido, mas com muitos problemas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 3, 1, 2, 'Não foi um bom atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 1, 2, 2, 'Serviço abaixo do esperado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 2, 2, 2, 'Atendimento razoável, mas com falhas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 3, 2, 2, 'Pouca atenção aos detalhes.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 1, 3, 2, 'Atendimento muito corrido e sem cuidado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 2, 3, 2, 'Demorou muito para ser atendido.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 3, 3, 2, 'O atendimento não foi satisfatório.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 2, 'Faltou organização e eficiência.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 2, 'Experiência decepcionante.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 2, 'Muitos atrasos e pouca atenção.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 1, 2, 2, 'Achei que poderiam ser mais atenciosos.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 2, 2, 2, 'Serviço ok, mas com margem para melhora.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 3, 2, 2, 'Faltou profissionalismo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 1, 3, 2, 'Serviço lento e desorganizado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 2, 3, 2, 'Demoraram muito para me atender.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 3, 3, 2, 'Pouco cuidado e atenção durante a consulta.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 1, 1, 2, 'Faltou atenção ao cliente.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 2, 'Deixou a desejar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 1, 1, 2, 'Não fiquei satisfeito com o serviço.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 1, 1, 3, 'Atendimento razoável, mas pode melhorar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 1, 1, 3, 'Não foi ruim, mas esperava mais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 1, 1, 3, 'O serviço foi mediano.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 1, 2, 3, 'Tudo ocorreu de forma aceitável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 2, 2, 3, 'Nada de especial, atendimento ok.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 3, 2, 3, 'Foi uma experiência regular.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 1, 3, 3, 'Atendimento dentro do esperado.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 3, 3, 'Consulta mediana, sem grandes problemas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 3, 3, 3, 'O serviço foi ok, sem nada demais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 1, 1, 3, 'Atendimento regular, nada de mais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 2, 1, 3, 'Foi tudo bem, mas podia ser melhor.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 3, 1, 3, 'Consulta normal, nada excepcional.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 1, 2, 3, 'Atendimento regular, sem grandes problemas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 2, 2, 3, 'Foi uma consulta ok, mas poderia melhorar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 3, 2, 3, 'Tudo dentro do esperado, mas nada de especial.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 1, 3, 3, 'Esperava um pouco mais, mas foi razoável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 2, 3, 3, 'Consulta normal, sem problemas graves.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 1, 4, 'Bom atendimento e profissionalismo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 3, 1, 4, 'Gostei bastante do atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 1, 2, 4, 'Fui bem atendido e fiquei satisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 2, 2, 4, 'Ambiente agradável e atendimento de qualidade.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 3, 2, 4, 'Muito bom, com certeza voltarei.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 1, 3, 4, 'Experiência bem positiva.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 2, 3, 4, 'Fui bem atendido, consulta eficiente.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 3, 1, 4, 'Profissional atencioso, tudo foi ótimo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 1, 1, 4, 'Gostei muito da atenção que recebi.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 2, 1, 4, 'Consulta boa e sem problemas.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 2, 4, 'Atendimento muito satisfatório.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 3, 2, 4, 'Bom atendimento e ambiente limpo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 1, 3, 4, 'Muito bom, recomendo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 2, 3, 4, 'Consulta boa e sem complicações.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 3, 3, 4, 'Atendimento bom e rápido.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 1, 1, 4, 'Muito satisfeito com o atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 2, 1, 4, 'Profissional bem preparado, foi tudo ótimo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 1, 1, 5, 'Atendimento excelente, recomendo!');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 2, 1, 5, 'Ótima experiência, fui muito bem atendido.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 3, 1, 5, 'Profissionais muito atenciosos e capacitados.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 2, 5, 'Muito satisfeito com a qualidade do serviço.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 3, 2, 5, 'Atendimento excepcional, vou voltar com certeza.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 1, 3, 5, 'Excelente atendimento, equipe muito qualificada.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 2, 3, 5, 'O serviço foi perfeito, melhor clínica que já fui.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 3, 3, 5, 'Muito satisfeito, atendimento de primeira.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 1, 1, 5, 'Equipe muito atenciosa e tratamento de alta qualidade.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 2, 1, 5, 'Tudo impecável, recomendo fortemente.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 3, 1, 5, 'Atendimento excelente, fui muito bem recebido.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 1, 2, 5, 'Muito satisfeito, atendimento exemplar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 2, 2, 5, 'Ótimo atendimento, nota 10.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 3, 2, 5, 'Serviço de excelência, sem defeitos.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 1, 3, 5, 'Excelente atendimento, com certeza recomendo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 2, 3, 5, 'Consulta perfeita, tudo correu muito bem.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 3, 3, 5, 'Ótimo atendimento, muito satisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 1, 1, 5, 'Atendimento nota 10, recomendo para todos.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 2, 1, 5, 'Atendimento excelente, superou minhas expectativas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 1, 1, 3, 'O atendimento foi suficiente, mas sem grandes surpresas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 2, 1, 3, 'Foi razoável, mas poderia ter sido mais atencioso.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 3, 1, 3, 'A consulta foi aceitável, porém com melhorias a fazer.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 1, 2, 3, 'O serviço foi regular, sem muito destaque.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (11, 2, 2, 3, 'Atendimento foi mediano, podia ter mais atenção.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 3, 2, 3, 'Consulta razoável, mas poderia melhorar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 1, 3, 3, 'O atendimento foi ok, mas nada de especial.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 2, 3, 3, 'Consulta normal, atendimento básico.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 3, 3, 3, 'Foi dentro do esperado, sem grandes problemas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 1, 1, 3, 'A consulta foi ok, mas não houve nada de diferente.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 2, 1, 3, 'Fui atendido, mas o serviço foi apenas razoável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 3, 1, 3, 'Atendimento dentro do padrão, mas sem grandes qualidades.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 1, 2, 3, 'O serviço foi ok, mas não me surpreendeu.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 2, 2, 3, 'Foi um atendimento simples, sem grandes diferenciais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 3, 2, 3, 'Consulta foi regular, mas nada impressionante.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 3, 3, 'Atendimento padrão, nada de novo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 3, 3, 3, 'Fui atendido de maneira adequada, mas sem destaques.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 3, 'Atendimento simples, razoável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 1, 3, 'Consulta foi ok, mas com alguns pontos a melhorar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 4, 'Consulta agradável e bom atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 1, 4, 'Foi um bom serviço, estou satisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 3, 1, 4, 'Fiquei satisfeito com o atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 2, 4, 'O atendimento foi bom, tudo correu bem.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 2, 2, 4, 'Ambiente agradável e ótimo serviço.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 3, 2, 4, 'Muito satisfeito com o resultado da consulta.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 3, 4, 'Ótima consulta, serviço de qualidade.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 4, 'Atendimento foi muito bom, gostei.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 5, 'Consulta realizada com sucesso, muito bom.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 4, 'Atendimento foi muito positivo, recomendo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 1, 2, 3, 'Tudo ocorreu conforme o esperado, ótimo serviço.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (5, 2, 2, 5, 'Profissionais atenciosos, gostei muito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (6, 3, 2, 4, 'Bom atendimento, recomendo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (7, 1, 3, 4, 'Consulta agradável, serviço bom.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (8, 2, 3, 5, 'Gostei bastante do atendimento, foi muito bom.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (9, 3, 3, 4, 'Fui bem atendido e me senti confortável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (10, 1, 1, 3, 'Atendimento foi bom, tudo tranquilo.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 4, 'Muito bom, serviço de qualidade.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 4, 'Profissionais bem preparados, ótimo atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 5, 'Atendimento perfeito, nada a reclamar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 5, 'Fui muito bem atendido, excelente equipe.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 5, 'Ótima consulta, profissionais capacitados.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 2, 5, 'Equipe maravilhosa, fui muito bem recebido.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 2, 5, 'Atendimento excepcional, superou expectativas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 2, 5, 'Clínica de excelência, adorei o atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 3, 5, 'Muito bom, atendimento impecável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 3, 5, 'Serviço incrível, tudo perfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 3, 5, 'Consulta excelente, recomendaria a todos.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 5, 'Fiquei muito satisfeito, foi perfeito.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 5, 'Profissionais de alto nível, atendimento impecável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 5, 'Fui extremamente bem tratado, perfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 2, 5, 'Atendimento maravilhoso, melhor impossível.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 2, 5, 'Clínica excelente, tudo impecável.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 2, 5, 'Fui tratado com muito cuidado, excelente.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 3, 5, 'Serviço excepcional, nota máxima.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 3, 5, 'Consulta excelente, recomendo a todos.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 3, 5, 'Profissionais altamente qualificados.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 5, 'Experiência incrível, sem falhas.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 5, 'Atendimento perfeito, super recomendo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 1, 'Atendimento péssimo, não recomendo.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 1, 'Consulta horrível, muito insatisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 1, 'Não gostei, atendimento terrível.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 2, 1, 'Muito ruim, falta de profissionalismo.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 2, 1, 'Total falta de atenção, não volto mais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 2, 1, 'Fui muito mal atendido, péssimo serviço.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 3, 1, 'Atendimento desastroso, não recomendo a ninguém.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 3, 1, 'Consulta completamente insatisfatória.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 3, 1, 'Horrível, a pior consulta que já fiz.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 1, 'Foi péssimo, não volto mais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 1, 'Experiência horrível, fiquei muito insatisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 1, 'Atendimento abaixo de qualquer expectativa, péssimo.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 2, 1, 'Serviço terrível, total falta de atenção.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 2, 1, 'Péssimo atendimento, saí muito insatisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 2, 1, 'Não fui bem tratado, atendimento horrível.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 3, 1, 'Consulta ruim, péssimo ambiente.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 3, 1, 'Horrível, não recomendo para ninguém.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 3, 1, 'Experiência péssima, fiquei muito decepcionado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 1, 'Total falta de respeito com o paciente.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 1, 'Atendimento horrível, jamais voltarei.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 2, 'Atendimento fraco, faltou cuidado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 2, 'Consulta deixou muito a desejar.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 2, 'Não foi uma boa experiência, bastante ruim.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 2, 2, 'Atendimento fraco, esperava mais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 2, 2, 'O serviço foi ruim, faltou atenção.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 2, 2, 'Consulta abaixo do esperado, atendimento ruim.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 3, 2, 'Serviço ruim, não fiquei satisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 3, 2, 'Foi um atendimento ruim, não volto mais.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 3, 2, 'Faltou atenção e cuidado, atendimento ruim.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 1, 2, 'Consulta ruim, esperava mais cuidado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 1, 2, 'Atendimento muito fraco, fiquei decepcionado.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 3, 1, 2, 'Serviço ruim, não volto mais a essa clínica.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (1, 1, 2, 2, 'Consulta fraca, faltou atenção do dentista.');

INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 2, 2, 2, 'Experiência ruim, muito insatisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (2, 3, 2, 2, 'Não foi bom, faltou mais cuidado no atendimento.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 1, 3, 2, 'Consulta decepcionante, serviço ruim.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (3, 2, 3, 2, 'O atendimento foi fraco, fiquei insatisfeito.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 3, 3, 2, 'Não gostei da consulta, serviço ruim.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 1, 1, 2, 'Foi um atendimento ruim, faltou atenção.');
INSERT INTO Feedback (fk_id_cliente, fk_id_especialista, fk_id_clinica, nota, comentario) VALUES (4, 2, 1, 2, 'Consulta ruim, esperava mais cuidado.');


SELECT f.id_feedback, f.fk_id_cliente, f.fk_id_especialista, f.fk_id_clinica, f.nota, f.comentario,
       c.nome_completo AS nome_cliente,
       d.nome AS nome_dentista,
       cl.nome AS nome_clinica
FROM Feedback f
JOIN Cliente c ON f.fk_id_cliente = c.id_cliente
JOIN Especialista d ON f.fk_id_especialista = d.id_especialista
JOIN Clinica cl ON f.fk_id_clinica = cl.id_clinica

ORDER BY f.id_feedback;
