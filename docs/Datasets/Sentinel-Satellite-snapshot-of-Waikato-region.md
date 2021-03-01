# Sentinel Satellite snapshot of Waikato region

??? info 
    #### Data Service Owner
    Google Earth Engine

    #### Data Owner
    European Space Agency

    #### Contact Person Name
    Nick Lim

    #### Contact Person Email
    nick.lim@waikato.ac.nz

    #### License
    N/A

    #### Data Format
    TIFF

    #### Data Standard
    N/A

    #### Volumetrics
    Hyper Spectral Image of selected bounding box

    #### Benchmark
    N/A
	

Spanning the period 2014 through 2020, focusing on the Lake Whangape area within the Waikato region of New Zealand, images captured by the satellites; [Sentinel 1](https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S1_GRD) and [Sentinel 2](https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_S2).
Sentinel 1 captures images from the ‘C-Band’ using VV, HH, W+VH and HH + HV polarisations. Sentinel 2 employs bands B1 through B12. Image storage is accomplished using UINT16 values in the Tiff format. Prior to storage the satellite images are orthorectified.
  
Data collected from these devices is referenced within the report ["Remote sensing of Waikato Wetlands"](https://www.waikatoregion.govt.nz/assets/WRC/WRC-2019/tr201621.pdf)

![Satellite coverage area](../img/SentinelSat.png)

The data can be accessed [here](https://code.earthengine.google.com/?scriptPath=users%2Fnlim%2Fwrc_science%3Awetland_nz_2020_2)
