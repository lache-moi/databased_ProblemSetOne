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

fig, (a,b) = plt.subplots(2)
a.set_title('A single plot')
a.bar(x,y, width = BIN_SIZE_1)
a.set_title('Histogram of number of collaborators')
a.set_xlabel('Number of collaborators')
a.set_ylabel('$log_{10}$(tally)')

# 4.2.2. Number of Publications Histogram
pub_histo = csv.reader(open("pub_tally.csv"))
pub_tally = defaultdict(int)

next(pub_histo)
for row in pub_histo:    
    pub_tally[int(row[0])//BIN_SIZE_2]+=int(row[1]) 

x = [BIN_SIZE_2*key for key in pub_tally.keys()]
y = [np.log10(val) for val in pub_tally.values()] 

b.bar(x,y, width = BIN_SIZE_2)
b.set_title('Histogram of number of publications')
b.set_xlabel('Number of publications')
b.set_ylabel('$log_{10}$(tally)')
fig.set_figheight(10)
plt.tight_layout()
plt.savefig('Collaborators_and_Publications_Histogram.pdf')
plt.close()
