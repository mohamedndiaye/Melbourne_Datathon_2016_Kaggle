setwd('/Users/ivanliu/Downloads/datathon2016/Melbourne_Datathon_2016_Kaggle')
rm(list=ls());gc()
library(Matrix)
load('../data/model/total.RData')
source('./rscripts/a.preprocess_func.R')

### 1.TF/IDF features - title, abstract, raw_job_type, raw_location
### unigram
    text_vector <- total$title
    dtm_title <- tfidf_func(text_vector, ngrams = 1, minDocFreq = 2, wordLengths = 2, wordLengths_max = Inf, idf = T);
    # dtm_title <- removeSparseTerms(dtm_title, 1 - 3/nrow(dtm_title)) 
    bow_names <- colnames(dtm_title)
    dtm_title <- sparseMatrix(dtm_title$i,dtm_title$j,x=dtm_title$v,dimnames = list(NULL,bow_names))
    dim(dtm_title)
    title_key_words_cnt <- rowSums(dtm_title >0)
    
    text_vector <- total$abstract
    dtm_abstract <- tfidf_func(text_vector, ngrams = 1, minDocFreq = 2, wordLengths = 2, wordLengths_max = Inf, idf = T)
    # dtm_abstract <- removeSparseTerms(dtm_abstract, 1 - 3/nrow(dtm_abstract))
    bow_names <- colnames(dtm_abstract)
    dtm_abstract <- sparseMatrix(dtm_abstract$i,dtm_abstract$j,x=dtm_abstract$v,dimnames = list(NULL,bow_names))
    dim(dtm_abstract)
    abs_key_words_cnt <- rowSums(dtm_abstract >0)
    
    text_vector <- total$raw_job_type
    dtm_job_type <- tfidf_func(text_vector, ngrams = 1, minDocFreq = 2,wordLengths = 2, wordLengths_max = Inf, idf = T);
    # dtm_job_type <- removeSparseTerms(dtm_job_type, 1 - 3/nrow(dtm_job_type)) 
    bow_names <- colnames(dtm_job_type)
    dtm_job_type <- sparseMatrix(dtm_job_type$i,dtm_job_type$j,x=dtm_job_type$v,dimnames = list(NULL,bow_names))
    dim(dtm_job_type)
    type_key_words_cnt <- rowSums(dtm_job_type >0)

    text_vector <- total$raw_location
    dtm_location <- tfidf_func(text_vector, ngrams = 1, minDocFreq = 2, wordLengths = 2, wordLengths_max = Inf, idf = T);
    # dtm_location <- removeSparseTerms(dtm_location, 1 - 3/nrow(dtm_location)) 
    bow_names <- colnames(dtm_location)
    dtm_location <- sparseMatrix(dtm_location$i,dtm_location$j,x=dtm_location$v,dimnames = list(NULL,bow_names))
    dim(dtm_location)
    loc_key_words_cnt <- rowSums(dtm_location >0)

### bigrams    
    text_vector <- total$title
    dtm_title_bi <- tfidf_func(text_vector, ngrams = 2, minDocFreq = 3, wordLengths = 2, wordLengths_max = Inf, idf = T);
    # dtm_title_bi <- removeSparseTerms(dtm_title_bi, 1 - 3/nrow(dtm_title_bi)) 
    bow_names <- paste0('bi_',colnames(dtm_title_bi))
    dtm_title_bi <- sparseMatrix(dtm_title_bi$i,dtm_title_bi$j,x=dtm_title_bi$v,dimnames = list(NULL,bow_names))
    dim(dtm_title_bi)
    title_key_words_cnt_bi <- rowSums(dtm_title_bi >0)
    
    text_vector <- total$abstract
    dtm_abstract_bi <- tfidf_func(text_vector, ngrams = 2, minDocFreq = 3, wordLengths = 2, wordLengths_max = Inf, idf = T)
    # dtm_abstract_bi <- removeSparseTerms(dtm_abstract_bi, 1 - 3/nrow(dtm_abstract_bi))
    bow_names <- paste0('bi_abs_',colnames(dtm_abstract_bi))
    dtm_abstract_bi <- sparseMatrix(dtm_abstract_bi$i,dtm_abstract_bi$j,x=dtm_abstract_bi$v,dimnames = list(NULL,bow_names))
    dim(dtm_abstract_bi)
    abs_key_words_cnt_bi <- rowSums(dtm_abstract_bi >0)
    
    text_vector <- total$raw_job_type
    dtm_job_type_bi <- tfidf_func(text_vector, ngrams = 2, minDocFreq = 3,wordLengths = 2, wordLengths_max = Inf, idf = T);
    # dtm_job_type_bi <- removeSparseTerms(dtm_job_type_bi, 1 - 3/nrow(dtm_job_type_bi)) 
    bow_names <- paste0('bi_job_',colnames(dtm_job_type_bi))
    dtm_job_type_bi <- sparseMatrix(dtm_job_type_bi$i,dtm_job_type_bi$j,x=dtm_job_type_bi$v,dimnames = list(NULL,bow_names))
    dim(dtm_job_type)
    type_key_words_cnt_bi <- rowSums(dtm_job_type_bi >0)
    
    text_vector <- total$raw_location
    dtm_location_bi <- tfidf_func(text_vector, ngrams = 2, minDocFreq = 3, wordLengths = 2, wordLengths_max = Inf, idf = T);
    # dtm_location_bi <- removeSparseTerms(dtm_location_bi, 1 - 3/nrow(dtm_location_bi)) 
    bow_names <- paste0('bi_loc_',colnames(dtm_location_bi))
    dtm_location_bi <- sparseMatrix(dtm_location_bi$i,dtm_location_bi$j,x=dtm_location_bi$v,dimnames = list(NULL,bow_names))
    dim(dtm_location_bi)
    loc_key_words_cnt_bi <- rowSums(dtm_location_bi >0)

