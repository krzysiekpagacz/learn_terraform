resource "aws_subnet" "private_subnet" {
  count      = length(var.cidrs)
  vpc_id     = var.vpc_id
  cidr_block = var.cidrs[count.index]

  tags = {
    Name = "private-subnet_%{if var.tag_suffix != ""}${var.tag_suffix}%{endif}"
  }
}
