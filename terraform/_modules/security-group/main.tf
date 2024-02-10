locals {
  this_sg_id = aws_security_group.this[0].id
}

##########################
# Security group
##########################

resource "aws_security_group" "this" {
  count       = var.create ? 1 : 0
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(var.tags, tomap({ Name = var.name }))
}

###################################
# Ingress 
###################################

resource "aws_security_group_rule" "ingress_with_source_security_group_id" {
  count                    = var.create ? var.number_of_ingress_with_source_security_group_id : 0
  security_group_id        = local.this_sg_id
  type                     = "ingress"
  source_security_group_id = var.ingress_with_source_security_group_id[count.index]["source_security_group_id"]
  prefix_list_ids          = var.ingress_prefix_list_ids
  description              = lookup(var.ingress_with_source_security_group_id[count.index], "description", "Ingress Rule")
  from_port                = var.ingress_with_source_security_group_id[count.index]["from_port"]
  to_port                  = var.ingress_with_source_security_group_id[count.index]["to_port"]
  protocol                 = var.ingress_with_source_security_group_id[count.index]["protocol"]
}

resource "aws_security_group_rule" "ingress_with_cidr_blocks" {
  count             = var.create ? var.number_of_ingress_with_cidr_blocks : 0
  security_group_id = local.this_sg_id
  type              = "ingress"
  cidr_blocks       = lookup(var.ingress_with_cidr_blocks[count.index], "cidr_blocks", [])
  prefix_list_ids   = var.ingress_prefix_list_ids
  description       = lookup(var.ingress_with_cidr_blocks[count.index], "description", "Ingress Rule", )
  from_port         = var.ingress_with_cidr_blocks[count.index]["from_port"]
  to_port           = var.ingress_with_cidr_blocks[count.index]["to_port"]
  protocol          = var.ingress_with_cidr_blocks[count.index]["protocol"]
}

#################
# End of ingress
#################

#########################
# Egress
#########################

resource "aws_security_group_rule" "egress_with_source_security_group_id" {
  count                    = var.create ? var.number_of_egress_with_source_security_group_id : 0
  security_group_id        = local.this_sg_id
  type                     = "egress"
  source_security_group_id = var.egress_with_source_security_group_id[count.index]["source_security_group_id"]
  prefix_list_ids          = var.egress_prefix_list_ids
  description              = lookup(var.egress_with_source_security_group_id[count.index], "description", "Egress Rule")
  from_port                = var.egress_with_source_security_group_id[count.index]["from_port"]
  to_port                  = var.egress_with_source_security_group_id[count.index]["to_port"]
  protocol                 = var.egress_with_source_security_group_id[count.index]["protocol"]
}

resource "aws_security_group_rule" "egress_with_cidr_blocks" {
  count             = var.create ? var.number_of_egress_with_cidr_blocks : 0
  security_group_id = local.this_sg_id
  type              = "egress"
  cidr_blocks       = lookup(var.egress_with_cidr_blocks[count.index], "cidr_blocks", [])
  prefix_list_ids   = var.egress_prefix_list_ids
  description       = lookup(var.egress_with_cidr_blocks[count.index], "description", "Egress Rule", )
  from_port         = var.egress_with_cidr_blocks[count.index]["from_port"]
  to_port           = var.egress_with_cidr_blocks[count.index]["to_port"]
  protocol          = var.egress_with_cidr_blocks[count.index]["protocol"]
}

################
# End of egress
################
