variable "access_key"{}
variable "secret_key"{}
variable "key_name"{}
variable "key_path"{}
 
variable "aws_region"{
description="Region to Launch Server's"
default="us-east-1"
}
 
variable "aws_amis"{
default = {
us-east-1="ami-9eaa1cf6"
   }
}