### trigrams    
    text_vector <- total$title
    dtm_title_tri <- tfidf_func(text_vector, ngrams = 3, minDocFreq = 3, wordLengths = 2, wordLengths_max = Inf, idf = T);
    # dtm_title_tri <- removeSparseTerms(dtm_title_tri, 1 - 3/nrow(dtm_title_tri)) 
    bow_names <- paste0('tri_',colnames(dtm_title))
    dtm_title_tri <- sparseMatrix(dtm_title_tri$i,dtm_title_tri$j,x=dtm_title_tri$v,dimnames = list(NULL,bow_names))
    dim(dtm_title_tri)
    title_key_words_cnt_tri <- rowSums(dtm_title_tri >0)
    
    text_vector <- total$abstract
    dtm_abstract_tri <- tfidf_func(text_vector, ngrams = 3, minDocFreq = 3, wordLengths = 2, wordLengths_max = Inf, idf = T)
    # dtm_abstract_tri <- removeSparseTerms(dtm_abstract_tri, 1 - 3/nrow(dtm_abstract_tri))
    bow_names <- paste0('tri_abs_',colnames(dtm_abstract_tri))
    dtm_abstract_tri <- sparseMatrix(dtm_abstract_tri$i,dtm_abstract_tri$j,x=dtm_abstract_tri$v,dimnames = list(NULL,bow_names))
    dim(dtm_abstract_tri)
    abs_key_words_cnt_tri <- rowSums(dtm_abstract_tri >0)

### save data
save(dtm_title, 
     dtm_abstract,
     dtm_job_type,
     dtm_location,
     title_key_words_cnt,
     abs_key_words_cnt,
     type_key_words_cnt,
     loc_key_words_cnt,
     dtm_title_bi, 
     dtm_abstract_bi,
     dtm_job_type_bi,
     dtm_location_bi,
     title_key_words_cnt_bi,
     abs_key_words_cnt_bi,
     type_key_words_cnt_bi,
     loc_key_words_cnt_bi,
     dtm_title_tri, 
     dtm_abstract_tri,
     title_key_words_cnt_tri,
     abs_key_words_cnt_tri,
     file = '../data_new/idf_unigram_to_trigrams_full_20160502.RData'
)
# load('../data_new/idf_unigram_to_trigrams_full_20160502.RData')


### 2. binary features - salary_type
    salary_type <- ifelse(total$salary_type == 'h', 0, 1)
    salary_type[is.na(salary_type)] <- 1

### 3. numerical features - salary_min, salary_max
    load('../data_new/avg_salary.RData')
    feat_list <- c()
    for(c in unique(total$class_id)[!is.na(unique(total$class_id))]){
        feat_name <- paste0('min_salary_ratio_',c)
        total[,feat_name] <- total[,'salary_min'] / avg_salary[avg_salary$class_id == c,'min_salary']
        total[is.na(total[,feat_name]),feat_name] <- 1
        feat_list <- c(feat_list, feat_name)
    }
    for(c in unique(total$class_id)[!is.na(unique(total$class_id))]){
        feat_name <- paste0('max_salary_ratio_',c)
        total[,feat_name] <- total[,'salary_max'] / avg_salary[avg_salary$class_id == c,'max_salary']
        total[is.na(total[,feat_name]),feat_name] <- 1
        feat_list <- c(feat_list, feat_name)
    }
    for(c in unique(total$class_id)[!is.na(unique(total$class_id))]){
        feat_name <- paste0('var_salary_ratio_',c)
        total[,feat_name] <- (total[,'salary_max'] - total[,'salary_min']) / avg_salary[avg_salary$class_id == c,'var_salary']
        total[is.na(total[,feat_name]),feat_name] <- 1
        feat_list <- c(feat_list, feat_name)
    }
    salary_features <- total[,feat_list]
    
    log.salary_min <- log(total$salary_min)
    log.salary_min <- ifelse(is.na(log.salary_min), mean(log.salary_min, na.rm = T), log.salary_min)
    log.salary_max <- log(total$salary_max)
    log.salary_max <- ifelse(is.na(log.salary_max), mean(log.salary_max, na.rm = T), log.salary_max)
    log.salary_mean <- ifelse(is.na(log((total$salary_max + total$salary_min) / 2))
                              , mean(log((total$salary_max + total$salary_min) / 2), na.rm = T)
                              , log((total$salary_max + total$salary_min) / 2))
    log.salary_diff <- abs(ifelse(is.na((total$salary_max - total$salary_min))
                                  , mean((total$salary_max - total$salary_min), na.rm = T)
                                  , (total$salary_max - total$salary_min)))

