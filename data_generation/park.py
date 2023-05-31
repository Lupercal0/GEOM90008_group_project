import pandas as pd

# Read the CSV file into a pandas dataframe
df = pd.read_csv('park_vic.csv')
with open('park.txt', 'w') as file:
    for row in df.iterrows():
        print('(',row[1]['id'],',\'',str(row[1]['Name']).replace("'", ""),'\',',row[1]['latitude'],',',row[1]['longitude'],')',sep='',end=',', file=file)