import pandas as pd

# Read the CSV file into a pandas dataframe
df = pd.read_csv('C:/Users/84446/Desktop/hospital.csv')
with open('sql.txt', 'w') as file:
    for row in df.iterrows():
        print('(',row[1]['id'],',\'',str(row[1]['Name']).replace("'", ""),'\',',row[1]['Latitude'],',',row[1]['Longitude'],',\'',
              str(row[1]['Sector']).replace("'", ""),'\',\'',str(row[1]['LHN']).replace("'", ""),'\',\'',str(row[1]['PHN']).replace("'", ""),'\')',sep='',end=',', file=file)