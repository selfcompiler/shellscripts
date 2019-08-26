echo "This is varys,he has his little birds"

# Idempotency size in every 5 minutes in MB 
# 
#
#
load_average=`uptime|cut -d"," -f 4|cut -d":" -f 2|tr -d "[:blank:]"`
total_ram=`free -mh|grep "Mem"|cut -d":" -f 2|cut -d"G" -f 1|tr -d "[:blank:]"`
used_ram=`free -mh|grep "Mem"|cut -d":" -f 2|cut -d"G" -f 2|tr -d "[:blank:]"`
free_ram=`free -mh|grep "Mem"|cut -d":" -f 2|cut -d"G" -f 3|tr -d "[:blank:]"`

echo $load_average
ctime=`date +%s`
host=`hostname`

team='maas'

echo "`date +%s` varys.mpca.load_average $load_average host_name=mpca_master" | /usr/bin/cosmos

echo "`date +%s` varys.mpca.total_ram $total_ram host_name=mpca_master" | /usr/bin/cosmos
echo "`date +%s` varys.mpca.used_ram $used_ram host_name=mpca_master" | /usr/bin/cosmos
echo "`date +%s` varys.mpca.used_ram $used_ram host_name=mpca_master" | /usr/bin/cosmos

declare -a  disk_mounted_on=( "/" "/var/lib/mysql" "/var/log/mysql" "/var/tmp/mysql" )

for dir in "${disk_mounted_on[@]}"
do
    echo $dir
    total_size_in_gb=`df -kh $dir|grep $dir|cut -d" " -f 3|cut -d"G" -f 1|tr -d "[:blank:]"`
    used_size_in_gb=`df -kh $dir|grep $dir|cut -d" " -f 5|cut -d"G" -f 1|tr -d "[:blank:]"`
    free_size_in_gb=`df -kh $dir|grep $dir|cut -d" " -f 7|cut -d"G" -f 1|tr -d "[:blank:]"`
    used_percentage=`df -kh /var/lib/mysql|grep $dir|cut -d" " -f 9|cut -d"%" -f 1|tr -d "[:blank:]"`
    
    echo "`date +%s` varys.$dir.total_size_in_gb $total_size_in_gb host_name=$host" | /usr/bin/cosmos
    echo "`date +%s` varys.$dir.used_size_in_gb $used_size_in_gb host_name=$host" | /usr/bin/cosmos
    echo "`date +%s` varys.$dir.free_size_in_gb $free_size_in_gb host_name=$host" | /usr/bin/cosmos
    echo "`date +%s` varys.$dir.used_percentage $used_percentage host_name=$host" | /usr/bin/cosmos
    
done


