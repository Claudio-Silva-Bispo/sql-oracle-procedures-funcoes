import pandas as pd
import oracledb

credencial_banco = {
    'dsn': 'oracle.fiap.com.br:1521/orcl',
    'usuario': 'rm553472',
    'senha': '100593'
}

def conectar(usuario, senha, dsn):
    try:
        conexao = oracledb.connect(user=usuario, password=senha, dsn=dsn, mode=oracledb.DEFAULT_AUTH)
        print("Conexão com o banco de dados Oracle estabelecida com sucesso.")
        return conexao
    except oracledb.DatabaseError as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

conexao_cliente = conectar(usuario='rm553472',senha='100593', dsn='oracle.fiap.com.br:1521/orcl')

query_cliente = """
SELECT 
    c.id_cliente,
    c.nome_completo,
    ep.cep AS cep_preferencia,
    ep.estado AS estado_preferencia,
    ep.cidade AS cidade_preferencia,
    ep.bairro AS bairro_preferencia,
    ep.rua AS rua_preferencia,
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

ORDER BY c.id_cliente asc
"""

# Carregar dados em um DataFrame do Pandas
df_cliente = pd.read_sql(query_cliente, conexao_cliente)

# Fechar a conexão com o banco de dados
conexao_cliente.close()

# Conexão com a clínica
conexao_clinica = conectar(usuario='rm553472', senha='100593', dsn='oracle.fiap.com.br:1521/orcl')

# Consultar dados da tabela de clínicas e suas preferências
query_clinica = """

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
    Especialista esp ON ce2.id_especialista = esp.id_especialista


"""

# Carregar dados em um DataFrame do Pandas
df_clinica = pd.read_sql(query_clinica, conexao_clinica)

# Fechar a conexão com o banco de dados
conexao_clinica.close()

df_clinica

df_clinica_agrupado = df_clinica.groupby(
    ['ID_CLINICA', 'NOME_CLINICA', 'TELEFONE', 'EMAIL', 'CEP', 'ESTADO', 'CIDADE', 'BAIRRO', 'RUA', 'NUMERO']
).agg({
    'TURNO': lambda x: ', '.join(x.fillna('').unique()),
    'DIA_PREFERENCIA': lambda x: ', '.join(x.fillna('').unique()),
    'HORARIO_PREFERENCIA': lambda x: ', '.join(x.fillna('').unique()),
    'ESPECIALIDADE': lambda x: ', '.join(x.fillna('').unique()),
    'ESPECIALISTA': lambda x: ', '.join(x.fillna('').unique())
}).reset_index()

# Conexão com o banco de dados para obter feedback
conexao_feedback = conectar(usuario='rm553472', senha='100593', dsn='oracle.fiap.com.br:1521/orcl')

# Consulta para obter feedback
query_feedback = """
SELECT 
    f.id_feedback, 
    f.fk_id_cliente, 
    f.fk_id_especialista, 
    f.fk_id_clinica, 
    f.nota, 
    f.comentario,
    c.nome_completo AS nome_cliente,
    e.nome AS nome_dentista,
    cl.nome AS nome_clinica
FROM Feedback f
JOIN Cliente c ON f.fk_id_cliente = c.id_cliente
JOIN Especialista e ON f.fk_id_especialista = e.id_especialista
JOIN Clinica cl ON f.fk_id_clinica = cl.id_clinica
ORDER BY f.id_feedback
"""

# Carregar feedback em um DataFrame
df_feedback = pd.read_sql(query_feedback, conexao_feedback)

# Fechar a conexão com o banco de dados
conexao_feedback.close()

# Agrupar feedbacks por clínica e calcular a média das notas
df_feedback_agrupado = df_feedback.groupby('FK_ID_CLINICA').agg(
    media_nota=('NOTA', 'mean'),  # Média das notas
    total_feedbacks=('ID_FEEDBACK', 'count')  # Contagem total de feedbacks
).reset_index()

# Renomear a coluna para o ID da clínica
df_feedback_agrupado.rename(columns={'FK_ID_CLINICA': 'ID_CLINICA'}, inplace=True)

