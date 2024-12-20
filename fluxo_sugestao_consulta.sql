-- 1. Limpar o banco antes de tudo
-- Deletar tabelas caso já existam

-- Fluxo sugestaoConsulta
DROP TABLE sugestaoConsulta CASCADE CONSTRAINTS;
DROP TABLE statusSugestao CASCADE CONSTRAINTS;
DROP TABLE motivoRecusa CASCADE CONSTRAINTS;
DROP TABLE perfilRecusa CASCADE CONSTRAINTS;

-- Criar a tabela status_sugestao
CREATE TABLE statusSugestao (
    id_status_sugestao INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL UNIQUE
);

-- Inserir dados iniciais na tabela status_sugestao
INSERT INTO statusSugestao (descricao) VALUES ('Pendente');
INSERT INTO statusSugestao (descricao) VALUES ('Aceito');
INSERT INTO statusSugestao (descricao) VALUES ('Recusado');

select * from statusSugestao;

-- Criar a tabela motivoRecusa
CREATE TABLE motivoRecusa (
    id_motivo_recusa INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL UNIQUE
);

-- Inserir dados iniciais na tabela motivoRecusa
INSERT INTO motivoRecusa (descricao) VALUES ('Data não atende');
INSERT INTO motivoRecusa (descricao) VALUES ('Horário não atende');
INSERT INTO motivoRecusa (descricao) VALUES ('Localização distante');
INSERT INTO motivoRecusa (descricao) VALUES ('Especialidade');
INSERT INTO motivoRecusa (descricao) VALUES ('Preço da consulta');
INSERT INTO motivoRecusa (descricao) VALUES ('Mudança de plano de saúde');
INSERT INTO motivoRecusa (descricao) VALUES ('Problemas pessoais');
INSERT INTO motivoRecusa (descricao) VALUES ('Não recebeu confirmação');
INSERT INTO motivoRecusa (descricao) VALUES ('Conflito de agenda');
INSERT INTO motivoRecusa (descricao) VALUES ('Preferência por outro profissional');
INSERT INTO motivoRecusa (descricao) VALUES ('Experiência anterior negativa');
INSERT INTO motivoRecusa (descricao) VALUES ('Não atende às necessidades específicas');
INSERT INTO motivoRecusa (descricao) VALUES ('Não atende o turno, precisa alterar.');

select * from motivoRecusa;

-- Criar a tabela status_sugestao
CREATE TABLE perfilRecusa (
    id_perfil_recusa INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL UNIQUE -- cliente ou clinica?
);

-- Inserir dados iniciais na tabela perfilRecusa
INSERT INTO perfilRecusa (descricao) VALUES ('Cliente');
INSERT INTO perfilRecusa (descricao) VALUES ('Clinica');


