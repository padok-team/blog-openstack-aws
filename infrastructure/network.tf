resource "aws_vpc" "self" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "${terraform.workspace}-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.self.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "${var.aws_region}a"

  map_public_ip_on_launch = true

  tags = {
    Name = "${terraform.workspace}-public"
  }
}

resource "aws_internet_gateway" "self" {
  vpc_id = aws_vpc.self.id

  tags = {
    Name = "${terraform.workspace}-igw"
  }
}

# Step 4: Add routes through internet gateway to public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.self.id

  route {
    cidr_block = "0.0.0.0/0" # Internet
    gateway_id = aws_internet_gateway.self.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
