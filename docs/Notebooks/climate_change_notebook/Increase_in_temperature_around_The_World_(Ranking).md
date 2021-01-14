In this notebook I'm going to make an study about the increase of the temperature. Not the temperature itself.

It will be divided into this sections:

- Introduction


- Linear Regression of the mean temperature per year

With the temperature of every city, I'm going to calculate the slope of the mean temperature as a function of the years.
So this information will tell us if one city is getting hotter more rapidly than others. We will know how many degrees increases the temperature in one year.

- Maximum value per country

For each country, I'm going to calculate the city that is increasing it's temperature more qickly.
It will be like the ranking of the worst cities in the world to live in the future (in terms of Global Warming).
Of course, I don't pretend a massive migration. It's just a way to understand the data.

- Minimum value per country

For each country, I'm going to calculate the city that is increasing it's temperature more slowly.
It will be like the ranking of the best cities in the world to live in the future (in terms of Global Warming).
Again, I don't pretend a massive migration. It's just a way to understand the data.

- Conclusions



I will get some warning messages... please, be comprehensive. I'm just a beginner :)






### Introduction

My work is going to be the visualization as a ranking of how is increasing the temperature in every country. 

I thought about plotting all the cities in the dataset, but it was too much to see it in only one plot. I also didn't want one plot for country, as there are many countries, and it will became an eternal notebook. 
So I finaly decided to plot one city per country. 159 cities. I think it is enough to make an idea of the situation with one plot (finally I made two).

The plot 0 that I did was the global temperature vs years. I'm not shearing it in this notebook. But if you see one from other notebook you will realize that from 1975, the temperature is increasing almost linearly. So I thought to calculate the slope of this straight line.

I'm going to calculate the slope of the main temperature for each year and city from this moment, 1975, where the linear regression seems to be a good model to fit the data. I'm taking into account countries because colonialism made many cities to have the same name in different countries.

Any way, I'm not plotting the current mean temperature of those cities, so the increase must be understud as a tendence, not a temperature itself.

And I'm always suposing that the warming is goin to be the same as it is nowadays.



```python
import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
pd.set_option('mode.chained_assignment','warn')

pd.plotting.register_matplotlib_converters()
import matplotlib.pyplot as plt
%matplotlib inline
from mpl_toolkits.mplot3d import Axes3D
import seaborn as sns

from sklearn import linear_model
from sklearn.model_selection import train_test_split

# Input data files are available in the read-only "../input/" directory
# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory

import os
for dirname, _, filenames in os.walk('/kaggle/input'):
    for filename in filenames:
        print(os.path.join(dirname, filename))

# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using "Save & Run All" 
# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session
```

### Linear Regression of the mean temperature per year

I'm going to calculate the average temperature of every year for every city and calculate the linear regression for every city in the data set.
I'm doing this from 1975 as it seams to be the beggining of the current Global Warming.


```python
Change_By_City = pd.read_csv(r"/kaggle/input/climate-change-earth-surface-temperature-data/GlobalLandTemperaturesByCity.csv")
```


```python
Change_By_City=Change_By_City.dropna(axis=0,how='any',subset=['AverageTemperature', 'Latitude', 'Longitude'])
Change_By_City["Year"]=Change_By_City.dt.str[0:4] 
av_by_year=Change_By_City.groupby(['Year','Latitude','Longitude'])['AverageTemperature'].transform('mean')
Change_By_City["Average_By_Year"]=av_by_year.loc[:,]
Change_By_City.sort_values(['Year','Country','City'], inplace=True)
Change_By_City_By_Year=Change_By_City.drop_duplicates(subset=['Year','Country','City'])
mask=Change_By_City_By_Year['Year']>='1975'
Last_Change_By_City_By_Year=Change_By_City_By_Year.loc[mask,:]

def my_model(X,y):
    '''Given X and y, this function fits the Linear Regression model
    and returns coef, intercept and score'''
    change_model = linear_model.LinearRegression(fit_intercept=True)
    change_model.fit(X,y)
    score=change_model.score
    change_model.score(X,y)
    a,b=change_model.coef_,change_model.intercept_
    return(a,b,score)
Countries=np.unique(Last_Change_By_City_By_Year['Country'])
Last_Change_By_City_By_Year=Last_Change_By_City_By_Year.sort_values(['Country','City'],  
               axis = 0, ascending = True) 
slope=[]
Country=[]
City=[]
for i in Countries:
    mask_Country=Last_Change_By_City_By_Year['Country']==i
    My_Country=Last_Change_By_City_By_Year[mask_Country]
    Cities=np.unique(My_Country['City'])
    for j in Cities:
        mask_City=My_Country['City']==j
        My_City=My_Country[mask_City]
        X = My_City.iloc[:,7].values.reshape(-1, 1)
        y = My_City.iloc[:,8].values
        (a,b,score)=my_model(X,y)
        slope.append(a[0])
        City.append(j)
        Country.append(i)
Change_By_Country_City=Last_Change_By_City_By_Year.drop_duplicates(subset=['Country','City'])
Change_By_Country_City.reset_index(inplace = True) 
slope_by_city=pd.DataFrame(slope,columns=['Slope'])
city_by_city=pd.DataFrame(City)
country_by_city=pd.DataFrame(Country)
slope_by_city.loc[:,'Slope']
Change_By_Country_City["Slope_by_city"]=slope_by_city.loc[:,'Slope']
```


