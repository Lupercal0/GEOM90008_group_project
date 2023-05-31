
import random
from datetime import date, timedelta

# Get the current date
today = date.today()

# Calculate the date one month ago
ten_days_ago = today - timedelta(days=10)
# Get the current date
dic=[]

problem_list = ['all good','all good','all good','all good','all good','all good','all good','all good','all good','slight misalignment']
for i in range(100):
    day_diff = random.randint(1,365-30)
    inspection_day = today - timedelta(days=day_diff)
    problem=problem_list[random.randint(0,9)]
    dic.append([i+1,inspection_day,problem])

with open('sensor_hist.txt', 'w') as file:
    for row in dic:
        print('(',row[0],',\'',row[1],'\',\'',row[2],'\')',sep='',end=',', file=file)