from embeddings import text_embeddings
import nlp
from helpers import io_helper
from sts import simple_sts 
from sys import stdin
import argparse
import os
from os import walk
from datetime import datetime

supported_lang_strings = {"en" : "english", "fr" : "french", "de" : "german", "es" : "spanish", "it" : "italian"}

files = io_helper.load_all_files("_datadir/")
filenames = [x[0] for x in files]
texts = [x[1] for x in files]

languages = [x.split("\n", 1)[0].strip().lower() for x in texts]
texts = [x.split("\n", 1)[1].strip().lower() for x in texts]

langs = [(l if l in supported_lang_strings.values() else supported_lang_strings[l]) for l in languages]
stopwords = []
_, _, embs_files = next(walk("_embs/"))

for path in embs_files:
    predictions_serialization_path = "_output/"+path+"_output.txt"
    embeddings = text_embeddings.Embeddings()
    embeddings.load_embeddings("_embs/"+path, limit = None, language = 'default', print_loading = True, skip_first_line = True)
    nlp.scale_efficient(filenames, texts, langs, embeddings, predictions_serialization_path, stopwords)
