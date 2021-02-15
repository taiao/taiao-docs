# Global Topography
![image](/img/ARDTools.png)
<br>
[^1] Image source

Topography measurement covering the entire surface of the globe.

[Data](https://glad.geog.umd.edu/ard/topography-data-download) captured from the satellite includes:
Topography metrics; ARD tile format. Extracted from the NASA Making Earth System Data Records for Use in Research Environments (MEaSUREs) version of the Shuttle Radar Topography Mission (SRTM) global elevation dataset.

Summary reproduced from [website:](https://glad.geog.umd.edu/ard/topography-data-download)  
Topography metrics (elevation, slope, and aspect) are frequently used as additional source data for image classification along with multi-temporal spectral metrics. To facilitate the image classification applications, the GLAD team provides selected topography metrics in the ARD tile format. The source data was extracted from the NASA Making Earth System Data Records for Use in Research Environments (MEaSUREs) version of the Shuttle Radar Topography Mission (SRTM) global elevation dataset. The source product (SRTMGL1v003) has a spatial resolution of 1 arc second (~30 meters) and is freely distributed by NASA LPDAAC. The dataset has global coverage between 60°N to 56°S.

The GLAD team re-projected and subset the SRTM elevation data to the standard ARD tile format. The dem.tif files contain SRTM elevation in meters, data format Int16 (signed). The No Data value is -32768. Two other topography metrics (slope and aspect) were derived from the global DEM dataset using the following procedure: (1) the DEM was resampled into a local UTM map projection with pixel size of 30m; (2) aspect and slope were calculated using GDAL tools; and (3) slope was scaled by multiplying by 500, and aspect by multiplying by 100, and both variables were stored as UInt16 images (slope.tif and aspect.tif).

[^1]: https://glad.geog.umd.edu/sites/default/files/ARDTools.png