resource "aws_security_group_rule" "bastion_internet" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  #cidr_blocks      = ["0.0.0.0/0"]
  cidr_blocks       = [local.my_ip]
  # which sg we want to add this rule, we can use sg id or sg name, but sg id is more reliable as there can be multiple sg with same name
  security_group_id = local.bastion_sg_id
}

resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # where traffic is coming from
  source_security_group_id = local.bastion_sg_id
  # destination sg id where we want to add this rule
  security_group_id = local.mongodb_sg_id
}

resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  # where traffic is coming from
  source_security_group_id = local.catalogue_sg_id
  # destination sg id where we want to add this rule
  security_group_id = local.mongodb_sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  # where traffic is coming from
  source_security_group_id = local.user_sg_id
  # destination sg id where we want to add this rule
  security_group_id = local.mongodb_sg_id
}

resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # where traffic is coming from
  source_security_group_id = local.user_sg_id
  # destination sg id where we want to add this rule
  security_group_id = local.redis_sg_id
}