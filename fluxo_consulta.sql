
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

-- Fluxo Consulta

DROP TABLE Consulta CASCADE CONSTRAINTS;
DROP TABLE TipoServico CASCADE CONSTRAINTS;
DROP TABLE Tratamento CASCADE CONSTRAINTS;
DROP TABLE Retorno CASCADE CONSTRAINTS;
DROP TABLE StatusFeedback CASCADE CONSTRAINTS;
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



// 4. Tabela Consulta que será o principal aqui - Para ter a consulta, precisa do Cliente e da Clinica.

-- Criação da Tabela TipoServico

CREATE TABLE TipoServico (
    id_tipo_servico INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao_tipo_servico VARCHAR2(100) NOT NULL -- 'presencial' ou 'remoto'
);

-- Criação da Tabela Tratamento

CREATE TABLE Tratamento (
    id_tratamento INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao_tratamento VARCHAR2(255) NOT NULL
);

-- Criação da Tabela Retorno

CREATE TABLE Retorno (
    id_retorno INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao_retorno VARCHAR2(50) NOT NULL -- 'Sim' ou 'Não'
);

-- Criação da Tabela Status Feedback

CREATE TABLE StatusFeedback (
    id_status_feedback INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao_status VARCHAR2(50) NOT NULL -- 'Respondido' ou 'Não Respondido'
);

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

-- Criação da Tabela Consulta

CREATE TABLE Consulta (
    id_consulta INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    fk_id_cliente INTEGER NOT NULL, 
    fk_id_clinica INTEGER NOT NULL, 
    fk_id_especialista INTEGER NOT NULL,
    fk_id_especialidade INTEGER NOT NULL,
    fk_id_tipo_servico VARCHAR2(100) NOT NULL, -- presencial ou remoto
    data_consulta TIMESTAMP NOT NULL, 
    fk_id_tratamento VARCHAR2(250), -- lista com possiveis tratamentos
    custo DECIMAL(10, 2),
    fk_id_retorno INTEGER, -- se sim ou não. se sim, vai pedir data do retorno.
    data_retorno DATE,
    fk_id_status_feedback INTEGER, -- se foi respondido ou não
    fk_id_feedback INTEGER, -- referência ao feedback dado

    CONSTRAINT fk_consulta_cliente FOREIGN KEY (fk_id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_consulta_clinica FOREIGN KEY (fk_id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_consulta_especialista FOREIGN KEY (fk_id_especialista) REFERENCES Dentista(id_dentista),
    CONSTRAINT fk_consulta_feedback FOREIGN KEY (fk_id_feedback) REFERENCES Feedback(id_feedback),
    CONSTRAINT fk_consulta_retorno FOREIGN KEY (fk_id_retorno) REFERENCES Retorno(id_retorno),
    CONSTRAINT fk_consulta_status_feedback FOREIGN KEY (fk_id_status_feedback) REFERENCES StatusFeedback(id_status_feedback)
);

// 5. Inserir dados para consulta

-- Inserindo dados na tabela TipoServico

INSERT INTO TipoServico (descricao_tipo_servico) VALUES ('presencial');
INSERT INTO TipoServico (descricao_tipo_servico) VALUES ('remoto');

-- Inserindo dados na tabela Tratamento

INSERT INTO Tratamento (descricao_tratamento) VALUES ('Limpeza Dental');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Restauração');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Canal');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Extração');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Apicoectomia');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Ortodontia');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Clareamento Dental');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Prótese');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Tratamento de Gengivite');
INSERT INTO Tratamento (descricao_tratamento) VALUES ('Reimplante Dentário');

-- Inserindo dados na tabela Retorno

INSERT INTO Retorno (descricao_retorno) VALUES ('Sim');
INSERT INTO Retorno (descricao_retorno) VALUES ('Não');

-- Inserindo dados na tabela StatusFeedback

INSERT INTO StatusFeedback (descricao_status) VALUES ('Respondido');
INSERT INTO StatusFeedback (descricao_status) VALUES ('Não Respondido');

-- Inserindo dados na tabela Consulta

INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (1, 1, 1, 1, 'presencial', TO_TIMESTAMP('2024-10-21 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Limpeza', 100.00, 1, TO_DATE('2024-11-21', 'YYYY-MM-DD'), 1, 1);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (2, 2, 2, 2, 'remoto', TO_TIMESTAMP('2024-10-22 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Avaliação', 80.00, 1, TO_DATE('2024-11-22', 'YYYY-MM-DD'), 1, 2);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (3, 3, 3, 3, 'presencial', TO_TIMESTAMP('2024-10-23 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Consulta Geral', 150.00, 2, TO_DATE('2024-11-23', 'YYYY-MM-DD'), 2, 3);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (4, 4, 4, 4, 'remoto', TO_TIMESTAMP('2024-10-24 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Tratamento', 200.00, 2, TO_DATE('2024-11-24', 'YYYY-MM-DD'), 2, 4);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (5, 5, 5, 5, 'presencial', TO_TIMESTAMP('2024-10-25 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Exame', 120.00, 1, TO_DATE('2024-11-25', 'YYYY-MM-DD'), 1, 5);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (6, 6, 6, 6, 'remoto', TO_TIMESTAMP('2024-10-26 13:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Acompanhamento', 90.00, 1, TO_DATE('2024-11-26', 'YYYY-MM-DD'), 1, 6);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (7, 7, 7, 7, 'presencial', TO_TIMESTAMP('2024-10-27 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Limpeza', 100.00, 2, TO_DATE('2024-11-27', 'YYYY-MM-DD'), 2, 7);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (8, 8, 8, 8, 'remoto', TO_TIMESTAMP('2024-10-28 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Avaliação', 80.00, 2, TO_DATE('2024-11-28', 'YYYY-MM-DD'), 2, 8);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (9, 9, 9, 9, 'presencial', TO_TIMESTAMP('2024-10-29 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Consulta Geral', 150.00, 1, TO_DATE('2024-11-29', 'YYYY-MM-DD'), 1, 9);
INSERT INTO Consulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_especialidade, fk_id_tipo_servico, data_consulta, fk_id_tratamento, custo, fk_id_retorno, data_retorno, fk_id_status_feedback, fk_id_feedback) VALUES (10, 10, 10, 10, 'remoto', TO_TIMESTAMP('2024-10-30 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Tratamento', 200.00, 1, TO_DATE('2024-11-30', 'YYYY-MM-DD'), 1, 10);

select * from Consulta;
