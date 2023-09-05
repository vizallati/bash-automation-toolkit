#!/bin/bash

directory_to_backup=tobedeleted
sleep 1
echo "Directory contains the following files"
sleep 1
ls $directory_to_backup
sleep 1
echo "Uploading files..."
sleep 1
rclone copy $directory_to_backup googledrive:backup/new
exit_code=$?
echo "exit code is $exit_code"
if [ $exit_code -eq 0 ]
then
    echo "Files successfully uploaded"
else
    echo "Files failed to upload"
fi


