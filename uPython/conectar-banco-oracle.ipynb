import pandas as pd
import oracledb
# Ajustar a configuração do Pandas para mostrar todas as linhas
#pd.set_option('display.max_rows', None)

# Instalar pip install SQLAlchemy
#from sqlalchemy import create_engine

# Minhas credenciais
credencial_banco = {
    'dsn': 'oracle.fiap.com.br:1521/orcl',
    'usuario': 'rm553472',
    'senha': '100593'
}

# Função para conectar ao banco de dados
def conectar(usuario, senha, dsn):
    try:
        conexao = oracledb.connect(user=usuario, password=senha, dsn=dsn, mode=oracledb.DEFAULT_AUTH)
        print("Conexão com o banco de dados Oracle estabelecida com sucesso.")
        return conexao
    except oracledb.DatabaseError as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

conexao = conectar(usuario='rm553472',senha='100593', dsn='oracle.fiap.com.br:1521/orcl')

# Consultar dados da tabela de feedback
query_feedback = """
SELECT *
FROM feedback
"""

# Carregar dados em um DataFrame do Pandas
df_feedback = pd.read_sql(query_feedback, conexao)

# Fechar a conexão com o banco de dados
conexao.close()
