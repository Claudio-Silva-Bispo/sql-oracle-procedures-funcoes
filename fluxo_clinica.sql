
// 1. Limpar o banco antes de tudo

-- Deletar tabelas caso já existam

DROP TABLE Endereco CASCADE CONSTRAINTS;
DROP TABLE Turno CASCADE CONSTRAINTS;
DROP TABLE PreferenciaDia CASCADE CONSTRAINTS;
DROP TABLE PreferenciaHorario CASCADE CONSTRAINTS;
DROP TABLE Especialidade CASCADE CONSTRAINTS;
DROP TABLE Especialista CASCADE CONSTRAINTS;
DROP TABLE Clinica CASCADE CONSTRAINTS;
DROP TABLE ClinicaTurno CASCADE CONSTRAINTS;
DROP TABLE ClinicaDia CASCADE CONSTRAINTS;
DROP TABLE ClinicaHorario CASCADE CONSTRAINTS;

// 2. Criar tabelas

-- Criação da Tabela Endereco

CREATE TABLE Endereco (
    id_endereco INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    cep VARCHAR2(255) NOT NULL,
    estado VARCHAR2(255) NOT NULL,
    cidade VARCHAR2(255) NOT NULL,
    bairro VARCHAR2(255) NOT NULL,
    rua VARCHAR2(255) NOT NULL,
    numero VARCHAR2(20) NOT NULL
);

-- Criação da Tabela Turno

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

INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('11000-000', 'SP', 'São Paulo', 'Vila Madalena', 'Rua Harmonia', '102');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('12000-000', 'SP', 'São Paulo', 'Jardins', 'Avenida Paulista', '103');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('13000-000', 'SP', 'São Paulo', 'Morumbi', 'Rua das Pedras', '104');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('14000-000', 'SP', 'São Paulo', 'Butantã', 'Rua da Saúde', '105');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('15000-000', 'SP', 'São Paulo', 'Jardim América', 'Rua da Amizade', '106');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('16000-000', 'SP', 'São Paulo', 'Vila Nova Conceição', 'Rua da Esperança', '107');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('17000-000', 'SP', 'São Paulo', 'Vila Prudente', 'Rua da Alegria', '108');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('18000-000', 'SP', 'São Paulo', 'Lapa', 'Rua das Flores', '109');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('19000-000', 'SP', 'São Paulo', 'Santa Cecília', 'Rua do Sol', '110');
INSERT INTO Endereco (cep, estado, cidade, bairro, rua, numero) VALUES ('20000-000', 'SP', 'São Paulo', 'Jardim Paulista', 'Rua da Lua', '111');

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

-- Clinica turno
-- Exemplo de inserção, considerando que já tenha clínicas e turnos cadastrados

-- Inserindo dados na tabela ClinicaTurno
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (1, 1); -- Clínica 1, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (1, 2); -- Clínica 1, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (1, 3); -- Clínica 1, Noite
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (2, 1); -- Clínica 2, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (2, 2); -- Clínica 2, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (3, 1); -- Clínica 3, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (3, 2); -- Clínica 3, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (4, 1); -- Clínica 4, Manhã
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (5, 2); -- Clínica 5, Tarde
INSERT INTO ClinicaTurno (id_clinica, id_turno) VALUES (6, 3); -- Clínica 6, Noite

SELECT * FROM ClinicaTurno;

-- Inserindo dados na tabela ClinicaDia
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (1, 1);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (1, 2);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (2, 1);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (2, 3);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (3, 2);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (3, 3);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (4, 1);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (5, 2);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (5, 4);
INSERT INTO ClinicaDia (id_clinica, id_preferencia_dia) VALUES (6, 1);

SELECT * FROM ClinicaDia;

-- Inserindo dados na tabela ClinicaHorario

INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (1, 1);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (1, 2);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (2, 1);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (2, 3);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (3, 2);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (3, 4);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (4, 1);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (4, 3);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (5, 2);
INSERT INTO ClinicaHorario (id_clinica, id_preferencia_horario) VALUES (5, 5);

SELECT * FROM ClinicaHorario;

-- Inserindo dados na tabela ClinicaEspecialidade

INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (1, 1);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (1, 2);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (2, 1);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (2, 3);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (3, 2);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (3, 4);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (4, 1);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (4, 3);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (5, 2);
INSERT INTO ClinicaEspecialidade (id_clinica, id_especialidade) VALUES (5, 5);

SELECT * FROM ClinicaEspecialidade;

-- Inserindo dados na tabela ClinicaEspecialidade

INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (1, 1);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (1, 2);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (2, 1);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (2, 3);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (3, 2);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (3, 4);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (4, 1);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (4, 3);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (5, 2);
INSERT INTO ClinicaEspecialista (id_clinica, id_especialista) VALUES (5, 5);

SELECT * FROM ClinicaEspecialista;

-- Montar query e gerar uma tabela fato_clinica aberto por cada linha e em detalhes

