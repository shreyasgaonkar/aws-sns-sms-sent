#!/bin/bash
STARTTIME="$(date -d "May 01 2018" +%s%3N)"
ENDTIME="$(date +%s000)"
TOTALMSG=0
#ENDTTIME="$(date -d "May 01 2018" +%s%3N)"

# Change and uncomment the ENDTIME to the desired end time


FAILURE=$(aws logs describe-log-groups | grep -i "directpublish" | grep -i "loggroup" | awk '{print $2}' | sed -e 's/"//g' | sed 's/,//g' | grep  Failure)
SUCCESS=$(aws logs describe-log-groups | grep -i "directpublish" | grep -i "loggroup" | awk '{print $2}' | sed -e 's/"//g' | sed 's/,//g' | grep  Failure -v)


FAILURE_RESULTS=$(aws logs filter-log-events --log-group-name ${FAILURE} --start-time $STARTTIME --end-time $ENDTIME | jq '.events | length')
SUCCESS_RESULTS=$(aws logs filter-log-events --log-group-name ${SUCCESS} --start-time $STARTTIME --end-time $ENDTIME | jq '.events | length')

echo "Total SMS messages successed: ${SUCCESS_RESULTS} in ${SUCCESS}"
echo "Total SMS messages failed   : ${FAILURE_RESULTS}  in ${FAILURE}"
