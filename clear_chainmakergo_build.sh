CURRENT_PATH=$(pwd)
# echo $CURRENT_PATH
BACKUP_PATH='../chainmaker-go/build/backup'
# echo $RELEASE_PATH
cd $BACKUP_PATH
#CURRENT_PATH=$(pwd)
#version="V1.0.0"
#echo $CURRENT_PATH
echo $(pwd)
echo 'before clear build_backup:'
du -sh
rm -rf *
echo 'after clear build_backup:'
du -sh
