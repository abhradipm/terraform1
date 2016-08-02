provider "aws"{
    region="${var.aws_region}"
    access_key="${var.access_key}"
    secret_key="${var.secret_key}"
}
 
resource "aws_security_group" "default"{
    name="terraform-sg"
    description="Created by terraform"
 
    ingress{
        from_port = 22
        to_port = 22
        protocol= "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = "0"
        to_port     = "0"
        protocol    = "-1"
        self        = true
        cidr_blocks = ["0.0.0.0/0"]
    }

 
}
resource "aws_instance" "web"{
 
    connection={
        user="ubuntu"
        key_file="${var.key_path}"
    }
    instance_type="t2.micro"
    ami="${lookup(var.aws_amis, var.aws_region)}"
    key_name = "${var.key_name}"
    security_groups= ["${aws_security_group.default.name}"]
    tags{
        Name="Terraform-EC2-test"
    }
    provisioner "chef" {
	environment = "_default"
        run_list = ["apache::default"]
        node_name = "node1"
        server_url = "http://api.chef.io/organizations/orgname"
        validation_client_name = "orgname-validator"
        validation_key = "${file("../chef-validator.pem")}
        version = "12.4.1"
    }
    provisioner "remote-exec"{
 
        inline=[
	    "ping -c 10 8.8.8.8",
            "sudo apt-get -y update",
            "sudo apt-get -y install nginx",
            "sudo apt-get -y install php5-fpm",
            "sudo service nginx restart"
        ]
     }
}
