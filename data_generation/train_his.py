import random
from datetime import date, timedelta

# Get the current date
today = date.today()

dic=[]

for i in range(100):
    day_diff = random.randint(1,365-30)
    train_day = today - timedelta(days=day_diff)
    dic.append([i + 1, train_day])

with open('train_hist.txt', 'w') as file:
    for row in dic:
        print('(',row[0],',\'',row[1],'\')',sep='',end=',', file=file)