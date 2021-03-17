import codecs
from scipy import stats
import numpy as np
import sys

# here's a simple function to compute pairwise accuracy
def pairwise_accuracy(golds, preds):
	count_good = 0.0
	count_all = 0.0
	for i in range(len(golds) - 1):
		for j in range(i+1, len(golds)):
			count_all += 1.0
			diff_gold = golds[i] - golds[j]
			diff_pred = preds[i] - preds[j]
			if (diff_gold * diff_pred >= 0):
				count_good += 1.0
	return count_good / count_all
