# semscaleR
R wrapper for SemScale alghoritm - https://github.com/umanlp/SemScale.

The archive contains R wrapper for SemScale alghortim as presented in Nanni, Frederico, Goran Glavaš, Simone Paolo Ponzetto, and Heiner Stuckenschmidt (2020): Political Text Scaling 
Meets Computational Semantics. https://arxiv.org/pdf/1904.06217v2.pdf. 

The script does basic text pre-processing and saves the .txt files in a proper format to “SemScale/\_datadir/” directory. When it comes to pre-trained word embedding models, place your GloVe/Word2Vec models (matrix format) to “embs\_raw” folder and run the wrangling code to reshape the models to proper format and then copy them to “SemScale/\_embs/”.

Scaling is run using a slightly adjusted python script (scaler\_my.py or supervised-scaler\_my.py), which can processed multiple embedding models at once. Results are stored to “SemScale/\_output/”.

NOTE: Make sure your reticulate environment has all the required python libraries. For details see https://github.com/umanlp/SemScale.
