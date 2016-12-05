#!/bin/bash

dataPath="/home/eva/Documents/InfoVisProject/Data/data.robbi5.com/beezero-muc"
csvPath="/home/eva/Documents/InfoVisProject/Data/csv"
resultFilePath="/home/eva/Documents/InfoVisProject/Data/cars.csv"

cd /home/eva/Documents/InfoVisProject/Data
rm data.robbi5.com/beezero-muc/index.html

# get files from page
wget --recursive --no-parent --no-clobber https://data.robbi5.com/beezero-muc/

# prepare jason files
grep -lr '{"success":true,"response":{"availableVehicles":\[{' $dataPath/ | xargs sed -i 's/{"success":true,"response":{"availableVehicles":\[{/{/g'
grep -lr '}\],"zones"' $dataPath/ | xargs sed -i 's/}\],"zones".*/}/'
grep -lr '},{' $dataPath/ | xargs sed -i 's/},{/}\n{/g'

# prepare cars.csv
rm $resultFilePath
echo timestamp,id,name,longitude,latitude,fuelLevel,lastAddress > $resultFilePath

# insert timestamp, convert json to csv
for file in $dataPath/*.json
do
	#echo $file
	filename=$(basename "$file")
	timestamp="${filename%.*}"
	if [ ! -f "$csvPath/$timestamp.json.csv" ] 
	then
		echo $filename 
		# insert timestamp
		grep -rl '{"id"' $file | xargs sed -i "s/{\"id\"/{\"timestamp\":\"$timestamp\",\"id\"/g"
	
		# convert
		/home/eva/go/bin/json2csv -k timestamp,id,name,coordinate.longitude,coordinate.latitude,fuelLevel,lastAddress -i $file -o $file.csv #-p
	fi
done

# move csv files to different folder
mv $dataPath/*.csv $csvPath

# each file into one
cat $csvPath/*.csv >> $resultFilePath
