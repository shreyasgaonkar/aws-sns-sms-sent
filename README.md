# aws-sns-sms-sent

This simple script will run through your default AWS region set by the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html#cli-quick-configuration), and determine the number of success and failure SMS messages sent from your AWS account in the past 30 days.

If the CloudWatch [retention period](https://aws.amazon.com/cloudwatch/faqs/#AWS_resource_and_custom_metrics_monitoring) is set to a higher value than the default 30 days, you can update the STARTTIME and ENDTTIME variable to select the timerange in which you want to scan the messages.

If you are looking for a specific region, you would need to either update the global configuration using ```aws configure``` or pass in the ```--region us-east-1``` flag to the ```aws logs describe-log-groups``` and ```aws logs filter-log-events``` call.

**Disclaimer**: Since this script will crawl through the CloudWatch logs looking for the CloudWatch LogGroup where SNS adds the logs, it doesn't take into account messages with higher [TotalParts](https://docs.aws.amazon.com/sns/latest/dg/sms_stats_usage.html#example_report) . 
