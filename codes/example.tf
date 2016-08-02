provider "aws" {
  access_key = "AKIAIXMZQV4SKNXJQBHQ"
  secret_key = "uCQtAOIcFzPYbSAe8g54775CBqewugjlz569F+PL"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0d729a60"
  instance_type = "t2.micro"
}

resource "aws_eip" "ip" {
    instance = "${aws_instance.example.id}"
    depends_on = ["aws_instance.example"]
}

resource "aws_instance" "another" {
  ami           = "ami-13be557e"
  instance_type = "t2.micro"
}
