
<strong>Data description</strong><br>
The Moana backbone hindcast datasets comes in the form of 4 sources of data stored in 4 subfolders on the thredds server (http://thredds.moanaproject.org:8080/thredds/catalog/moana/ocean/NZB/v1.9/catalog.xml):

* <strong>raw_3D</strong>: This folder contains the raw ROMS outputs (3D and 2D fields). All the fields are laid on their original curvilinear grids. Main variables are:
  * Free-surface height (zeta) in metres
  * Eastward vertically integrated momentum component (ubar_eastward) in metres per second
  * Northward vertically integrated momentum component (vbar_eastward) in metres per second
  * Eastward momentum component (u_eastward) in metres per second
  * Northward momentum component (v_eastward) in metres per second
  * Potential temperature (temp) in degrees Celcius
  * Salinity (salt)
_caturl = 'http://thredds.moanaproject.org:8080/thredds/catalog/moana/ocean/NZB/v1.9/raw_3D/catalog.xml'
_base_dodsurl = 'http://thredds.moanaproject.org:8080/thredds/dodsC/moana/ocean/NZB/v1.9/raw_3D/'

* <strong>monthly_avg</strong>: This folder contains monthly averages of the raw ROMS outputs (3D and 2D fields). Main variables are:

  * Time-averaged free-surface height (zeta) in metres
  * Time-averaged eastward vertically integrated momentum component (ubar_eastward) in metres per second
  * Time-averaged northward vertically integrated momentum component (vbar_eastward) in metres per second
  * Time-averaged eastward momentum component (u_eastward) in metres per second
  * Time-averaged northward momentum component (v_eastward) in metres per second
  * Time-averaged potential temperature (temp) in degrees Celcius
Time-averaged salinity (salt)
_caturl = 'http://thredds.moanaproject.org:8080/thredds/catalog/moana/ocean/NZB/v1.9/monthly_avg/catalog.xml'
_base_dodsurl = 'http://thredds.moanaproject.org:8080/thredds/dodsC/moana/ocean/NZB/v1.9/monthly_avg/'

* <strong>processed_sfc</strong>: This folder contains 2D variables only (surface, depth-averaged, bathymetry) interpolated to a rectilinear longitude/latitude grid. Main variables are:

  * Sea surface height above geoid (ssh) in metres
  * Sea surface temperature (sst) in degrees Celcius
  * Surface Eastward sea water velocity (us) in metres per second
  * Surface Northward sea water velocity (vs) in metres per second
  * Depth-averaged Eastward sea water velocity (um) in metres per second
  * Depth-averaged Northward sea water velocity (vm) in metres per second
Sea floor depth below mean sea level (dep) in metres
_caturl = http://thredds.moanaproject.org:8080/thredds/catalog/moana/ocean/NZB/v1.9/processed_sfc/catalog.xml'
_base_dodsurl = 'http://thredds.moanaproject.org:8080/thredds/dodsC/moana/ocean/NZB/v1.9/processed_sfc/'

* <strong>processed_3D</strong>: This folder contains the 3D fields interpolated on a rectilinear longitude/latitude/level 3D grids. Main variables are:

  * Sea water temperature (temp) in degrees Celcius
  * Sea water absolute salinity (salt) in 1e-3
  * Eastward sea water velocity (u) in metres per second
  * Northward sea water velocity (v) in meters per second
_caturl = 'http://thredds.moanaproject.org:8080/thredds/catalog/moana/ocean/NZB/v1.9/processed_3D/catalog.xml'
_base_dodsurl = 'http://thredds.moanaproject.org:8080/thredds/dodsC/moana/ocean/NZB/v1.9/processed_3D/'


