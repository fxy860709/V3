backup_path="../chainmaker-go/build/backup/"
cd ${backup_path}
echo 'before clear data:'
du -sh
rm -rf *
echo 'after clear data:'
du -sh
