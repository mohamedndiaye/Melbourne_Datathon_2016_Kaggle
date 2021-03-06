library(RWeka)
library(tm)
library(SnowballC)

ngramify <- function(split_num=1, ngram_df, grams = 2, stop_word = T){
    cat(paste('Input data frame (rows:',length(ngram_df), '| size:',round(object.size(ngram_df)/1024/1024,0),
              'mb) \n are going to split into', split_num, 'and', grams, 'grams prediction chunks...'))
    
    ngram_df <- iconv(ngram_df, to = 'utf-8', sub=' ')
    train=gsub("<br />","",train)
    
    ngram_df <- tolower(ngram_df)
    ngram_df <- removePunctuation(ngram_df)
    ngram_df <- stripWhitespace(ngram_df)
    if(stop_word){
        ngram_df <- removeWords(ngram_df, stopwords('english'))
    }
    cat(paste('\n (Step 1 of 5) Start to create chunks...'))
    
    chunks <- list()
    for (i in 1:split_num){
        chunks[[i]] <- ngram_df[(ceiling(length(ngram_df)/split_num)*(i-1)+1):(ceiling(length(ngram_df)/split_num)*i)]
    } 
    rm(ngram_df); gc()
    
    cat(paste('\n (Step 2 of 5) Start to convert chunks into n-grams matrix...'))
    ngram_chunks <- list()
    for (j in 1:split_num){
        ngram_chunks[[j]] <- NGramTokenizer(chunks[[j]][!is.na(chunks[[j]])], Weka_control(min=grams,max=grams))
    }
    rm(chunks); gc()
    
    cat(paste('\n (Step 3 of 5) Start to integrate chunks into one matrix...'))
    ngram_chunks_all <- c()
    for (z in 1:split_num){
        ngram_chunks_all <- c(ngram_chunks_all, ngram_chunks[[z]])
    }
    rm(ngram_chunks); gc()
    
    cat(paste('\n (Step 4 of 5) Start to calculate the frequency of each term...'))
    ngram_freq_tb <- sort(table(ngram_chunks_all), decreasing=T)
    rm(ngram_chunks_all); gc()
    
    cat(paste('\n (Step 5 of 5) Finishing the process...'))
    ngram_pred <- data.frame(terms = names(ngram_freq_tb), freq = ngram_freq_tb, row.names = NULL, stringsAsFactors = F)
    rm(ngram_freq_tb); gc()
    
    return(ngram_pred)
}


freqencize <- function(text_vector, freq = FALSE){
    text_vector <- iconv(text_vector, to = 'utf-8', sub=' ')
    review_source <- VectorSource(text_vector)
    corpus <- Corpus(review_source)
    corpus <- tm_map(corpus, content_transformer(tolower), lazy = T)
    corpus <- tm_map(corpus, removePunctuation, lazy = T)
    corpus <- tm_map(corpus, stripWhitespace, lazy = T)
    corpus <- tm_map(corpus, removeWords, stopwords('english'), lazy = T)
    corpus <- tm_map(corpus, stemDocument, 'english', lazy = T)
    dtm <- DocumentTermMatrix(corpus)
    # findFreqTerms(dtm,5)
    dtm2 <- as.matrix(dtm)
    if(freq){
        frequency <- colSums(dtm2)
        frequency <- sort(frequency, decreasing=TRUE)
        return(frequency)    
    }else{
        return(dtm2)
    }
    
}

