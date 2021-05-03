# serverless-demo
Demonstration app using the serverless framework

This application will take a files from one s3 bucket, parse the file name, and put it into a different s3 bucket every time a object is uploaded to the original s3 bucket.

For the purposes of this demo, we are assuming that the buckets and iam roles were defined by a different user.

## Setting up
1. Install serverless `npm -g install serverless`
2. cd into your project folder
3. create a new serverless project `sls create --template aws-python3`
4. Install the python requirements plugin `sls plugin install -n serverless-python-requirements`
## Editing the project   
1. open serverless.yml
2. define your deploy stages and regions
3. Add the managed IAM roles
4.  