// 1. Limpar o banco antes de tudo
-- Deletar tabelas caso já existam

-- Fluxo de Notificação

DROP TABLE notificacao CASCADE CONSTRAINTS;
DROP TABLE tipo_notificacao CASCADE CONSTRAINTS;

// 2. Criar tabelas para fluxo notificação e tipo de notificação

-- Tabela Tipo Notificação
CREATE TABLE Tipo_Notificacao (
    id_tipo_notificacao INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao VARCHAR2(40) NOT NULL
);

-- Tabela Notificações
CREATE TABLE Notificacao (
    id_notificacao INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    fk_id_cliente INTEGER NOT NULL,
    fk_id_tipo_notificacao INTEGER NOT NULL,
    descricao VARCHAR2(250),
    data_envio DATE,

    CONSTRAINT fk_notificacao_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_notificacao_tipo FOREIGN KEY (id_tipo_notificacao) REFERENCES Tipo_Notificacao(id_tipo_notificacao)
);

-- Tipo de notificação

INSERT INTO Tipo_Notificacao (descricao) VALUES ('Lembrete de Consulta');
INSERT INTO Tipo_Notificacao (descricao) VALUES ('Notificação de Pagamento');
INSERT INTO Tipo_Notificacao (descricao) VALUES ('Confirmação de Agendamento');
INSERT INTO Tipo_Notificacao (descricao) VALUES ('Cancelamento de Consulta');
INSERT INTO Tipo_Notificacao (descricao) VALUES ('Promoção de Serviços');
INSERT INTO Tipo_Notificacao (descricao) VALUES ('Atualização de Cadastro');
INSERT INTO Tipo_Notificacao (descricao) VALUES ('Aviso de Documentação');
INSERT INTO Tipo_Notificacao (descricao) VALUES ('Encaminhamento Médico');
INSERT INTO Tipo_Notificacao (descricao) VALUES ('Pesquisa de Satisfação');
INSERT INTO Tipo_Notificacao (descricao) VALUES ('Alerta de Saúde Preventiva');
select * from Formulario_Detalhado;

select * from Tipo_Notificacao;

// 5. Inserir dados para notificação e tipo de notificação

-- Notificação

INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, descricao, data_envio) VALUES (1, 1, 'Sua consulta está agendada para amanhã.', TO_DATE('2024-10-01', 'YYYY-MM-DD'));
INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, descricao, data_envio) VALUES (2, 2, 'Lembrete: é hora de realizar seu check-up anual.', TO_DATE('2024-09-25', 'YYYY-MM-DD'));
INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, descricao, data_envio) VALUES (3, 1, 'Consulta confirmada para a próxima segunda-feira.', TO_DATE('2024-09-28', 'YYYY-MM-DD'));
INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, descricao, data_envio) VALUES (4, 3, 'Obrigado pelo feedback! Aguardamos sua próxima visita.', TO_DATE('2024-09-30', 'YYYY-MM-DD'));
INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, descricao, data_envio) VALUES (5, 1, 'Sua consulta foi reagendada para a próxima sexta-feira.', TO_DATE('2024-10-03', 'YYYY-MM-DD'));
INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, descricao, data_envio) VALUES (6, 2, 'Faltam 7 dias para seu próximo exame preventivo.', TO_DATE('2024-10-04', 'YYYY-MM-DD'));
INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, descricao, data_envio) VALUES (7, 1, 'Aviso: consulta pendente de confirmação.', TO_DATE('2024-09-27', 'YYYY-MM-DD'));
INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, descricao, data_envio) VALUES (8, 3, 'Estamos prontos para recebê-lo em sua próxima consulta.', TO_DATE('2024-09-29', 'YYYY-MM-DD'));
INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, descricao, data_envio) VALUES (9, 2, 'Não se esqueça de manter suas consultas em dia.', TO_DATE('2024-09-26', 'YYYY-MM-DD'));
INSERT INTO Notificacao (id_cliente, id_tipo_notificacao, descricao, data_envio) VALUES (10, 1, 'Sua consulta foi confirmada para amanhã às 10h.', TO_DATE('2024-09-30', 'YYYY-MM-DD'));

select * from Notificacao;
