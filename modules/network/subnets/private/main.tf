resource "aws_subnet" "private_subnet" {
  count      = length(var.cidrs)
  vpc_id     = var.vpc_id
  cidr_block = var.cidrs[count.index]

  tags = {
    Name = "private subnet"
  }
}
