# -*- coding: utf-8 -*-
"""
Created on Mon Apr 26 04:38:20 2021

@author: sts
"""

#%% 


#%% 
# Import libraries
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

import nltk
import re
import string 

from bs4 import BeautifulSoup


from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report

import keras
from keras.preprocessing import text,sequence
from keras.models import Sequential
from keras.layers import Dense,Embedding,LSTM,Dropout

#%% 
# import news data

real_news = pd.read_csv("C:/Users/sts/Desktop/data/True.csv")
fake_news = pd.read_csv("C:\\Users\\sts\\Desktop\\data\\Fake.csv")

#%% 
real_news.head()
fake_news.head()

real_news['target'] = 1
fake_news['target'] = 0


# Concatinate fake and real news_df sets 
pd.set_option('max_colwidth', None)
news_df = pd.concat([real_news, fake_news], ignore_index=True, sort=False)

news_df.info()

# Real news
news_df.head()

news_df.sample(2)
# Fake news 
news_df.tail()

# check null values of news_df 
news_df.isnull().sum() # no null values 

# check target values 
print(news_df["target"].value_counts())

#%%




#%% 
# visualization 
# Check for class imbalance 

fig, ax = plt.subplots(1,2, figsize=(11, 6))
g1 = sns.countplot(news_df.target,ax=ax[0],palette="pastel");
g1.set_title("Count of real and fake news_df")
g1.set_ylabel("Count")
g1.set_xlabel("Target")

g2 = plt.pie(news_df["target"].value_counts().values,explode=[0,0], 
             labels=news_df.target.value_counts().index, autopct='%1.1f%%', 
             colors=['SkyBlue','PeachPuff'])
fig.show()
#%%
# Check for suplicate news articles 

from hashlib import sha256
from tqdm import tqdm

list_ = [ ]
for text in tqdm(news_df['text']):
    hash_ = sha256(text.encode('utf-8')).hexdigest()
    list_.append(hash_)
news_df['hash'] = list_
pd.reset_option('max_colwidth')
news_df

# Count number of duplicate news 

unique_hash = news_df.groupby(['hash']).size().reset_index(name='count')
duplicate = unique_hash[unique_hash['count']>1]
print('there are ',duplicate.shape[0], 'duplicate texts')
# 5140 duplicates; 

#%% 
# remove the rows with duplicate texts 

news_df.drop_duplicates(subset='hash', inplace=True)
news_df.reset_index(inplace=True, drop=True)
news_df.drop('hash', axis=1, inplace=True)
news_df
#%%
# checking for class imbalance after dropping duplicates
sns.set(rc={'figure.figsize':(11,5)})
sns.countplot(x='target', data=news_df)


#%% 
# Distribution of the news according to Subject for both Real and Fake news_df
    #[probably check distribution of news_df for real only and fake only]

print(news_df.subject.value_counts())

plt.figure(figsize=(10, 5))
ax = sns.countplot(x="subject",  hue='target', data=news_df, palette="pastel")
plt.title(" Distribution of the news according to Subject")
#%%
#converting date string to datetime format
# removing url in date column
# url_pattern = "http"
# filter1 = news_df['date'].str.contains(url_pattern)
# news_df = news_df[~filter1]
# news_df

# removing other texts in date column
date_pattern = "Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec"
filter2 = news_df['date'].str.contains(date_pattern)
news_df = news_df[filter2]
news_df.reset_index(drop=True, inplace=True)

# convert date string to datetime format
news_df_copy = news_df.copy()
news_df_copy['date'] = pd.to_datetime(news_df_copy['date'])
news_df_copy.sort_values(by=['date'], inplace=True)
news_df_copy.reset_index(drop=True, inplace=True)
pd.reset_option('max_rows')
news_df_copy

#%%
# creating a dataframe of fake news counts by date
fake = news_df_copy[news_df_copy['target']==0]
fake['count'] = 0
fake = fake.groupby(['date'])['count'].count()
fake = pd.DataFrame(fake)
fake

#%%
# creating a dataframe of real news counts by date
real = news_df_copy[news_df_copy['target']==1]
real['count'] = 0
real = real.groupby(['date'])['count'].count()
real = pd.DataFrame(real)
real

