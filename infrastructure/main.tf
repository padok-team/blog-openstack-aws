data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "deployer" {
  key_name   = "${terraform.workspace}-key"
  public_key = var.ssh_public_key
}

resource "aws_instance" "openstack" {
  count = var.openstack_cluster_size

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  private_ip = cidrhost(aws_subnet.public.cidr_block, count.index + 10)
  key_name   = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [
    aws_security_group.allow_public_ssh.id
  ]
  subnet_id = aws_subnet.public.id
  tags = {
    Name = "${terraform.workspace}-${count.index}"
  }

  depends_on = [aws_internet_gateway.self]
}

resource "aws_security_group" "allow_public_ssh" {
  name        = "${terraform.workspace}-public-ssh"
  vpc_id      = aws_vpc.self.id
  description = "Allows access to SSH Port"

  # Allow SSH from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
