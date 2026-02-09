# -------------------------------------------------------------------
# Dynamic AMI Lookup
# -------------------------------------------------------------------
# Instead of hardcoding an AMI ID (which is region-specific and becomes
# outdated as AWS publishes new images), we use a data source to
# automatically fetch the latest Amazon Linux 2023 AMI for whatever
# region the provider is configured to use.
#
# Filters:
#   - "al2023-ami-*"  matches Amazon Linux 2023 HVM images
#   - "arm64"         ensures we get the correct architecture
#   - owner "amazon"  ensures we only get official AWS images
#   - most_recent     picks the newest matching AMI
#
# This means `terraform plan` will always resolve to a current,
# supported AMI — no manual updates needed when AWS releases patches.
# -------------------------------------------------------------------
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-arm64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "vm" {
  count                  = 3
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t4g.micro"
  vpc_security_group_ids = [aws_security_group.allow-web-traffic.id]

  user_data = file("install_space-invaders.sh")

  tags = {
    Name = "server-${count.index}"
  }
}
