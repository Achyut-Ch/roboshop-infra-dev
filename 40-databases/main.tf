resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  # in which subnet we want to launch this instance, we can use subnet id 
  subnet_id = local.database_subnet_id
  vpc_security_group_ids = [local.mongodb_sg_id]
  
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-mongodb"
    },
    local.common_tags
  )
} 

resource "terraform_data" "mongodb" {
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
      "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}"
    ]
  }
}




resource "aws_instance" "redis" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  # in which subnet we want to launch this instance, we can use subnet id 
  subnet_id = local.database_subnet_id
  vpc_security_group_ids = [local.redis_sg_id]
  
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-redis"
    },
    local.common_tags
  )
} 

resource "terraform_data" "bootstrap_redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.redis.private_ip
  }
  
  provisioner "file" {
    source = "bootstrap.sh" # local file which we want to copy on remote machine
    destination = "/tmp/bootstrap.sh" # destination path on remote machine
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo /tmp/bootstrap.sh redis ${var.environment}"
    ]
  }
}


resource "aws_instance" "mysql" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  # in which subnet we want to launch this instance, we can use subnet id 
  subnet_id = local.database_subnet_id
  vpc_security_group_ids = [local.mysql_sg_id]
  iam_instance_profile = aws_iam_instance_profile.mysql.name
  
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-mysql"
    },
    local.common_tags
  )
} 

resource "terraform_data" "mysql" {
  triggers_replace = [
    aws_instance.mysql.id
  ]

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.mysql.private_ip
  }
  
  provisioner "file" {
    source = "bootstrap.sh" # local file which we want to copy on remote machine
    destination = "/tmp/bootstrap.sh" # destination path on remote machine
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo /tmp/bootstrap.sh mysql ${var.environment}"
    ]
  }
}










