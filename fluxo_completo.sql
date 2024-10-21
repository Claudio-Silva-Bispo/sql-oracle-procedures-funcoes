
// 1. Limpar o banco antes de tudo
-- Deletar tabelas caso já existam

-- Processo Cliente
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

-- Fluxo sugestaoConsulta
DROP TABLE sugestaoConsulta CASCADE CONSTRAINTS;
DROP TABLE statusSugestao CASCADE CONSTRAINTS;
DROP TABLE motivoRecusa CASCADE CONSTRAINTS;
DROP TABLE perfilRecusa CASCADE CONSTRAINTS;

-- Fluxo Consulta
DROP TABLE Consulta CASCADE CONSTRAINTS;
DROP TABLE TipoServico CASCADE CONSTRAINTS;
DROP TABLE Tratamento CASCADE CONSTRAINTS;
DROP TABLE Retorno CASCADE CONSTRAINTS;

-- Fluxo Feedback
DROP TABLE Feedback CASCADE CONSTRAINTS;
DROP TABLE StatusFeedback CASCADE CONSTRAINTS;

-- Fluxo de Notificação
DROP TABLE notificacao CASCADE CONSTRAINTS;
DROP TABLE tipo_notificacao CASCADE CONSTRAINTS;

-- Fluxo de Sinistro para pagamento
DROP TABLE Sinistro CASCADE CONSTRAINTS;

-- Fluxo para o formulário detalhado. Ficará disponível para a clinica quando a consulta for criada.
DROP TABLE formularioDatalhado CASCADE CONSTRAINTS;
DROP TABLE estadoCivil CASCADE CONSTRAINTS;

-- Salvar a ação de deletar tudo.
commit;

// 2. Criação das tabelas na sequência lógica e que não gere erros.

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
    CONSTRAINT fk_id_especialista FOREIGN KEY (fk_id_especialista) REFERENCES Especialista(id_especialista)
);

-- Criar a tabela status_sugestao
CREATE TABLE statusSugestao (
    id_status_sugestao INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL UNIQUE
);

-- Criar a tabela motivoRecusa
CREATE TABLE motivoRecusa (
    id_motivo_recusa INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL UNIQUE
);

-- Criar a tabela status_sugestao
CREATE TABLE perfilRecusa (
    id_perfil_recusa INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL UNIQUE -- cliente ou clinica?
);


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
    CONSTRAINT fk_consulta_especialista FOREIGN KEY (fk_id_especialista) REFERENCES Especialista(id_especialista),
    CONSTRAINT fk_consulta_feedback FOREIGN KEY (fk_id_feedback) REFERENCES Feedback(id_feedback),
    CONSTRAINT fk_consulta_retorno FOREIGN KEY (fk_id_retorno) REFERENCES Retorno(id_retorno),
    CONSTRAINT fk_consulta_status_feedback FOREIGN KEY (fk_id_status_feedback) REFERENCES StatusFeedback(id_status_feedback)
);

-- Tabela Sinistro -- processo final quando a consulta finalizou e a seguradora começa a tratar o processo de pagamento

CREATE TABLE Sinistro (
    id_sinistro INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    fk_id_consulta INTEGER NOT NULL,
    status_sinistro CHAR(1), -- 'S' ou 'N'
    valor_sinistro DECIMAL(10, 2),
    data_abertura DATE NOT NULL, -- data final da consulta, quando o status mudou para finalizada.
    data_resolucao DATE, -- data que o processo foi efetivado o pagamento
    
    CONSTRAINT fk_sinistro_consulta FOREIGN KEY (fk_id_consulta) REFERENCES Consulta(id_consulta)
);

-- Tabela Estado Civil
CREATE TABLE estadoCivil (
    id_estado_civil INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL
);

-- Tabela Preferência de contato
CREATE TABLE preferenciaContato (
    id_preferencia_contato INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL -- lista com app, sms, whats, ligação
);

-- Tabela Preferência de contato
CREATE TABLE profissao (
    id_profissao INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL -- médico, bombeiro, adm, professor, outros
);

-- Tabela Formulário Detalhado
CREATE TABLE formularioDetalhado (
    id_formulario INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    fk_id_cliente INTEGER NOT NULL,
    fk_id_estado_civil INTEGER NOT NULL,
    fk_id_profissao INTEGER NOT NULL, -- lista de profissao
    fk_id_preferencia_contato INTEGER NOT NULL, -- app, sms, whats, ligação
    historico_familiar VARCHAR2(250),
    renda_mensal DECIMAL(10, 2),
    historico_medico VARCHAR2(250),
    alergia VARCHAR2(3), -- sim ou não
    condicao_preexistente VARCHAR2(250),
    uso_medicamento VARCHAR2(3), -- sim ou não
    familiar_com_doencas_dentarias VARCHAR2(3), -- sim ou não
    participacao_em_programas_preventivos VARCHAR2(3), -- sim ou não
    contato_emergencial VARCHAR2(250), -- telefone
    data_ultima_atualizacao DATE,
    frequencia_consulta_periodica VARCHAR2(3), -- sim ou não
    sinalizacao_de_risco VARCHAR2(3), -- sim ou não
    historico_de_viagem VARCHAR2(3), -- sim ou não
    historico_de_mudancas_de_endereco VARCHAR2(3), -- sim ou não

    CONSTRAINT fk_formulario_cliente FOREIGN KEY (fk_id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_formulario_estado_civil FOREIGN KEY (fk_id_estado_civil) REFERENCES estadoCivil(id_estado_civil),
    CONSTRAINT fk_id_preferencia_de_contato FOREIGN KEY (fk_id_preferencia_contato) REFERENCES preferenciaContato(id_preferencia_contato),
    CONSTRAINT fk_id_profissao FOREIGN KEY (fk_id_profissao) REFERENCES profissao(id_profissao)
);

-- Salvar os dados de criação
commit;


// 3. Inserir dados no banco para teste


