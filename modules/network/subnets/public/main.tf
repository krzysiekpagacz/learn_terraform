resource "aws_subnet" "public_subnet" {
  count      = length(var.cidrs)
  vpc_id     = var.vpc_id
  cidr_block = var.cidrs[count.index]

  tags = {
    Name = "public-subnet_%{if var.tag_suffix != ""}${var.tag_suffix}%{endif}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "internet-gateway_%{if var.tag_suffix != ""}${var.tag_suffix}%{endif}"
  }

}

resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "route-table_%{if var.tag_suffix != ""}${var.tag_suffix}%{endif}"
  }
}

resource "aws_route_table_association" "internet_access" {
  count          = length(var.cidrs)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_eip" "eip" {
  count = length(var.cidrs)
  vpc   = true
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.cidrs)
  allocation_id = aws_eip.eip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id
  tags = {
    Name = "Nat-Gateway_%{if var.tag_suffix != ""}${var.tag_suffix}%{endif}"
  }
}

