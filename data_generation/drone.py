import pandas as pd
import numpy as np
import random
from datetime import date, timedelta

# Get the current date
today = date.today()
dic=[]
for i in range(100):
    # Generate a random integer between 1 and 100
    flag1= random.randint(1,2)
    if flag1==1:
        weight=150
    else:
        weight=160
    day_diff = random.randint(1,365*2-30)
    inspection_day = today - timedelta(days=day_diff)
    dic.append([i + 1, weight,inspection_day])

with open('drone.txt', 'w') as file:
    for row in dic:
        print('(',row[0],',',row[1],',\'',row[2],'\')',sep='',end=',', file=file)

