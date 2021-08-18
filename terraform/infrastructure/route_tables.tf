#Route table, Public
resource "aws_route_table" "public" {
  depends_on = [
    aws_internet_gateway.default
  ]

  vpc_id = "${aws_vpc.sandbox.id}"

  route{
          cidr_block = "0.0.0.0/0"
          gateway_id = aws_internet_gateway.default.id
      }

  tags = merge (
    var.default_tags,
    {
        Name = "public-rt-${var.task_id}"
    }
  )
}

resource "aws_route_table_association" "public" {
  count = "${length(var.public_subnet_cidrs)}"

  subnet_id      = "${aws_subnet.public[count.index].id}"
  route_table_id = "${aws_route_table.public.id}"
}

#Route table, Private
resource "aws_route_table" "private" {
    count = "${length(var.private_subnet_cidrs)}"

    vpc_id = "${aws_vpc.sandbox.id}"

    route {
            cidr_block = "0.0.0.0/0"
            nat_gateway_id = aws_nat_gateway.nat[count.index].id
        }

    tags = merge(
        var.default_tags,
        {
            Name = "private-rt-${var.task_id}"
        }
    )
}

resource "aws_route_table_association" "private" {
    count = "${length(var.private_subnet_cidrs)}"

    subnet_id = "${aws_subnet.private[count.index].id}"
    route_table_id = "${aws_route_table.private[count.index].id}" 
}