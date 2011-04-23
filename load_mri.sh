#!/usr/bin/env tcsh

#Script to run recon jobs with Freesurfer.
#ethan.soutar.rau@gmail.com

#TODO a lot of the bother with the arguments occurs because our data isn't
#FS expects it. Maybe move data into subfolder of subject folder before
#processing. Folder shuffling is so confusing because of the (imho)
#overreliance on setting environmental variables.

if ($#argv != 3) then
  echo "Usage: $0 source_directory output_directory data_label"
  echo "runs MRI data in source_directory through Freesurfer recon"
  echo "and creates a subject with labeled data_label in output_directory"
  goto error
endif

set source_directory=$1
set destination_directory=$2
set label=$3 

echo "cd $destination_directory"
echo "mksubjdirs $label"

echo "setenv SUBJECTS_DIR $destination_directory"
echo "setenv SUBJECT $label"
echo "convert the one from the folder with ~170 items"

# for each directory in the source
# look for one with a file count between 150 and 200
# run the convert on it and save it as:
# destination/mri/orig/001.mgz

cd $source_directory

#can assume there is one file in this folder for the moment
cd *

#several folders with different types of data, can recognize the
#one we wants based on the number of DICOM images

foreach directory (*)
  set file_count = `ls -1 $directory | wc -l`
  if ($file_count >= 150 && $file_count <= 200) then
    set one_file = $directory/*.1
    echo "mri_convert $one_file  $destination_directory$label/mri/orig/001.mgz"
  endif
end

if ( -e $destination_directory$label/mri/orig/001.mgz) then
  echo "recon-all -subjid $label -all"
  goto done
else
  goto error
endif

done:
  exit 0
error:
  exit 1
