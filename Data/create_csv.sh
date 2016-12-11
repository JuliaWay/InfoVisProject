#!/bin/bash

dataPath="/home/eva/Documents/InfoVis/data.robbi5.com/beezero-muc"
csvPath="/home/eva/Documents/InfoVis/csv"
resultFilePath="/home/eva/Documents/InfoVis/InfoVisProject/Data/cars.csv"

cd /home/eva/Documents/InfoVis
rm data.robbi5.com/beezero-muc/index.html

# get files from page
wget --recursive --no-parent --no-clobber https://data.robbi5.com/beezero-muc/

# prepare jason files
grep -lr '{"success":true,"response":{"availableVehicles":\[{' $dataPath/ | xargs sed -i 's/{"success":true,"response":{"availableVehicles":\[{/{/g'
grep -lr '}\],"zones"' $dataPath/ | xargs sed -i 's/}\],"zones".*/}/'
grep -lr '},{' $dataPath/ | xargs sed -i 's/},{/}\n{/g'

# prepare cars.csv
rm $resultFilePath
echo date,day,month,hour,minute,weekday,auto_id,name,longitude,latitude,fuelLevel,lastAddress > $resultFilePath

# insert timestamp, convert json to csv
for file in $dataPath/*.json
do
	#echo $file
	filename=$(basename "$file")
	timestamp="${filename%.*}"
	if [ ! -f "$csvPath/$timestamp.json.csv" ] 
	then
		echo $filename 
		# insert date
		date=$( date -d $timestamp +"%F")
		day=$( date -d $timestamp +"%d")
		month=$( date -d $timestamp +"%m")
		hour=$( date -d $timestamp +"%H")
		minute=$( date -d $timestamp +"%M")
		weekday=$( date -d $timestamp +"%u")
		#dateColumns= "{\"date\":\"$date\",\"day\":\"$day\",\"month\":\"$month\",\"hour\":\"$hour\",\"minute\":\"$minute\",\"weekday\":\"$weekday\",\"id\""
		grep -rl '{"id"' $file | xargs sed -i "s/{\"id\"/{\"date\":\"$date\",\"day\":\"$day\",\"month\":\"$month\",\"hour\":\"$hour\",\"minute\":\"$minute\",\"weekday\":\"$weekday\",\"id\"/g"
	
		# convert
		/home/eva/go/bin/json2csv -k date,day,month,hour,minute,weekday,id,name,coordinate.longitude,coordinate.latitude,fuelLevel,lastAddress -i $file -o $file.csv #-p
	fi
done

# move csv files to different folder
mv $dataPath/*.csv $csvPath

# each file into one
cat $csvPath/*.csv >> $resultFilePath

# in Datenbank importieren, tabelle muss wie filename.csv heißen
#mysqlimport --ignore-lines=1 --fields-terminated-by=, --verbose --local -u InfoVis -p InfoVis /home/eva/Documents/InfoVis/cars_data.csv
