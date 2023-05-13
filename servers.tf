data "aws_ami" "centos" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]
}

output "image_id" {
   value = data.aws_ami.centos.image_id
}

variable "instance_type" {
  default = var.instance_type
}


# Terraform aws_instance creation

resource "aws_instance" "frontend" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "frontend"
  }
}


# Terraform aws_instance creation

resource "aws_instance" "catalogue" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "catalogue"
  }
}


# Terraform aws_instance creation

resource "aws_instance" "user" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "user"
  }
}


# Terraform aws_instance creation

resource "aws_instance" "shipping" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "shipping"
  }
}


# Terraform aws_instance creation

resource "aws_instance" "cart" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "cart"
  }
}


# Terraform aws_instance creation

resource "aws_instance" "payment" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "payment"
  }
}


# Terraform aws_instance creation

resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "mongodb"
  }
}


# Terraform aws_instance creation

resource "aws_instance" "mysql" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "mysql"
  }
}


# Terraform aws_instance creation

resource "aws_instance" "redis" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "redis"
  }
}


# Terraform aws_instance creation

resource "aws_instance" "rabbitmq" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "rabbitmq"
  }
}


# Terraform aws_instance creation

resource "aws_instance" "dispatch" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type

  tags = {
    Name = "dispatch"
  }
}

resource "aws_route53_record" "frontend" {
  zone_id = "Z02296781GEG0AJVP8QEV"
  name    = "frontend-dev.gangabhavanikatraparthi.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.frontend.private_ip]
}

resource "aws_route53_record" "user" {
  zone_id = "Z02296781GEG0AJVP8QEV"
  name    = "user-dev.gangabhavanikatraparthi.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.user.private_ip]
}

resource "aws_route53_record" "catalogue" {
  zone_id = "Z02296781GEG0AJVP8QEV"
  name    = "catalogue-dev.gangabhavanikatraparthi.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.catalogue.private_ip]
}

resource "aws_route53_record" "cart" {
  zone_id = "Z02296781GEG0AJVP8QEV"
  name    = "cart-dev.gangabhavanikatraparthi.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.cart.private_ip]
}

resource "aws_route53_record" "shipping" {
  zone_id = "Z02296781GEG0AJVP8QEV"
  name    = "shipping-dev.gangabhavanikatraparthi.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.shipping.private_ip]
}

resource "aws_route53_record" "payment" {
  zone_id = "Z02296781GEG0AJVP8QEV"
  name    = "payment-dev.gangabhavanikatraparthi.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.payment.private_ip]
}

resource "aws_route53_record" "mongodb" {
  zone_id = "Z02296781GEG0AJVP8QEV"
  name    = "mongodb-dev.gangabhavanikatraparthi.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.mongodb.private_ip]
}

resource "aws_route53_record" "mysql" {
  zone_id = "Z02296781GEG0AJVP8QEV"
  name    = "mysql-dev.gangabhavanikatraparthi.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.mysql.private_ip]
}

resource "aws_route53_record" "redis" {
  zone_id = "Z02296781GEG0AJVP8QEV"
  name    = "redis-dev.gangabhavanikatraparthi.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.redis.private_ip]
}

resource "aws_route53_record" "rabbitmq" {
  zone_id = "Z02296781GEG0AJVP8QEV"
  name    = "rabbitmq-dev.gangabhavanikatraparthi.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.rabbitmq.private_ip]
}

resource "aws_route53_record" "dispatch" {
  zone_id = "Z02296781GEG0AJVP8QEV"
  name    = "dispatch-dev.gangabhavanikatraparthi.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.dispatch.private_ip]
}