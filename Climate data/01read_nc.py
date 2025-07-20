from netCDF4 import Dataset
import csv
from datetime import datetime, timedelta

# Open the NetCDF file
nc = Dataset('air.mon.mean.nc')
print("Available variables:", nc.variables.keys())

# Extract variables
time = nc.variables['time'][:]  # Time in hours since 1800-01-01
lat = nc.variables['lat'][:]    # Latitude array
lon = nc.variables['lon'][:]    # Longitude array
air_temp = nc.variables['air'][:]  # Air temperature data

def convert_time(nc_time):
    """
    Convert NetCDF time (hours since 1800-01-01) to YYYY-MM format
    """
    base_date = datetime(1800, 1, 1)
    delta = timedelta(hours=float(nc_time))
    result_date = base_date + delta
    return f"{result_date.year}-{result_date.month:02d}"

# Open output CSV file
with open('air_temperature_monthly.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(['time', 'latitude', 'longitude', 'air_temperature'])
    
    # Iterate through all data points
    for t_idx in range(len(time)):
        current_time = convert_time(time[t_idx])
        
        for lat_idx in range(len(lat)):
            current_lat = lat[lat_idx]
            
            for lon_idx in range(len(lon)):
                current_lon = lon[lon_idx]
                
                # Get temperature value
                temp_value = air_temp[t_idx, lat_idx, lon_idx]
                
                # Skip missing values (assuming they're masked or NaN)
                if not isinstance(temp_value, (float, int)):
                    continue
                
                # Write valid data to CSV
                writer.writerow([
                    current_time,
                    current_lat,
                    current_lon if current_lon < 180 else current_lon - 360,  # Convert to -180 to 180 range
                    temp_value
                ])

print("Data extraction complete.")