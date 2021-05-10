# serverless-demo
Demonstration app using the serverless framework

This application will take a files from one s3 bucket, parse the file name, and put it into a different s3 bucket every time a object is uploaded to the original s3 bucket.

For the purposes of this demo, we are assuming that the buckets and iam roles were defined by a different user.

## Serverless.yml
### Setting up
1. Install serverless `npm -g install serverless`
2. cd into your project folder
3. create a new serverless project `sls create --template aws-python3`
### Servicewide setup   
1. open serverless.yml
2. add service name
3. add useDotEnv
### Provider block setup
4. add stage, region, and profile to provider block
5. add tags to provider block
6. add memorysize to provider block
7. add iam to provider block
### Functions block setup
1. name function and point to correct handler
2. add event triggers
3. add environment vars
## handler.py
1. handle event and context objects (print event and context)
2. return response if needed
3. print statements add logging