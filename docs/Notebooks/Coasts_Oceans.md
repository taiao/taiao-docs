## Wave Projection Data - New Zealand

Here we provide four time-slices of high resolution (9 km) wave climate data for the New Zealand waters. We developed a set of historical and projected (1993–2006, 2026–2046, 2080–2100) wave climatologies from 3 global climate models (ACCESS1-0, CNRM-CM5 and MIROC5) and two representative concentration pathways (RCP 4.5, RCP 8.5).

This data, and associated datsets are described in detail at the [Coasts & Ocean Collective](https://coastalhub.science/data)

## Python libraries

In order to establish a connection with the remote server and process the data retrieved, Python libraries will need to be installed.

For this example Notebook, the networking library - 'requests' will be used.


```python
# We install requests which is a python library for executing HTTP requests.
import sys
!{sys.executable} -m pip install requests
```

    Requirement already satisfied: requests in c:\users\user\appdata\local\programs\python\python37\lib\site-packages (2.25.1)
    Requirement already satisfied: certifi>=2017.4.17 in c:\users\user\appdata\local\programs\python\python37\lib\site-packages (from requests) (2020.12.5)
    Requirement already satisfied: chardet<5,>=3.0.2 in c:\users\user\appdata\local\programs\python\python37\lib\site-packages (from requests) (4.0.0)
    Requirement already satisfied: urllib3<1.27,>=1.21.1 in c:\users\user\appdata\local\programs\python\python37\lib\site-packages (from requests) (1.26.3)
    Requirement already satisfied: idna<3,>=2.5 in c:\users\user\appdata\local\programs\python\python37\lib\site-packages (from requests) (2.10)
    

    WARNING: You are using pip version 19.2.3, however version 21.0.1 is available.
    You should consider upgrading via the 'python -m pip install --upgrade pip' command.
    

## Query Server

Before a Python library can be utilised, it must be imported first. We are making specific reference to functionality contained within the 'requests' and 'json' libraries, so they must be imported before use.


```python
import requests
import json
```

Querying a Server is a multi-step process with the first, and most critical being the identification of the Server. We create a variable to hold the fully qualified name of the Server, including communications protocol - "https", domain name - "wave.storm-surge.cloud.edu.au" and identification of service you wish to access - "wave_mysql"


```python
# Specify the remote server URL
url = "https://wave.storm-surge.cloud.edu.au/wave_mysql/"
```

Quering the Server invloves sending a command, 'GET' in our example, together with the identification of the Server as described in the previous step. 'GET' signals that we wish to retrieve (return) records from the Server. The records returned from the Server must be stored in memory so we create a variable "wave_data" to hold this information.


```python
# Query Server
wave_data = requests.request("GET", url)
```

## Extract data

Once the data is stored in a variable, it must be converted into a format suitable for subsequent manipulation. The data will be extracted and stored in the JSON format. As before, we create a variable to hold the converted data.


```python
# Extract data in JSON ('Javascript Object Notation') format
data_points = json.loads(wave_data.text)
```

Checking the number of rows of data retrieved is a quick way to verify that the process worked as we expected. Using the 'print' command, and the 'len()' - length function, count the number of rows retrieved and print the result.


```python
# Check number of rows retrieved
print("Number of rows retrieved: ", str(len(data_points['results'])))
```

    Number of rows retrieved:  14834
    

## Process raw data

Now that we have the data from the Server, and have it in a format (JSON) which is easier to manipulate, displaying the first record is a good way to satisfy ourselves that the data appears to be correct. The following command uses the 'json.dumps', and 'print' functions to display this record. Please note - '0' is the first element within a 'list'.


```python
print(json.dumps(data_points['results'][0], indent=4))
```

    {
        "x": 4,
        "y": 6,
        "lat": -42.618687,
        "lng": 170.94698,
        "island": "NI",
        "m.x": 4,
        "m.y": 6,
        "t": 0,
        "Hsig": 1.5660860538482666,
        "datetime": "1993-01-01 00:00:00"
    }
    

In a preceeding step you verified the number of rows retrieved, then displayed a single record. If you want to display more rows, we can access each row individually, and print the contents of that row. This task is achieved using a structure which can visit all rows, or a subset of the rows retrieved. In the following example we will print the contents of the first three rows retrieved from the Server.


```python
# Iterate over first two rows
for row in data_points['results'][0:2]:
    print(json.dumps(row, indent=4))
    
```

    {
        "x": 4,
        "y": 6,
        "lat": -42.618687,
        "lng": 170.94698,
        "island": "NI",
        "m.x": 4,
        "m.y": 6,
        "t": 0,
        "Hsig": 1.5660860538482666,
        "datetime": "1993-01-01 00:00:00"
    }
    {
        "x": 4,
        "y": 34,
        "lat": -42.618687,
        "lng": 173.56314,
        "island": "NI",
        "m.x": 4,
        "m.y": 34,
        "t": 0,
        "Hsig": 1.782180666923523,
        "datetime": "1993-01-01 00:00:00"
    }
    

Once you have identified a 'row' of interest, individual elements within the row can be extracted. This task is achieved through referencing the row, and desired 'named element' within the row.


```python
# Access Individual elements
print(row['island'], row['datetime'], row['m.y'])
```

    NI 1993-01-01 00:00:00 34
    
