# aws-nuke-dry-run

This template is designed for easy and quick trail of [aws-nuke](https://github.com/rebuy-de/aws-nuke) without any fearing of destruction. 

The stack`readonly-user.yaml` will install a user with full reading permissions and access keys. Also, it's save for use with aws-nuke, it's not designed for being a secure long-term solution.

## Why?
[aws-nuke](https://github.com/rebuy-de/aws-nuke) is a very helpful tool to keep your infrastructure testing account clean. Many other tools provide a demo setup for getting a quick impression. While this is not useful for aws-vault, it can be dry-run on your AWS accounts to get an impression.

This project is intended as an out-of-the-box setup to dry-run aws-nuke with read-only permissions on your account.

## Usage

### Create read-only user

Run following terminal commands to create CloudFormation stack for read-only user and output exported `AccessKey` and `AccessSecret`.
```sh
aws cloudformation create-stack --stack-name aws-nuke-readonly-user --template-body file://./readonly-user.yml --capabilities CAPABILITY_NAMED_IAM

aws cloudformation wait stack-create-complete --stack-name aws-nuke-readonly-user

aws cloudformation describe-stacks --stack-name aws-nuke-readonly-user
```

You will need to export `AccessKey` and `AccessSecret`:

```sh
export AWS_ACCESS_KEY_ID=********
export AWS_SECRET_ACCESS_KEY=********
```

### Set account-id

You can get you AWS account id by running this:
```sh
aws sts get-caller-identity
```

You will need to set your AWS account id in nuke-config:
```yaml
accounts:
  "123456789012": {} 
```

### Dry-run aws-nuke

Be aware, aws-nuke may take quite some time to run.

You can dry-run aws-nuke with this command:
```sh
./dryrun-aws-nuke.sh
```

There maybe a couple of error messages due to resource policies, discontinued AWS services and so on. You can filter output to be deleted resources by running this:
```sh
./dryrun-aws-nuke.sh --force | (head -n 4;grep "would remove")
```

### Clean up

Remove the read-only user:

```sh
aws cloudformation delete-stack --stack-name aws-nuke-readonly-user

aws cloudformation wait stack-delete-complete --stack-name aws-nuke-readonly-user
```