#%%
# lineplots of fake and real news over time

sns.set(rc={'figure.figsize':(11,5)})
sns.lineplot(x=fake.index, y=fake['count'], label = 'Fake news')
sns.lineplot(x=real.index, y=real['count'], label = 'Real news')
plt.legend() 
plt.title("Fake vs. Real News Over Time")


#%%
# news_df cleaning

news_df['text']= news_df['subject'] + " " + news_df['title'] + " " + news_df['text']

news_df.drop(['title', 'subject', 'date'])
# del news_df['title']
# del news_df['subject']
# del news_df['date']
news_df.head()
#%% 
# check whole news

real_1 = news_df.text[5]
real_1
fake_1 = news_df.text[len(news_df)-3]
fake_1




#%% 
# Remove HTML content 


soup = BeautifulSoup(real_1, "html.parser")
real_1 = soup.get_text()
real_1


#%%
# Remove punctuation Marks and Special Characters

real_1 = re.sub('\[[^]]*\]', ' ', real_1)
real_1 = re.sub('[^a-zA-Z]',' ',real_1)  # replaces non-alphabets with spaces
real_1 = real_1.lower() # Converting from uppercase to lowercase
real_1

#%%
# Remove stopwords 

nltk.download("stopwords")   
from nltk.corpus import stopwords  

# we can use tokenizer instead of split
real_1 = nltk.word_tokenize(real_1)

real_1 = [ word for word in real_1 if not word in 
              set(stopwords.words("english"))]


#%%
# Lemmatization

nltk.download('wordnet')
lemma = nltk.WordNetLemmatizer()
real_1 = [ lemma.lemmatize(word) for word in real_1] 

real_1 = " ".join(real_1)
real_1


#%%
# Function to clean the news_df 

nltk.download("stopwords")   
from nltk.corpus import stopwords  

# Function to remove  HTML Contents
def remove_html(text):
    soup = BeautifulSoup(text, "html.parser")
    return soup.get_text()

# Function to remove  Punctuation Marks
def remove_punctuations(text):
    return re.sub('\[[^]]*\]', '', text)

# Function to remove  Special Characters
def remove_characters(text):
    return re.sub("[^a-zA-Z]"," ",text)

# Function to remove stopwords 
def remove_stopwords_and_lemmatization(text):
    final_text = []
    text = text.lower()
    text = nltk.word_tokenize(text)
    
    for word in text:
        if word not in set(stopwords.words('english')):
            lemma = nltk.WordNetLemmatizer()
            word = lemma.lemmatize(word) 
            final_text.append(word)
    return " ".join(final_text)

# Combined function
def cleaning(text):
    text = remove_html(text)
    text = remove_punctuations(text)
    text = remove_characters(text)
    text = remove_stopwords_and_lemmatization(text)
    return text

# Apply function on predictor variable of news_df, text column
news_df['text']=news_df['text'].apply(cleaning) 
#taking very long 8:am - 30min apprx.

#%%
# Check functin call on news_df 
news_df.head()

#%% 
# Visualization of pre-processed text 

from wordcloud import WordCloud, STOPWORDS

# Real news visualization / news_df.target == 1

plt.figure(figsize = (15,15))
wc = WordCloud(max_words = 500 , width = 1000 , height = 500 , 
               stopwords = STOPWORDS).generate(" ".join(news_df[news_df.target == 1].text))
plt.imshow(wc , interpolation = 'bilinear')

#%%
# Fake nws visualization 

plt.figure(figsize = (15,15))
wc = WordCloud(max_words = 500 , width = 1000 , height = 500 , stopwords = STOPWORDS).generate(" ".join(news_df[news_df.target == 0].text))
plt.imshow(wc , interpolation = 'bilinear')

#%%
# Distribution of words in each news article 

fig,(ax1,ax2)=plt.subplots(1,2,figsize=(12,8))
text_len=news_df[news_df['target']==0]['text'].str.split().map(lambda x: len(x))
ax1.hist(text_len,color='SkyBlue')
ax1.set_title('Fake news text')
text_len=news_df[news_df['target']==1]['text'].str.split().map(lambda x: len(x))
ax2.hist(text_len,color='PeachPuff')
ax2.set_title('Real news text')
fig.suptitle('Words in texts')
plt.show()