-- Criar a tabela sugestaoConsulta
CREATE TABLE sugestaoConsulta (
    id_sugestao INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    fk_id_cliente INTEGER NOT NULL,
    fk_id_clinica INTEGER NOT NULL,
    fk_id_especialista INTEGER NOT NULL,
    fk_id_status_sugestao INTEGER NOT NULL,
    fk_id_turno INTEGER NOT NULL,
    fk_id_preferencia_dia INTEGER NOT NULL,
    fk_id_preferencia_horario INTEGER NOT NULL,
    fk_id_tratamento INTEGER NOT NULL,
    fk_perfil_recusa INTEGER NOT NULL,
    fk_id_motivo_recusa INTEGER NOT NULL,
    cliente VARCHAR2(100) NOT NULL,
    descricao_dia_preferencia VARCHAR2(15) NOT NULL,
    descricao_horario_preferencia VARCHAR2(15) NOT NULL,
    descricao_turno VARCHAR2(10) NOT NULL,
    clinica VARCHAR2(100) NOT NULL,
    endereco_clinica VARCHAR2(255) NOT NULL,
    especialista VARCHAR2(100) NOT NULL,
    tratamento VARCHAR2(100) NOT NULL,
    status_sugestao VARCHAR2(15) DEFAULT 'Pendente' NOT NULL,
    custo NUMBER NOT NULL,
    
    -- Definindo as chaves estrangeiras
    FOREIGN KEY (fk_id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (fk_id_clinica) REFERENCES Clinica(id_clinica),
    FOREIGN KEY (fk_id_especialista) REFERENCES Especialista(id_especialista),
    FOREIGN KEY (fk_id_turno) REFERENCES Turno(id_turno),
    FOREIGN KEY (fk_id_preferencia_dia) REFERENCES PreferenciaDia(id_preferencia_dia),
    FOREIGN KEY (fk_id_preferencia_horario) REFERENCES PreferenciaHorario(id_preferencia_horario),
    FOREIGN KEY (fk_id_tratamento) REFERENCES Tratamento(id_tratamento),
    FOREIGN KEY (fk_perfil_recusa) REFERENCES perfilRecusa(id_perfil_recusa),
    FOREIGN KEY (fk_id_motivo_recusa) REFERENCES motivoRecusa(id_motivo_recusa)
);

-- Inserir dados iniciais na tabela sugestaoConsulta

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'João Silva', 'Segunda-feira', '08:00', 'Manhã', 'Clínica da Saúde', 
'Rua das Flores, 123', 'Dr. Paulo Oliveira', 'Consulta Geral', 150);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (2, 2, 2, 1, 1, 2, 2, 2, 1, 2, 'Maria Souza', 'Quarta-feira', '10:00', 'Manhã', 'Clínica Bem Estar', 
'Avenida Brasil, 456', 'Dra. Ana Costa', 'Consulta Odontológica', 200);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (3, 1, 3, 1, 2, 3, 3, 3, 1, 3, 'Carlos Mendes', 'Sexta-feira', '14:00', 'Tarde', 'Clínica Saúde Total', 
'Rua da Paz, 789', 'Dr. Ricardo Lima', 'Exame de Sangue', 100);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (4, 2, 1, 1, 2, 1, 1, 2, 1, 4, 'Ana Paula', 'Terça-feira', '11:00', 'Manhã', 'Clínica do Coração', 
'Rua da Saúde, 321', 'Dr. Bruno Santos', 'Consulta Cardiológica', 250);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (5, 1, 2, 1, 1, 5, 5, 1, 1, 5, 'Luiz Fernando', 'Quinta-feira', '09:00', 'Manhã', 'Clínica do Bem', 
'Rua do Sol, 654', 'Dra. Fernanda Almeida', 'Consulta Dermatológica', 180);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (6, 3, 3, 1, 2, 6, 6, 2, 1, 6, 'Patrícia Gomes', 'Sábado', '15:00', 'Tarde', 'Clínica Saúde e Vida', 
'Rua dos Lírios, 159', 'Dr. Samuel Costa', 'Consulta Neurológica', 220);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (7, 2, 1, 1, 1, 1, 1, 1, 1, 7, 'Fábio Oliveira', 'Domingo', '16:00', 'Tarde', 'Clínica Saúde em Dia', 
'Rua das Palmeiras, 852', 'Dra. Júlia Mendes', 'Consulta de Rotina', 130);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (8, 3, 2, 1, 2, 2, 2, 3, 1, 8, 'Roberta Lima', 'Segunda-feira', '08:30', 'Manhã', 'Clínica Med Saúde', 
'Rua dos Anjos, 888', 'Dr. Diego Ferreira', 'Consulta Pediátrica', 200);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (9, 1, 1, 1, 1, 3, 3, 2, 1, 9, 'Tiago Martins', 'Quarta-feira', '10:30', 'Manhã', 'Clínica do Coração', 
'Rua do Norte, 101', 'Dra. Silvia Araújo', 'Consulta de Check-up', 160);

INSERT INTO sugestaoConsulta (fk_id_cliente, fk_id_clinica, fk_id_especialista, fk_id_status_sugestao, fk_id_turno, 
    fk_id_preferencia_dia, fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, fk_id_motivo_recusa, 
    cliente, descricao_dia_preferencia, descricao_horario_preferencia, descricao_turno, clinica, 
    endereco_clinica, especialista, tratamento, custo) 
VALUES (10, 2, 3, 1, 2, 5, 5, 1, 1, 10, 'Bruna Cardoso', 'Sábado', '09:00', 'Manhã', 'Clínica Saúde Feliz', 
'Rua do Bem, 202', 'Dr. Eduardo Nascimento', 'Consulta Ginecológica', 190);
