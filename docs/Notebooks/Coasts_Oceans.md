### [Run in Google Colab](https://colab.research.google.com/github/taiao/taiao-docs/blob/main/docs/Notebooks/Coasts_Oceans.ipynb)

## Python libraries


```python
# We install requests which is a python library for executing HTTP requests. We also install json which will be used to process the retrieved records.
import sys
!{sys.executable} -m pip install requests json
```

## Query Server


```python
# Configure the remote server URL
url = "https://wave.storm-surge.cloud.edu.au/wave_mysql/"
```


```python
# Query Server & extract data
wave_data = requests.request("GET", url)
data_points = json.loads(wave_data.text)
```


```python
# Check number of rows retrieved
print("Number of rows retrieved: ", str(len(data_points['results'])))
```

## Process raw data


```python
# Iterate over first 5 rows in resultset
for row in data_points['results'][0:5]:
    # Entire record
    print(json.dumps(row, indent=4, sort_keys=True))
    # Access Individual elements
    print(row['island'], row['datetime'], row['m.y'])
    
```
