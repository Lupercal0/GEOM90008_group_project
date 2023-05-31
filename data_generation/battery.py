
import random
dic=[]
for i in range(100):
    # Generate a random integer between 1 and 100
    flag1= random.randint(1,2)
    if flag1==1:
        weight=82
    else:
        weight=121

    battery_level = random.randint(20, 100)
    dic.append([i+1,weight,battery_level])

with open('battery.txt', 'w') as file:
    for row in dic:
        print('(',row[0],',',row[1],',',row[2],')',sep='',end=',', file=file)
