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

echo "setenv SUBJECTS_DIR /home/mxhuang/subjects"
echo "setenv SUBJECT $label"
echo "convert the one from the folder with ~170 items"

echo "stat $label/mri/orig/001.mgz"

echo "recon-all -subjid $label -all"


done:
exit 0
error:
exit 1
