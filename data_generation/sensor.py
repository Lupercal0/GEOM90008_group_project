
import random
dic=[]
hight_range=[60,75,100,150,200]
for i in range(100):
    # Generate a random integer between 1 and 100
    weight= random.randint(3,7)
    hight_limit=random.choice(hight_range)
    dic.append([i+1,weight,hight_limit])

with open('sensor.txt', 'w') as file:
    for row in dic:
        print('(',row[0],',',row[1],',',row[2],')',sep='',end=',', file=file)