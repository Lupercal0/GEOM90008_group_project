import pandas as pd

# Read the CSV file into a pandas dataframe
df = pd.read_csv('airports_vic.csv')
with open('airports.txt', 'w') as file:
    for row in df.iterrows():
        print('(',row[1]['ident'],',\'',str(row[1]['type']).replace("'", ""),'\',\'',row[1]['name'],'\',',row[1]['latitude'],',',
              str(row[1]['longitude']),')',sep='',end=',', file=file)