SELECT 
    c.id_clinica,
    c.nome AS nome_clinica,
    c.telefone,
    c.email,
    e.cep,
    e.estado,
    e.cidade,
    e.bairro,
    e.rua,
    e.numero,
    t.descricao AS turno,
    pd.dia AS dia_preferencia,
    ph.horario AS horario_preferencia,
    es.nome AS especialidade,
    esp.nome AS especialista
FROM 
    Clinica c
LEFT JOIN 
    Endereco e ON c.fk_id_endereco = e.id_endereco
LEFT JOIN 
    ClinicaTurno ct ON c.id_clinica = ct.id_clinica
LEFT JOIN 
    Turno t ON ct.id_turno = t.id_turno
LEFT JOIN 
    ClinicaDia cd ON c.id_clinica = cd.id_clinica
LEFT JOIN 
    PreferenciaDia pd ON cd.id_preferencia_dia = pd.id_preferencia_dia
LEFT JOIN 
    ClinicaHorario ch ON c.id_clinica = ch.id_clinica
LEFT JOIN 
    PreferenciaHorario ph ON ch.id_preferencia_horario = ph.id_preferencia_horario
LEFT JOIN 
    ClinicaEspecialidade ce ON c.id_clinica = ce.id_clinica
LEFT JOIN 
    Especialidade es ON ce.id_especialidade = es.id_especialidade
LEFT JOIN 
    ClinicaEspecialista ce2 ON c.id_clinica = ce2.id_clinica
LEFT JOIN 
    Especialista esp ON ce2.id_especialista = esp.id_especialista;


-- Montar query e gerar uma tabela fato_clinica agrupado em formato lista

SELECT 
    c.id_clinica,
    c.nome AS nome_clinica,
    LISTAGG(t.descricao, ', ') WITHIN GROUP (ORDER BY t.descricao) AS turnos
FROM 
    Clinica c
JOIN 
    ClinicaTurno ct ON c.id_clinica = ct.id_clinica
JOIN 
    Turno t ON ct.id_turno = t.id_turno
GROUP BY 
    c.id_clinica, c.nome
ORDER BY 
    c.id_clinica;

WITH Turnos AS (
    SELECT 
        ct.id_clinica,
        LISTAGG(t.descricao, ', ') WITHIN GROUP (ORDER BY t.descricao) AS turnos
    FROM 
        ClinicaTurno ct
    JOIN 
        Turno t ON ct.id_turno = t.id_turno
    GROUP BY 
        ct.id_clinica
),

DiasPreferidos AS (
    SELECT 
        cd.id_clinica,
        LISTAGG(pd.dia, ', ') WITHIN GROUP (ORDER BY pd.dia) AS dias_preferidos
    FROM 
        ClinicaDia cd
    JOIN 
        PreferenciaDia pd ON cd.id_preferencia_dia = pd.id_preferencia_dia
    GROUP BY 
        cd.id_clinica
),

HorariosPreferidos AS (
    SELECT 
        ch.id_clinica,
        LISTAGG(ph.horario, ', ') WITHIN GROUP (ORDER BY ph.horario) AS horarios_preferidos
    FROM 
        ClinicaHorario ch
    JOIN 
        PreferenciaHorario ph ON ch.id_preferencia_horario = ph.id_preferencia_horario
    GROUP BY 
        ch.id_clinica
),

Especialidades AS (
    SELECT 
        ce.id_clinica,
        LISTAGG(es.nome, ', ') WITHIN GROUP (ORDER BY es.nome) AS especialidades
    FROM 
        ClinicaEspecialidade ce
    JOIN 
        Especialidade es ON ce.id_especialidade = es.id_especialidade
    GROUP BY 
        ce.id_clinica
),

Especialistas AS (
    SELECT 
        cep.id_clinica,
        LISTAGG(ep.nome, ', ') WITHIN GROUP (ORDER BY ep.nome) AS especialistas
    FROM 
        ClinicaEspecialista cep
    JOIN 
        Especialista ep ON cep.id_especialista = ep.id_especialista
    GROUP BY 
        cep.id_clinica
)

SELECT 
    c.id_clinica,
    c.nome AS nome_clinica,
    c.telefone,
    c.email,
    e.bairro,
    e.rua,
    e.numero,
    t.turnos,
    d.dias_preferidos,
    h.horarios_preferidos,
    es.especialidades,
    ep.especialistas
FROM 
    Clinica c
JOIN 
    Endereco e ON c.fk_id_endereco = e.id_endereco
LEFT JOIN 
    Turnos t ON c.id_clinica = t.id_clinica
LEFT JOIN 
    DiasPreferidos d ON c.id_clinica = d.id_clinica
LEFT JOIN 
    HorariosPreferidos h ON c.id_clinica = h.id_clinica
LEFT JOIN 
    Especialidades es ON c.id_clinica = es.id_clinica
LEFT JOIN 
    Especialistas ep ON c.id_clinica = ep.id_clinica
ORDER BY 
    c.id_clinica;

