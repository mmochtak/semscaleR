library(tm)
library(magrittr)
library(stringr)
library(readr)
library(reticulate)

data <- readRDS("corpus_lem.rds") # this file is not available; use your own corpus

#filter
meta_nfo <- str_split(data$doc_id, "_")
data$type <- unlist(lapply(meta_nfo, `[[`, 1))
data <- subset(data, type == "FR")

# clean
data$lem <- data$lem %>%
            tolower() %>%
            removeWords(stopwords("en")) %>%
            removeNumbers() %>%
            removePunctuation() %>%
            str_squish()

# save clean text in proper format as individual files
for (n in 1:nrow(data)) {
  text <- paste0("en\n", data$lem[n])
  write_lines(text, path = paste0("SemScale/_datadir/", data$doc_id[n], ".txt"))
}

# save pre-trained GloVe (or Word2Vec) model (matrix format) to .vec format
models <- list.files("embs_raw/", pattern = "\\.RDS", full.names = T)
lang <- "en"

for (model in models) {
  vec_file <- c()
  glove_m <- readRDS(model)
  for(n in 1:nrow(glove_m)) { 
    mapped_word <- paste0(lang, "__", rownames(glove_m)[n]) %>%
      paste0(., " ", paste(glove_m[n, ], collapse = " "), " ")
    vec_file <- c(vec_file, mapped_word)
  }
  new_file <- gsub("\\.RDS", "", model) %>%
    gsub("embs_raw/", "", .)
  writeLines(vec_file, paste0("SemScale/_embs/", new_file, ".vec"))
}

# run scaling in python
setwd("SemScale/")
  source_python("scaler_my.py")
  #OR
  source_python("supervised-scaler_my.py")

