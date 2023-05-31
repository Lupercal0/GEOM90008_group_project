import random
from nltk.corpus import names
email_list=['@unimelb.edu.au','@gmail.com','@outlook.com']
student_email_list = ['@student.unimelb.edu.au','@gmail.com','@outlook.com']
dic=[]
for i in range(50):
    # Get a list of male and female names from the NLTK names corpus
    male_names = names.words('male.txt')
    female_names = names.words('female.txt')

    # Generate a random English name
    name = random.choice(male_names + female_names)
    active_status = random.choice(['true', 'false'])
    qualification_type = random.choice(['true', 'false'])
    if qualification_type == 'true':
        email = name[0:3] +email_list[random.randint(0,2)]
    else:
        email = name[0:3] +student_email_list[random.randint(0,2)]
    phone_number = "04" + "".join(random.choice("0123456789") for _ in range(8))
    dic.append([i+1,name,email,phone_number,active_status,qualification_type])

with open('operator.txt', 'w') as file:
    for row in dic:
        print('(',row[0],',\'',row[1],'\',\'',row[2],'\',\'',row[3],'\',\'',row[4],'\',\'',row[5],'\')',sep='',end=',', file=file)

