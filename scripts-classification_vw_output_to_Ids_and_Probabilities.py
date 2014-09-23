import sys
import numpy as np
import pandas as pd
from scipy.special import expit as sigmoid

vw_classification_file = sys.argv[1]
kaggle_submission_file = sys.argv[2]


cfile = np.loadtxt(vw_classification_file)

df = pd.DataFrame({'Id':(cfile[:,1]).astype('int'), 'Predicted':sigmoid(cfile[:,0])})
df.to_csv (kaggle_submission_file, index=None)
