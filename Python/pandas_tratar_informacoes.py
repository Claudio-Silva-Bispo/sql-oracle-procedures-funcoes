# Selecionar as colunas necessárias para o treinamento do modelo de classificação de feedback
df_feedback_model = df_feedback[['NOTA', 'COMENTARIO']]

# Exibir as primeiras linhas do DataFrame preparado para o modelo
df_feedback_model.head()

# Salvar o DataFrame preparado em um arquivo CSV para uso posterior pelo professor
df_feedback_model.to_csv('feedback_model_data.csv', index=False)

df_feedback_model.info()

df_feedback_model['NOTA'] = df_feedback_model['NOTA'].astype(int)

df_feedback_model

# Salvar o DataFrame preparado em um arquivo CSV para uso posterior pelo professor
df_feedback_model.to_csv('feedback_model_data.csv', index=False)
