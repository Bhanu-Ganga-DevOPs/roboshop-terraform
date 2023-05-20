data "aws_ami" "centos" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]

}
data "aws_security_group" "allow-all-security-group" {
  name = "allow-all"
}

variable "instance_type" {
  default = "t3.small"
}


variable "components" {
  # default = ["frontend","user","catalogue","cart","shipping","payment","mongodb","mysql","redis","rabbitmq","dispatch"]
  default = {
    "frontend" = {
      name          = "frontend"
      instance_type = "t3.small"
    },
    "user" = {
      name          = "user"
      instance_type = "t3.micro"
    },
    "catalogue" = {
      name          = "catalogue"
      instance_type = "t3.micro"
    },
    "cart" = {
      name          = "cart"
      instance_type = "t3.micro"
    },
    "shipping" = {
      name          = "shipping"
      instance_type = "t3.medium"
    },
    "payment" = {
      name          = "payment"
      instance_type = "t3.small"
    },
    "mongodb" = {
      name          = "mongodb"
      instance_type = "t3.small"
    },
    "mysql" = {
      name          = "mysql"
      instance_type = "t3.small"
    },
    "redis" = {
      name          = "redis"
      instance_type = "t3.small"
    },
    "rabbitmq" = {
      name          = "rabbitmq"
      instance_type = "t3.small"
    },
    "dispatch" = {
      name          = "dispatch"
      instance_type = "t3.small"
    }
  }
}



resource "aws_instance" "instance" {

  ################## resource creation using Count #################
#  count = length(var.components)
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
#
#  tags = {
#    Name = var.components[count.index]
#  }
  ################## END of resource creation using Count #################

  for_each               = var.components
  ami                    = data.aws_ami.centos.image_id
  instance_type          = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]

  tags = {
    Name = each.value["name"]
  }
}


resource "aws_route53_record" "dns-record" {
  for_each               = var.components
  zone_id                = "Z02296781GEG0AJVP8QEV"
  name                   = "${each.value["name"]}-dev.gangabhavanikatraparthi.online"
  type                   = "A"
  ttl                    = 30
  records                = [aws_instance.instance[each.value["name"]].private_ip]
}





################## Manual creation of resource and Route53 records creation using Count #################

#resource "aws_instance" "user" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
#
#  tags = {
#    Name = "user"
#  }
#}
#
#resource "aws_instance" "catalogue" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
#
#  tags = {
#    Name = "catalogue"
#  }
#}
#
#resource "aws_instance" "cart" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
#
#  tags = {
#    Name = "cart"
#  }
#}
#
#resource "aws_instance" "shipping" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
#
#  tags = {
#    Name = "shipping"
#  }
#}
#
#resource "aws_instance" "payment" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
#
#  tags = {
#    Name = "payment"
#  }
#}
#
#resource "aws_instance" "mongodb" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
#
#  tags = {
#    Name = "mongodb"
#  }
#}
#
#resource "aws_instance" "mysql" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
#
#  tags = {
#    Name = "mysql"
#  }
#}
#
#resource "aws_instance" "redis" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
#
#  tags = {
#    Name = "redis"
#  }
#}
#
#resource "aws_instance" "rabbitmq" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
#
#  tags = {
#    Name = "rabbitmq"
#  }
#}
#
#resource "aws_instance" "dispatch" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
#
#  tags = {
#    Name = "dispatch"
#  }
#}


#
#resource "aws_route53_record" "user" {
#  zone_id = "Z02296781GEG0AJVP8QEV"
#  name    = "user-dev.gangabhavanikatraparthi.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.user.private_ip]
#}
#
#resource "aws_route53_record" "catalogue" {
#  zone_id = "Z02296781GEG0AJVP8QEV"
#  name    = "catalogue-dev.gangabhavanikatraparthi.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.catalogue.private_ip]
#}
#
#resource "aws_route53_record" "cart" {
#  zone_id = "Z02296781GEG0AJVP8QEV"
#  name    = "cart-dev.gangabhavanikatraparthi.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.cart.private_ip]
#}
#
#resource "aws_route53_record" "shipping" {
#  zone_id = "Z02296781GEG0AJVP8QEV"
#  name    = "shipping-dev.gangabhavanikatraparthi.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.shipping.private_ip]
#}
#
#resource "aws_route53_record" "payment" {
#  zone_id = "Z02296781GEG0AJVP8QEV"
#  name    = "payment-dev.gangabhavanikatraparthi.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.payment.private_ip]
#}
#
#resource "aws_route53_record" "mongodb" {
#  zone_id = "Z02296781GEG0AJVP8QEV"
#  name    = "mongodb-dev.gangabhavanikatraparthi.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.mongodb.private_ip]
#}
#
#resource "aws_route53_record" "mysql" {
#  zone_id = "Z02296781GEG0AJVP8QEV"
#  name    = "mysql-dev.gangabhavanikatraparthi.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.mysql.private_ip]
#}
#
#resource "aws_route53_record" "redis" {
#  zone_id = "Z02296781GEG0AJVP8QEV"
#  name    = "redis-dev.gangabhavanikatraparthi.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.redis.private_ip]
#}
#
#resource "aws_route53_record" "rabbitmq" {
#  zone_id = "Z02296781GEG0AJVP8QEV"
#  name    = "rabbitmq-dev.gangabhavanikatraparthi.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.rabbitmq.private_ip]
#}
#
#resource "aws_route53_record" "dispatch" {
#  zone_id = "Z02296781GEG0AJVP8QEV"
#  name    = "dispatch-dev.gangabhavanikatraparthi.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.dispatch.private_ip]
#}


################## End of Manual creation of resource and Route53 records creation using Count #################