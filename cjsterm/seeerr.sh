cat ./logs/*.log|grep -v "100%"|grep ETA
find ./logs/ -name "*.log"|xargs grep "id exp4 not open"|awk -F':' '{print $1}'
