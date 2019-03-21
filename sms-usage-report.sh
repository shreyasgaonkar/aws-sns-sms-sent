#!/bin/bash
aws s3 sync s3://<your-S3-bucket>/SMSUsageReports/us-west-2/2019/XX . && find . –name "*.gz" | xargs gunzip
TOTALSMS=$(find . -type d | cat  / | awk -F ',' '{count[$8]++} END {for (word in count) print word, count[word]}' | grep -v  TotalParts | awk -F " " '{print $2}')
echo "Total SMS sent: ${TOTALSMS}"