### 4. clicks & impression freq
    load('../data_new/user_click_freq_pct.RData')
    load('../data_new/tgt_impr_cnt_pct.RData')
    tgt_impr_all_cnt <- rowSums(tgt_impr_cnt[,5:34] > 0)
    tgt_user_click_cnt <- rowSums(tgt_user_click[,5:34] > 0)

### 5. Geo Info
    load('../data_new/geo_info_dummy.RData')

### 5. combine model data
    rm_feat <- colSums(dtm_title[total[,'hat']==-1,])
    dtm_title <- dtm_title[,rm_feat!=0]
    
    rm_feat <- colSums(dtm_abstract[total[,'hat']==-1,])
    dtm_abstract <- dtm_abstract[,rm_feat!=0]
    
    rm_feat <- colSums(dtm_job_type[total[,'hat']==-1,])
    dtm_job_type <- dtm_job_type[,rm_feat!=0]
    
    rm_feat <- colSums(dtm_location[total[,'hat']==-1,])
    dtm_location <- dtm_location[,rm_feat!=0]
    
    rm_feat <- colSums(dtm_title_bi[total[,'hat']==-1,])
    dtm_title_bi <- dtm_title_bi[,rm_feat!=0]
    
    rm_feat <- colSums(dtm_abstract_bi[total[,'hat']==-1,])
    dtm_abstract_bi <- dtm_abstract_bi[,rm_feat!=0]
    
    rm_feat <- colSums(dtm_job_type_bi[total[,'hat']==-1,])
    dtm_job_type_bi <- dtm_job_type_bi[,rm_feat!=0]
    
    rm_feat <- colSums(dtm_location_bi[total[,'hat']==-1,])
    dtm_location_bi <- dtm_location_bi[,rm_feat!=0]
    
    rm_feat <- colSums(dtm_title_tri[total[,'hat']==-1,])
    dtm_title_tri <- dtm_title_tri[,rm_feat!=0]
    
    rm_feat <- colSums(dtm_abstract_tri[total[,'hat']==-1,])
    dtm_abstract_tri <- dtm_abstract_tri[,rm_feat!=0]

### PT3
    pt3 <- as.matrix(cbind(salary_type = salary_type,
                           salary_features,
                           log_salary_min = log.salary_min,
                           log_salary_max = log.salary_max,
                           log_salary_mean = log.salary_mean,
                           log_salary_diff = log.salary_diff,
                           
                           tgt_impr_cnt[,5:34],
                           tgt_impr_all_cnt = tgt_impr_all_cnt,
                           tgt_user_click[,5:34],
                           tgt_user_click_cnt = tgt_user_click_cnt,
                           
                           title_key_words_cnt = title_key_words_cnt,
                           abs_key_words_cnt = abs_key_words_cnt,
                           type_key_words_cnt = type_key_words_cnt,
                           loc_key_words_cnt = loc_key_words_cnt,
                           
                           title_key_words_cnt_bi = title_key_words_cnt_bi,
                           abs_key_words_cnt_bi = abs_key_words_cnt_bi,
                           type_key_words_cnt_bi = type_key_words_cnt_bi,
                           loc_key_words_cnt_bi = loc_key_words_cnt_bi,
                           
                           title_key_words_cnt_tri = title_key_words_cnt_tri,
                           abs_key_words_cnt_tri = abs_key_words_cnt_tri,
                           
                           geo_info_dummy[,2:61]))
    
    library(caret)
    pre <- preProcess(pt3, method = c("center", "scale"))
    pt3_scale <- predict(pre, pt3)
    
    for(i in 1:ncol(pt3)){
        print(i)
        pt3[,i] <- scale(pt3[,i], center = T, scale = T)
    }
    pt3_scale <- pt3
    
    all <- cbind(job_id = total$job_id, 
                 dtm_title,
                 dtm_abstract,
                 dtm_job_type,
                 dtm_location,
                 dtm_title_bi,
                 dtm_abstract_bi,
                 dtm_job_type_bi,
                 dtm_location_bi,
                 dtm_title_tri,
                 dtm_abstract_tri,
                 pt3_scale,
                 obj_hat = total$hat
    )
    
    extra_feature <- colnames(pt3)
    class_id <- total[all[,'obj_hat'] != -1, 'class_id']
    train <- all[all[,'obj_hat'] != -1, ]
    test <- all[all[,'obj_hat'] == -1, ]
    
    save(train,test,extra_feature,class_id, file ='../data_new/model_trigram_idf_20160502_scale_full.RData')


