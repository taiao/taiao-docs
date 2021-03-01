# Images of wildlife from cameras

??? info 
    #### Data Service Owner
    Kaggle

    #### Data Owner
    N/A

    #### Contact Person Name
    Varvara Vetrova

    #### Contact Person Email
    varvara.vetrova@gmail.com

    #### License
    N/A

    #### Data Format
    JPG

    #### Data Standard
    N/A

    #### Volumetrics
    images, 441 locations around the globe

    #### Benchmark
    N/A
	

The WCS training set contains 217,959 images from 441 locations, and the WCS test set contains 62,894 images from 111 locations. These 552 locations are spread across the globe.

You may also choose to use supplemental training data from the [iNaturalist 2017](https://github.com/visipedia/inat_comp/blob/master/2017/README.md), [iNaturalist 2018](https://github.com/visipedia/inat_comp/blob/master/2018/README.md) and [iNaturalist 2019](https://github.com/visipedia/inat_comp) competition datasets. As a courtesy, we have curated all the images from these datasets containing classes that might be in the test set and mapped them into the iWildCam categories. Note: these curated images come only from the iNaturalist 2017 and iNaturalist 2018 datasets because there are no common classes between the iNaturalist 2019 dataset and the WCS dataset. However, participants are still free to use the iNaturalist 2019 data.

This year we are providing [Landsat-8](https://www.usgs.gov/land-resources/nli/landsat/landsat-8) multispectral imagery for each camera location as supplementary data. In particular, each site is associated with a series of patches collected between 2013 and 2019. The patches are extracted from a "Tier 1" Landsat product, which consists only of data that meets certain geometric and radiometric quality standards. Consequently, the number of patches per site varies from 39 to 406 (median: 147). Each patch is 200x200x9 pixels, covering an area of 6km^2 at a resolution of 30 meters / pixel across 9 spectral bands. Note that all patches for a given site are registered, but are not centered exactly at the camera location to protect the integrity of the site.

The data can be downloaded from the competition [Kaggle](https://www.kaggle.com/c/iwildcam-2020-fgvc7/data) or [GitHub page](https://github.com/visipedia/iwildcam_comp).

### Camera Trap Animal Detection Model
We are also providing a general animal detection model which competitors are free to use as they see fit.

The model is a TensorFlow Faster-RCNN model with Inception-Resnet-v2 backbone and atrous convolution.

The model and sample code for running the detector over a folder of images can be found [here](https://github.com/microsoft/CameraTraps/blob/master/megadetector.md).

We have run the detector over the three datasets, and provide the top 100 boxes and associated confidences along with the metadata for WCS.

