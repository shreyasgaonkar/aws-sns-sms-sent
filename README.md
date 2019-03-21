# aws-sns-sms-sent

### sms-sent.sh

#### Prereq: AWS SNS - [SMS logging](https://docs.aws.amazon.com/sns/latest/dg/sms_stats_cloudwatch.html#sms_stats_cloudwatch_logs) is already enabled in a region.

This simple script will run through your default AWS region set by the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html#cli-quick-configuration), and determine the number of success and failure SMS messages sent from your AWS account in the past 30 days.

If the CloudWatch [retention period](https://aws.amazon.com/cloudwatch/faqs/#AWS_resource_and_custom_metrics_monitoring) is set to a higher value than the default 30 days, you can update the STARTTIME and ENDTTIME variable to select the timerange in which you want to scan the messages.

If you are looking for a specific region, you would need to either update the global configuration using ```aws configure``` or pass in the ```--region us-east-1``` flag to the ```aws logs describe-log-groups``` and ```aws logs filter-log-events``` call.

**Usage**: run ```bash sms-sent.sh``` or, ```chmod +x sms-sent.sh``` followed by ```./sms-sent.sh```


**Disclaimer**: Since this script will crawl through the CloudWatch logs looking for the CloudWatch LogGroup where SNS adds the logs, it doesn't take into account messages with higher [TotalParts](https://docs.aws.amazon.com/sns/latest/dg/sms_stats_usage.html#example_report) - use ```sms-usage-report.sh``` instead . 

### sms-usage-report.sh

#### Prereq: AWS SMS [Usage Report](https://docs.aws.amazon.com/sns/latest/dg/sms_stats_usage.html) is already enabled in a region.

This script will fetch all the folders in a S3 bucket configured with usage report, extract the contents and spit out the total number of messages sent using [TotalParts](https://docs.aws.amazon.com/sns/latest/dg/sms_stats_usage.html#example_report) from the objects residing inside the buckets. This approach is more robust than the above, since this relies on the total part rather than the individual CloudWatch Log Streams - which would be a single entry for a longer message.

**Usage**: run ```bash sms-usage-report.sh``` or, ```chmod +x sms-usage-report.sh``` followed by ```./sms-usage-report.sh```
