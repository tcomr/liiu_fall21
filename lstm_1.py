


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
