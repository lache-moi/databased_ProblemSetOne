import csv
import matplotlib.pyplot as plt
import numpy as np
from collections import defaultdict
BIN_SIZE_1 = 100
BIN_SIZE_2 = 50

# 4.2.1. Number of Collaborators Histogram
collab_histo = csv.reader(open("collab_tally.csv"))
collab_tally = defaultdict(int)


next(collab_histo)
for row in collab_histo:    
    collab_tally[int(row[0])//BIN_SIZE_1]+=int(row[1]) 

x = [BIN_SIZE_1*key for key in collab_tally.keys()]
y = [np.log10(val) for val in collab_tally.values()] 

plt.bar(x,y, width = BIN_SIZE_1)
plt.savefig('Collaborators Histogram')
plt.close()

# 4.2.2. Number of Publications Histogram
pub_histo = csv.reader(open("pub_tally.csv"))
pub_tally = defaultdict(int)

next(pub_histo)
for row in pub_histo:    
    pub_tally[int(row[0])//BIN_SIZE_2]+=int(row[1]) 

x = [BIN_SIZE_2*key for key in pub_tally.keys()]
y = [np.log10(val) for val in pub_tally.values()] 
plt.bar(x,y, width = BIN_SIZE_2)
plt.savefig('Publications Histogram')
plt.close()