```python
Change_By_Country_City.head()
```

To understand it, take the first row. Baflan in Afganistan.

Its Average Temperature by Year is 10.2630 ºC. 

Its slope is 0.034176.

So, for 2050 we can calculate how many years we want to predict in the future:

\begin{align}
\displaystyle {y} &= 2050 - 1975 &= 75
\end{align}

We have to calculate the temperature from 1975, to 75 years later.

\begin{align}
\displaystyle T &= 10.2630 + 75*0.034176 &= 10.2630 + 2.5632 = 12,8262
\end{align}

12.8262 will be the predicted temperature in 2050 in Baflan (Afganistan). 

This calculate, can be done easily with the method predict of LinearRegression. But I wanted just to show what it means.

### Maximum value per country

Here, from the slope of each city, I'm going to calculate for each country, wich is the city that is warming more quickly (higher slope).



```python
biggest_increasing=Change_By_Country_City.groupby(['Country'])['Slope_by_city'].transform('max')
Change_By_Country_City["biggest_increasing"]=biggest_increasing.loc[:,]
mini_increasing=Change_By_Country_City.groupby(['Country'])['Slope_by_city'].transform('min')
Change_By_Country_City["mini_increasing"]=mini_increasing.loc[:,]
Change_By_City_By_Year=Change_By_City.drop_duplicates(subset=['Year','Country','City'])
Max_Change_By_Country=Change_By_Country_City[['City','Country','Slope_by_city','biggest_increasing']] \
[Change_By_Country_City.Slope_by_city==Change_By_Country_City.biggest_increasing] \
    .drop_duplicates(subset=['Country']) \
    .sort_values('Slope_by_city',ascending=False) \
    .reset_index(drop=True)
def city_country (data):
    new_list=[]
    for row in range(data.shape[0]):
        new=str(data['City'].iloc[row]+'('+data['Country'].iloc[row]+')')
        new_list.append(new)
    return(new_list)

new_list=city_country(Max_Change_By_Country)
Max_Change_By_Country["CityCountry"] = new_list

sns.set(style="whitegrid",font_scale=0.9)
f, ax = plt.subplots(figsize=(15, 30))
sns.set_color_codes("pastel")
sns.barplot(x="biggest_increasing", y="CityCountry", data=Max_Change_By_Country,
            palette="Reds_d")
ax.legend(ncol=2, loc="lower right", frameon=True)
ax.set(xlim=(-0.01,0.065), ylabel="",
       xlabel="Increment of Temperature per year")
sns.despine(left=True, bottom=True)
```

So, we can see that the city in the world that is increasing it's temperature more rapidly is Belgorod in Russia. It's the city that increases it's temperature more rapidly in Russia, wich is the first of the ranking.

The second one is Pavlohrad in Ukraine. But you have to understand that maybe, the second city that increases the temperature more rapidly in the world is again in Russia. Pavlohrad is the more rapid in Ukraine, so it puts Ukraine in the second place in this ranking.

Finaly, Tarija in Bolivia is the city that is getting worm more rapidly in Bolivia, but its speed is the slowest in this ranking.

### Minimum value per country


Here I'm going to do the same as before but for de minimum slope in each country.

The only difference is that I'm going to order the slope ascendig in the plot.



```python
Min_Change_By_Country=Change_By_Country_City[['City','Country','Slope_by_city','mini_increasing']] \
[Change_By_Country_City.Slope_by_city==Change_By_Country_City.mini_increasing] \
    .drop_duplicates(subset=['Country']) \
    .sort_values('Slope_by_city',ascending=True) \
    .reset_index(drop=True)
new_list=city_country(Min_Change_By_Country)
Min_Change_By_Country["CityCountry"] = new_list

sns.set(style="whitegrid",font_scale=0.9)
f, ax = plt.subplots(figsize=(15, 30))
sns.set_color_codes("pastel")
sns.barplot(x="mini_increasing", y="CityCountry", data=Min_Change_By_Country,
            palette="Blues_d")
ax.legend(ncol=2, loc="lower right", frameon=True)
ax.set(xlim=(-0.01,0.065), ylabel="",
       xlabel="Increment of Temperature per year")
sns.despine(left=True, bottom=True)
```

Here we can see that the first city in this ranking, Oruro in Bolivia, is decreasing its temperature, as it's slope even is negative. 

The rest of the world is increasing it.




### Conclusions

As we have seen the worst warming in the world will be in Russia and the best in Bolivia.

Attending to the plots, it seems that Bolivia wont suffer Global Warming as other countries.

I would like to guess what factors make some cities to worm more rapidly to others. Maybe industry, altitude, to be next to an ocean or a sea... in theese datasets we don't have all this information. It would be great to complete it a little. But I think it was not the purpose of theese datasets. It just wanted to evidence that The Earth is getting warm. And my purspose was to know how quickly it was happening.

So now you know where the temperature will change more and less in the next years. Think about it. 

And thanks for reading until here :)