# Filtrar clínicas com média de feedbacks positivos
df_clinicas_com_feedback = df_feedback_agrupado[df_feedback_agrupado['media_nota'] >= 4]
df_clinicas_com_feedback

# Selecionar a melhor clínica (com a maior média de notas ou com mais feedbacks)
melhor_clinica = df_clinicas_com_feedback.sort_values(by='media_nota', ascending=False).iloc[0] if not df_clinicas_com_feedback.empty else None
melhor_clinica

if melhor_clinica is not None:
    print("Melhor Clínica Sugerida:")
    print(melhor_clinica)
else:
    print("Nenhuma clínica encontrada que atenda aos critérios.")

## Se não tiver clinicas o sufuciente, ai a nota de corte será 3 para cima.

**Nunca as de nota 1 e 2.**

# Filtrar clínicas com média de feedbacks positivos
df_clinicas_com_feedback_tres = df_feedback_agrupado[df_feedback_agrupado['media_nota'] >= 3]
df_clinicas_com_feedback_tres

# Selecionar a melhor clínica (com a maior média de notas ou com mais feedbacks)
melhor_clinica = df_clinicas_com_feedback.sort_values(by='media_nota', ascending=False).iloc[0] if not df_clinicas_com_feedback.empty else None
melhor_clinica

if melhor_clinica is not None:
    print("Melhor Clínica Sugerida:")
    print(melhor_clinica)
else:
    print("Nenhuma clínica encontrada que atenda aos critérios.")

import pandas as pd

# Inicializar uma lista para armazenar as sugestões
sugestoes = []

# Iterar sobre cada cliente
for index_cliente, cliente in df_cliente.iterrows():
    # Inicializar a pontuação para cada clínica
    df_clinica['PONTUACAO'] = 0

    # Verificar cada clínica para o cliente atual
    for index_clinica, clinica in df_clinica.iterrows():
        # Verificar se o dia de preferência do cliente está entre os dias preferenciais da clínica
        if pd.notna(clinica['DIA_PREFERENCIA']) and cliente['DIA_PREFERENCIA'] in clinica['DIA_PREFERENCIA'].split(', '):
            df_clinica.at[index_clinica, 'PONTUACAO'] += 1
        
        # Verificar se o horário de preferência do cliente está entre os horários preferenciais da clínica
        if pd.notna(clinica['HORARIO_PREFERENCIA']) and cliente['HORARIO_PREFERENCIA'] in clinica['HORARIO_PREFERENCIA'].split(', '):
            df_clinica.at[index_clinica, 'PONTUACAO'] += 1
            
        # Verificar se o turno do cliente e da clínica são os mesmos
        if cliente['TURNO'] == clinica['TURNO']:
            df_clinica.at[index_clinica, 'PONTUACAO'] += 1
        
        # Verificar se o estado, cidade e bairro de preferência do cliente correspondem à clínica
        if cliente['ESTADO_PREFERENCIA'] == clinica['ESTADO']:
            df_clinica.at[index_clinica, 'PONTUACAO'] += 1
        if cliente['CIDADE_PREFERENCIA'] == clinica['CIDADE']:
            df_clinica.at[index_clinica, 'PONTUACAO'] += 1
        if cliente['BAIRRO_PREFERENCIA'] == clinica['BAIRRO']:
            df_clinica.at[index_clinica, 'PONTUACAO'] += 1

    # Filtrar clínicas que têm pontuação maior que 0
    df_sugestoes = df_clinica[df_clinica['PONTUACAO'] > 0]

    # Selecionar a clínica com a maior pontuação para o cliente atual
    if not df_sugestoes.empty:
        melhor_clinica = df_sugestoes.loc[df_sugestoes['PONTUACAO'].idxmax()]

        sugestao = {
            'fk_id_cliente': cliente['ID_CLIENTE'],
            'fk_id_clinica': melhor_clinica['ID_CLINICA'],
            'fk_id_especialista': None,  # Ajuste se você tiver um DataFrame de especialistas
            'fk_id_status_sugestao': 1,  # Exemplo, ajuste conforme necessário
            'fk_id_turno': cliente['TURNO'],  # O turno do cliente
            'fk_id_preferencia_dia': cliente['DIA_PREFERENCIA'],  # Ajuste conforme sua estrutura
            'fk_id_preferencia_horario': cliente['HORARIO_PREFERENCIA'],  # Ajuste conforme sua estrutura
            'fk_id_tratamento': None,  # Ajuste se você tiver tratamento relacionado
            'fk_perfil_recusa': None,  # Ajuste se você tiver um perfil de recusa
            'fk_id_motivo_recusa': None,  # Ajuste se você tiver motivos de recusa
            'cliente': cliente['NOME_COMPLETO'],
            'descricao_dia_preferencia': cliente['DIA_PREFERENCIA'],
            'descricao_horario_preferencia': cliente['HORARIO_PREFERENCIA'],
            'descricao_turno': melhor_clinica['TURNO'],
            'clinica': melhor_clinica['NOME_CLINICA'],
            'endereco_clinica': f"{melhor_clinica['RUA']}, {melhor_clinica['NUMERO']} - {melhor_clinica['BAIRRO']}, {melhor_clinica['CIDADE']}, {melhor_clinica['ESTADO']}",
            'especialista': melhor_clinica.get('ESPECIALISTA', None),  # Nome do especialista, se disponível
            'tratamento': None,  # Ajuste conforme sua estrutura
            'status_sugestao': 'Pendente',
            'custo': None  # Ajuste conforme sua estrutura, se aplicável
        }
        sugestoes.append(sugestao)

