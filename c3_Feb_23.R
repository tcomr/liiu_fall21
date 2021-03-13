
# Today: [====710_ no coding, only concept ]

  # talk about HW & flashcoding
  # new topic in Machine learning
  # remember group member from last week flash coding 
  # decide your breakout room 
# All needed is the cross table from last week 
# today: nlp; natural language processing 


# class 2 of toady
# ======== 720 ========== 

# phase-1: Data Cleangn and Pre-processing


msg_raw=read.delim("C:/Users/sts/Downloads/SMSSpamCollection.txt", 
                   header=FALSE, stringsAsFactors = F)


colnames(msg_raw) = c("cat", "msg")
str(msg_raw) # stringAsFactor = FALSE 

msg_raw$cat = factor(msg_raw$cat)

  # each words of msg are variables, [w from previous class]
  # we will build our model from train data set, and 
  # use on test data set to see how our model performs

# now NLP starts 


# install.packages("tm")
library(tm)

# First create corpus: collection of documents 

msg_corpus = VCorpus(VectorSource(msg_raw$msg))

  # function VectorSource converts to vectors 
  # VCorpus: it is called volatile because contained in the memory, 
      # not in the hd 

     # creates 3184 differnt elements 
inspect(msg_corpus[1:2])
  # 1st has 11 characters, 2nd had 29 chars 

lapply(msg_corpus[1:2], as.character)
  # to look at the actual text 
  # look elements inside the corpus 

# Now cleaning 
  # upper and lower case letter are same,
  # so convert all words to lower cases 

msg_corpus_ready = tm_map(msg_corpus, content_transformer(tolower))

as.character(msg_corpus_ready[[1]])

# Use stop words library
msg_corpus_ready = tm_map(msg_corpus_ready, removeWords, stopwords())

# remove the words spam and ham because they are target words
  # and we don't need them 
msg_corpus_ready = tm_map(msg_corpus_ready, removeWords, c("ham", "spam"))

# remove punctuation 
msg_corpus_ready = tm_map(msg_corpus_ready, removePunctuation)

# steming the documents, go, gone, goind is same word

# install.packages("SnowballC")
library(SnowballC)

msg_corpus_ready = tm_map(msg_corpus_ready, stemDocument)
# remove white spaces 
msg_corpus_ready = tm_map(msg_corpus_ready, stripWhitespace)

as.character(msg_corpus_ready[[1]])

msg_corpus_ready = tm_map(msg_corpus_ready, removeNumbers)

#=============================================

# we need to convert lists like object to document term matrix 
# tdm 




#==============================================


# create a DTM 
msg_dtm = DocumentTermMatrix(msg_corpus_ready)
  # type is large docementTermMatrix

# convert to matrix; as sparse matrix 
msg_mat = as.matrix(msg_dtm)
View(msg_mat)

# Prof:  currently on research using NLP 

head(msg_mat)

# cleaning and TermMatrix [look at doc file]

# Now split into train/test sets 

dim(msg_mat)

# create 75%/25 or could use gridsearchCV or other fancy methods 

msg_dtm_train = msg_dtm[1:2388, ]
msg_dtm_test = msg_dtm[2389:3184, ]

# create labels 
msg_train_labels = msg_raw[1:2388, ]$cat
  # only using msg column, the target variable is chr and still sits
    # on original dataset 
msg_test_labels = msg_raw[2389:3184, ]$cat

# visualize using wordclud

library(wordcloud)
# ================troubleshooting============
# could use rstudio in the web 
  # install r java, for troubleshooing 
# compiler issue: due to the java version 
#===============end=====================

wordcloud(msg_corpus_ready, min.freq = 50, random.color = FALSE)


# Now we will build algorithm 

# a lot of words with 0 for more than 99%
    # remove those words for they are rare words,
    # we don't need them 

# print the labels 
spam = subset(msg_raw, cat = "spam")
ham = subset(msg_raw, cat = "ham")

# create wordcloud for spam only
wordcloud(spam$msg, min.freq = 40, random.order = FALSE)
wordcloud(ham$msg, min.freq = 40, random.order = FALSE)
  # ham shows up in the visualization because 
  # we never cleaned teh msg-raw dataset, 

msg_dtm

# find frequent terms
msg_freq = findFreqTerms(msg_dtm_train, 5)
  # words appear at least 5 times 
msg_dtm_freq_train = msg_dtm_train[, msg_freq]
  # new training set whre words apperead more than 5 times
msg_dtm_freq_test = msg_dtm_test[, msg_freq]

# need to convert words to boolean: yes/no for bayesian form
  # if 0 no, if 1 or more yes 
# create a function to do this 

convert_counts = function(x){
  x = ifelse(x> 0, "Yes", "No")
  
}

msg_train = apply(msg_dtm_freq_train, MARGIN = 2,convert_counts )
  # x: is vector or list or array
  # margin: if == 1, function applied in row
            # if 2, function applied in column 
  # words are columns: make them yes/no column 

msg_test = apply(msg_dtm_freq_test, MARGIN = 2,convert_counts )


# Phase-2: implement Bayes Algo and evalaluate performance

# install.packages("e1071")
library(e1071)

# Ready for a lot of math??? complicated, really complicated

# call teh algorithm
msg_algo = naiveBayes(msg_train, msg_train_labels)
  # all the maths are embedded inside the function naiveBayes 

msg_test_pred = predict(msg_algo, msg_test)
  # you have learned using the naiveBayes,
  # [learning is embedded in the msg_algo object] predict using
  # the algorithm on the test set 

# Now look at the performance: use gmodels for it
library(gmodels)
CrossTable(msg_test_pred, msg_test_labels,
           prop.chisq = FALSE,prop.c = FALSE,
           prop.r = FALSE, dnn = c("predicted", "actual"))
# prop.chisq: whether variable are independent to each other 
# dnn: table title 

length(msg_test_pred)
length(msg_test_labels)

dim(msg_train)
dim(msg_train_labels)

length(msg_test)



# homework and 


































