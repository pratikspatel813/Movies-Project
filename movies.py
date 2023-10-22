# Import all packages needed
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

# Import the dataset
df = pd.read_csv(r"C:\Users\Pratik Patel\Desktop\Movies_Project\imdb_top_1000.csv")

#Print the first five records
df.head()


#Clean up the data. Let's drop a few columns that we don't need
df = df.drop(columns=['Poster_Link', 'Overview', 'Certificate'])

#Take a lot of the data types in the dataset
datatypes = df.dtypes
datatypes

#We see that Gross is an "object" type. We will want to convert it to a numeric. We will remove the commas and fill in the blank cells with 0
df['Gross'] = df['Gross'].str.replace(',','', regex=True)
df['Gross'].fillna('0', inplace = True)
df['Gross'] = pd.to_numeric(df['Gross'], errors='coerce')
datatypes = df.dtypes
datatypes
# Now we can make charts using Gross

#Bar Chart with Genre on the x-axis and Gross on the y-axis
#Group the data by Genre and calculate the sum of Gross for each Genre
genre_grouped = df.groupby('Genre')['Gross'].sum().reset_index()

#Sort the data by Gross in DESC
genre_grouped = genre_grouped.sort_values(by='Gross', ascending = False)

#We want the Top 5 Highest Grossing Genres
top_5_genre = genre_grouped.head(5)
#Create the bar chart
plt.figure(figsize=(10,6))
bar_colors = ['blue', 'green', 'red', 'purple', 'orange']
genre_plot = plt.bar(top_5_genre['Genre'],top_5_genre['Gross'], color=bar_colors)
plt.xlabel('Genre')
plt.ylabel('Total Gross')
plt.title('Total Gross by Genre')
plt.xticks(rotation=45) #rotate labels for readability
plt.gca().get_yaxis().set_major_formatter(ticker.FuncFormatter(lambda x, _: f"{x:,.0f}")) #for better readable on the y-axis
plt.tight_layout()
plt.show(genre_plot)


#Top 5 Highest Grossing Director
director_grouped = df.groupby('Director')['Gross'].sum().reset_index()
director_grouped = director_grouped.sort_values(by='Gross', ascending = False)
top_5_director = director_grouped.head(5)
plt.figure(figsize=(10,6))
director_plot = plt.bar(top_5_director['Director'],top_5_director['Gross'], color=bar_colors)
plt.xlabel('Director')
plt.ylabel('Total Gross')
plt.title('Total Gross by Top 5 Directors')
plt.xticks(rotation = 45)
plt.gca().get_yaxis().set_major_formatter(ticker.FuncFormatter(lambda x, _: f"{x:,.0f}"))
plt.tight_layout()
plt.show(director_plot)

#Take a look at the correlation between the columns
correlation = df[['IMDB_Rating','Meta_score','Gross', 'No_of_Votes']].corr()
plt.figure(figsize=(10, 8))
heatmap = sns.heatmap(correlation).set_title('Heatmap of the Correlation Matrix')
plt.show(heatmap)
print(correlation)
