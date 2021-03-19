# chapter 6:
    # neural network in python github 


from keras.datasets import imdb

# training_set, testing_set = imdb.load_data(num_words = 10000)
training_set, testing_set = imdb.load_data(index_from = 3)
    # inside traiing /testing set different values, pluck them out
    
X_train, y_train = training_set

# the words on X_train come from dictionary in google vocabulary 

X_test, y_test = testing_set

print(X_train[0])

word_to_id = imdb.get_word_index()
    # dictionary that has word and index 

word_to_id = {key:(value+3) for key, value in word_to_id.items()}

# Padding:
word_to_id["<PAD>"] = 0
word_to_id["<START>"] = 1

# Reverse the order
id_to_word = {value:key for key, value in word_to_id.items()}


print(' '.join(id_to_word[id] for id in X_train[11]))


#%% 
# Now, lets start building the model
# input, wordimbedding, 
# wordembedding: convert sparse matrix to clusters of words
# onehot encoding 

# now only use unique words
# num_words gives unique words 
training_set, testing_set = imdb.load_data(num_words = 10000)

X_train, y_train = training_set
X_test, y_test = testing_set

# to check shape 
X_train.shape

# zero padding 
# I like the movie : length of ; 4 wods
# I like the movie. It is great : length of 7; 7 words 




#%% 
# Algorihm needs each review to be of the same length 
    # reviews must be of equal/same lengths
        # so, add zeros if less than

from keras.preprocessing import sequence

# Create new train/test set
X_train_padded = sequence.pad_sequences(X_train, maxlen = 100)
    # maxlen if <100 words, add zeros to it
    # if 100> , truncate to the hundred 


X_test_padded = sequence.pad_sequences(X_test, maxlen = 100)



#%% 
# Now, algorithm 
    # we add layer aftr layer, with Sequential
from keras.models import Sequential

model = Sequential()

from keras.layers import Embedding
    # we have to tell num of words, output dim, 
# now add the embedding layer

model.add(Embedding(input_dim = 10000, output_dim = 128))
# input_dim is uniq words == num_words 
# output_dim = dimension of output vector
# raw input to output vector: input 10K, output = 128
# Convert 10K words to vector representation to 128 

from keras.layers import LSTM
model.add(LSTM(units = 128))


# add dense layer
from keras.layers import Dense 
model.add(Dense(units = 1, activation= 'sigmoid'))

# layers done, check model summary 

model.summary()




#%% 
# now all we need is fit the data 
# what minimization technique, like rmse 
model.compile(loss = 'binary_crossentropy', optimizer = 'rmsprop')
    # optimizer sth like gradient descent 


# now score the model
score = model.fit(x = X_train_padded, y = y_train, 
                  batch_size=128, epochs=4,
                  validation_data=(X_test_padded, y_test))
# Function on 1:45 

# how many times = epochs [iteration]
# batch_size  = 