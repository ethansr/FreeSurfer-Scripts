#!/usr/bin/env tcsh

if ($#argv != 2) then
  echo "Usage: $0 source_directory data_label"
  echo "runs MRI data in source_directory through Freesurfer recon"
  echo "and creates a subject with labeled data_label"
  goto error
endif

set source_directory=`dirname $1`
set destination_directory=$2
set label=`basename $1`


echo "cd $destination_directory"
echo "mksubjdirs $label"

echo "setenv SUBJECTS_DIR $destination_directory"
echo "setenv SUBJECT $label"
echo "convert the one from the folder with ~170 items"

# for each directory in the source
# look for one with a file count between 150 and 200
# run the convert on it and save it as:
# destination/mri/orig/001.mgz

cd $1

cd *

foreach path (*.$1)
#count files
set $file_count = `ls -1 $path | wc -l`
if ($file_count >= 150 && $file_count <= 200) then
 set one_file = $path/*.1
 echo "convert $one_file"
endif
end


echo "stat $destination_directory/$label/mri/orig/001.mgz"

echo "recon-all -subjid $label -all"


done:
exit 0
error:
exit 1
