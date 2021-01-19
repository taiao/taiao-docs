[Run in Google Colab](https://colab.research.google.com/github/jacobmontiel/taiao-docs/blob/main/docs/Notebooks/TAIAO-UseCase-4.ipynb)
#### GitHub repository
N/A
#### Datasets
Please see the [Datasets page](../Datasets/Coromandel-River-Rain-gauge.md) for further details.
#### Author
N/A
#### License
N/A
#### Technologies
N/A
#### Tags
Observation, time, intensity
<br>
<br>
<br>
We load the required libraries used to train the LSTM 


```python
import tensorflow as tf
import tensorflow.keras as keras
import tensorflow.keras.backend as K
from tensorflow.keras.layers import LSTM
from tensorflow.keras.layers import Dense
from tensorflow.keras.preprocessing.sequence import TimeseriesGenerator
import pandas as pd
import numpy as np
import matplotlib.pyplot as pyplot
```

The flood prediction dataset has been encapsulated in the packages below and can be loaded using the code below


```python
import taiao.dataset.river as data
import taiao.visualization.river as visualiser
import taiao.model.river as models
```


```python
pd.DataFrame(xTrain).tail()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>403249</th>
      <td>1.2220</td>
      <td>0.373</td>
      <td>0.5</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>403250</th>
      <td>1.2230</td>
      <td>0.372</td>
      <td>0.5</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>403251</th>
      <td>1.2220</td>
      <td>0.373</td>
      <td>0.5</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>403252</th>
      <td>1.2225</td>
      <td>0.376</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>403253</th>
      <td>1.2225</td>
      <td>0.376</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
  </tbody>
</table>
</div>



We set the hyper-parameters and load the dataset and create the keras data generator 


```python
forecast=12
lookback=288
xTrain = data.x('train',forecast)
yTrain = data.y('train',forecast)
xTest = data.x('test',forecast)
yTest = data.y('test',forecast)
trainGen=TimeseriesGenerator(xTrain,yTrain,length=lookback,batch_size=3)
testGen=TimeseriesGenerator(xTest,yTest,length=lookback,batch_size=1)

featureCount=xTrain.shape[1]
depth=2
```

Here we define the model and train the output 


```python
model = models.LSTM(depth,featureCount,lookback, optimizer="adam")
history = model.fit(trainGen,validation_data=testGen, epochs=1).history
model.save('3DLookBack_3hr_forecast_rmse')
```

    134315/134322 [============================>.] - ETA: 0s - loss: 0.0027

We now evaluate the model


```python
model.evaluate(testGen)
trainPredict = model.predict(trainGen)
testPredict = model.predict(testGen)
```

    172522/172522 [==============================] - 469s 3ms/step - loss: 9.9911e-04
    

and plot the output for the flood event of interest


```python
pyplot.plot(yTest[lookback:])
pyplot.plot(testPredict)
pyplot.xlim((87800,88500))
pyplot.show(block=False)
```


    
![png](TAIAO-UseCase-4_files/TAIAO-UseCase-4_12_0.png)
    


We do a dump of the csv file comparing the predicted river level to the actual river level


```python
CsvTemp=np.concatenate([yTest[lookback:].reshape(-1,1),testPredict],axis=1)
np.savetxt('3D_Prediction_3hr_rmse.csv',CsvTemp,delimiter=',')
```


```python

```
