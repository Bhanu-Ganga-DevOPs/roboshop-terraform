resource  "aws_instance" "instance"{
  ami                    = data.aws_ami.centos.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]

  tags = {
    Name = var.component_name
  }
}

resource "null_resource" "provisioner" {

  depends_on = [aws_instance.instance, aws_route53_record.dns-record]
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip
    }

    inline = [
      "echo -------- ${var.component_name} ---------",
      "rm -rf roboshop-shell",
      "git clone https://github.com/Bhanu-Ganga-DevOPs/roboshop-shell",
      "cd roboshop-shell",
      "sudo bash ${var.component_name}.sh  ${lookup(var.password,"password","null")} "
    ]
  }
}

resource "aws_route53_record" "dns-record" {

  zone_id                = "Z02296781GEG0AJVP8QEV"
  name                   = "${var.component_name}-dev.gangabhavanikatraparthi.online"
  type                   = "A"
  ttl                    = 30
  records                = [aws_instance.instance.private_ip]
}