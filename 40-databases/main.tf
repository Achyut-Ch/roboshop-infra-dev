resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  # in which subnet we want to launch this instance, we can use subnet id 
  subnet_id = local.database_subnet_id
  vpc_security_group_ids = [local.mongodb_sg_id]
  
  tags = merge(
    {
        Name = "${var.project}${var.environment}-mongodb"
    },
    local.common_tags
  )
} 

resource "terraform_data" "bootstrap" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.mongodb.private_ip
  }
  
  provisioner "file" {
    source = "bootstrap.sh" # local file which we want to copy on remote machine
    destination = "/tmp/bootstrap.sh" # destination path on remote machine
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo /tmp/bootstrap.sh mongodb"
    ]
  }
}