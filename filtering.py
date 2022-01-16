import json
import dask.dataframe as dd
from nltk.stem.snowball import SnowballStemmer

from extraction import extract_word
stemmer = SnowballStemmer("english")

def stem(concept):
    w = extract_word(concept)
    return stemmer.stem(w)

kb = dd.read_csv('conceptnet-assertions-5.7.0.csv',sep='\t',names=['URI','relation','from','to','extra'])

result = kb[kb['from'].str.startswith('/c/en/') & kb['to'].str.startswith('/c/en/')]
en_kb = result.compute()
en_kb['weight'] = en_kb['extra'].apply(lambda x:json.loads(x)['weight'])
en_kb = en_kb[en_kb['weight']>=1]

from_stems = en_kb['from'].apply(stem)
to_stems = en_kb['to'].apply(stem)
en_kb = en_kb[from_stems != to_stems]

# en_kb.to_csv('conceptnet_en.csv',index=False)
en_kb.to_csv('conceptnet_en_filtered.csv',index=False)