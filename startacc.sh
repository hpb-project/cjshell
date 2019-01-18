##########################
##初始化节点
##########################
for id in `seq 10`
do
   echo node$id
   rm -rf node$id/data/ghpb/chaindata
   ./ghpb --datadir node$id/data init hanxiaole.json
done