# Criar DataFrame com sugestões
df_sugestao_consulta = pd.DataFrame(sugestoes)

## Inserir dados no banco


conexao_cliente = conectar(usuario='rm553472', senha='100593', dsn='oracle.fiap.com.br:1521/orcl')

# Verificar se a tabela sugestaoConsulta já existe
query_verificacao = """
SELECT COUNT(*)
FROM user_tables
WHERE table_name = 'SUGESTAOCONSULTA'
"""

# Executar a verificação
with conexao_cliente.cursor() as cursor:
    cursor.execute(query_verificacao)
    tabela_existe = cursor.fetchone()[0] > 0 

if not tabela_existe:
    query_criacao = """
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
    )
    """
    # Executar a criação da tabela
    with conexao_cliente.cursor() as cursor:
        cursor.execute(query_criacao)

# Definir a query de inserção
query_inserir = """
    INSERT INTO sugestaoConsulta (
        fk_id_cliente, fk_id_clinica, fk_id_especialista, 
        fk_id_status_sugestao, fk_id_turno, fk_id_preferencia_dia, 
        fk_id_preferencia_horario, fk_id_tratamento, fk_perfil_recusa, 
        fk_id_motivo_recusa, cliente, descricao_dia_preferencia, 
        descricao_horario_preferencia, descricao_turno, clinica, 
        endereco_clinica, especialista, tratamento, status_sugestao, custo
    ) VALUES (
        :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, 
        :11, :12, :13, :14, :15, :16, :17, :18, :19, :20
    )
"""


# Inserir dados do DataFrame
with conexao_cliente.cursor() as cursor:
    for index, row in df_sugestao_consulta.iterrows():
        cursor.execute(query_inserir, (
            row['fk_id_cliente'],
            row['fk_id_clinica'],
            row['fk_id_especialista'],
            row['fk_id_status_sugestao'],
            row['fk_id_turno'],
            row['fk_id_preferencia_dia'],
            row['fk_id_preferencia_horario'],
            row['fk_id_tratamento'],
            row['fk_perfil_recusa'],
            row['fk_id_motivo_recusa'],
            row['cliente'],
            row['descricao_dia_preferencia'],
            row['descricao_horario_preferencia'],
            row['descricao_turno'],
            row['clinica'],
            row['endereco_clinica'],
            row['especialista'],
            row['tratamento'],
            row['status_sugestao'],
            row['custo']
        ))

# Confirmar a transação
conexao_cliente.commit()

# Fechar a conexão
conexao_cliente.close()

print("Dados inseridos na tabela sugestaoConsulta com sucesso!")