# Agerage length of fake news (250) are shorter than real news (500)

#%% 
# N-gram analysis

text = ' '.join(news_df.text)
string = text.split(" ")

def draw_n_gram(string,i):
    n_gram = (pd.Series(nltk.ngrams(string, i)).value_counts())[:15]
    n_gram_df=pd.DataFrame(n_gram)
    n_gram_df = n_gram_df.reset_index()
    n_gram_df = n_gram_df.rename(columns={"index": "word", 0: "count"})
    print(n_gram_df.head())
    plt.figure(figsize = (16,9))
    return sns.barplot(x='count',y='word', data=n_gram_df)

#%% 
# Unigram analysis 
draw_n_gram(string, 1)

# Bigram analysis
draw_n_gram(string, 2)

# Trigram analysis 
draw_n_gram(string, 3)

#%%
# Tokenization & Train/test split for modeling 

from keras.preprocessing.text import Tokenizer

X_train, X_test, y_train, y_test = train_test_split(news_df['text'],
                                                    news_df['target'], random_state=0)

max_features = 10000
maxlen = 300

tokenizer = Tokenizer(num_words=max_features)
tokenizer.fit_on_texts(X_train)
tokenized_train = tokenizer.texts_to_sequences(X_train)
X_train = sequence.pad_sequences(tokenized_train, maxlen=maxlen)

tokenized_test = tokenizer.texts_to_sequences(X_test)
X_test = sequence.pad_sequences(tokenized_test, maxlen=maxlen)


#%%
# # for Tokenizer example 
# from keras.preprocessing.text import Tokenizer

# samples = ['The cat say on the mat.', 'The dog ate my homework.']

# tokenizer = Tokenizer(num_words=1000)
# tokenizer.fit_on_sequences(samples)

# sequences = tokenizer.texts_to_sequences(samples)

# one_hot_results = tokenizer.texts_to_matrix(samples, mode='binary')

# word_index = tokenizer.word_index
# print('Found %s unique tokens.' % len(word_index))

#%%
# LSTM model training 

batch_size = 256
epochs = 5 # [probably try 10 or more]
embed_size = 100

model = Sequential()

# embeddidng layer
model.add(Embedding(max_features, output_dim=embed_size, 
                    input_length=maxlen, trainable=False))

# LSTM 
model.add(LSTM(units=128 , return_sequences = True , 
               recurrent_dropout = 0.25 , dropout = 0.25))
model.add(LSTM(units=64 , recurrent_dropout = 0.1 , dropout = 0.1))
# Dense 
model.add(Dense(units = 32 , activation = 'relu'))
model.add(Dense(1, activation='sigmoid'))

# Compile
model.compile(optimizer=keras.optimizers.Adam(lr = 0.01), 
              loss='binary_crossentropy', metrics=['accuracy'])

# Model summary
model.summary()
#%%
# model fit 
history = model.fit(X_train, y_train, validation_split=0.3, 
                    epochs=5, batch_size=batch_size, shuffle=True, verbose = 1)

#%%
# Performance analysis of the model 

print("Accuracy of the model on Training news_df is - " ,
      model.evaluate(X_train,y_train)[1]*100 , "%")
print("Accuracy of the model on Testing news_df is - " , 
      model.evaluate(X_test,y_test)[1]*100 , "%")


#%% 
# Performance visualization: accuracy 

plt.figure()
plt.plot(history.history["accuracy"], label = "Train")
plt.plot(history.history["val_accuracy"], label = "Test")
plt.title("Accuracy")
plt.ylabel("Acc")
plt.xlabel("Epochs")
plt.legend()
plt.show()

#%% 
# Performance visualizationn: loss

plt.figure()
plt.plot(history.history["loss"], label = "Train")
plt.plot(history.history["val_loss"], label = "Test")
plt.title("Loss")
plt.ylabel("Acc")
plt.xlabel("Epochs")
plt.legend()
plt.show()

#%%
# Summary of performance matrix

pred = model.predict_classes(X_test)
print(classification_report(y_test, pred, target_names = ['Fake','Real']))


