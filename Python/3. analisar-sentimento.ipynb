import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
import joblib
import scipy

# Carregar os dados
data = pd.read_csv('feedback_model_data.csv')

# Função para análise de sentimento
def sentiment_score(comment):
    analyzer = SentimentIntensityAnalyzer()
    score = analyzer.polarity_scores(comment)
    return score['compound']

# Adicionar coluna de sentimento
data['SENTIMENTO'] = data['COMENTARIO'].apply(sentiment_score)

# Pré-processamento
X = data[['COMENTARIO', 'SENTIMENTO']]
y = data['NOTA']

# Dividir os dados em treino e teste
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Vetorização TF-IDF
vectorizer = TfidfVectorizer()
X_train_tfidf = vectorizer.fit_transform(X_train['COMENTARIO'])
X_test_tfidf = vectorizer.transform(X_test['COMENTARIO'])

# Adicionar a coluna de sentimento
import scipy
X_train_tfidf = scipy.sparse.hstack((X_train_tfidf, X_train[['SENTIMENTO']].values))
X_test_tfidf = scipy.sparse.hstack((X_test_tfidf, X_test[['SENTIMENTO']].values))

# Treinar o modelo
model = LogisticRegression()
model.fit(X_train_tfidf, y_train)

# Avaliar o modelo
y_pred = model.predict(X_test_tfidf)
print(classification_report(y_test, y_pred))

# Exportar o modelo treinado e o vetorizador para arquivos
joblib.dump(model, 'modelo_treinado.pkl')
joblib.dump(vectorizer, 'vectorizer.pkl')
