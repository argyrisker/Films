import pandas as pd
import os
import ast

file_path = os.path.join(os.path.expanduser("~"), "Desktop", "Πληροφορική","4ο Εξάμηνο", "Βάσεις Δεδομένων", "Ασκήσεις", "2η Άκσηση", "Dataset", "keywords.csv ")
df = pd.read_csv(file_path)
print(df)

data=[]
for x in df['keywords']:
    data.append(ast.literal_eval(x))

movie_keyword_pairs = []
id_name=[]

for index, row in df.iterrows():
    movie_id = row['movie_id']
    keywords = data[index]

    for keyword in keywords:
        keyword_id = keyword['id']
        keyword_name = keyword['name']


        movie_keyword_pairs.append({'movie_id': movie_id, 'keyword_id': keyword_id})


        id_name.append({'id': keyword_id, 'name': keyword_name})


movie_keyword_df = pd.DataFrame(movie_keyword_pairs)
id_name_df = pd.DataFrame(id_name)



id_name_df = id_name_df.drop_duplicates(subset=['id'])

#df to CSV
movie_keyword_df.to_csv('hasKeyword.csv', index=False)
id_name_df.to_csv('Keyword.csv', index=False)

print("********************************************************")
print(id_name_df)
print("********************************************************")
print(movie_keyword_df)
