import numpy as np
import os 
#import pandas as pd
import matplotlib.pyplot as plt
from natsort import natsorted
from pactools import Comodulogram
import pickle

if __name__ == "__main__":

   
    path_envelopes =   "ENVELOPES_3sec_512/"
    langs = natsorted(os.listdir(path_epo))
    langs = [i.split('_env.mat')[0] for i in langs]

    fs = 512

    low_fq_width = 1.0  # Hz
    n_surrogates = 200

    low_fq_range = np.arange(1,12.5,0.5)
    high_fq_range = np.arange(20,151,5)
    langs = ['ar','en','es','eu','fi','fr','hi','hy','ja','ko','nl','ru','sv','ta','th','vi','zh']
    for num, lang in enumerate(langs):
        
        path_env = path_envelopes + lang + "_env.mat"
        
        path_out = 'PAC_512Hz/'+ lang+'/'
        if not os.path.exists(path_out):
            os.makedirs(path_out)
        
        
        # retrieve and load  data
	with open(path_env, 'rb') as f:
    		x = pickle.load(f)
	env = x['envelope']

        # make sure no nans
        newenv = []
        newnames = []
        for num,i in enumerate(env):
            j = i[~np.isnan(i)]
            if len(j) == 3*512: 
                newenv.append(j)
            else:
                print(num)
        newenv = np.asarray(newenv)
        boss = np.concatenate(newenv)
        estimator = Comodulogram(fs=fs, low_fq_range=low_fq_range,
                            low_fq_width=low_fq_width,high_fq_range=high_fq_range, method='tort',
                            n_surrogates=n_surrogates, progress_bar=True,
                            n_jobs=-1)
        estimator.fit(boss)
        save_vars = {k: v for k, v in vars(estimator).items()}
        save_vars['pac_zscore'] = estimator.comod_z_score_
        save_vars['surrogate_max_'] = estimator.surrogate_max_

        with open(path_out + lang + '_pac.pkl', 'wb') as f:
            pickle.dump(save_vars, f)
