resource "aws_eip" "nat_eip" {
    count = "${length(var.private_subnet_cidrs)}"

    vpc = true
}

resource "aws_nat_gateway" "nat" {
    count = "${length(var.private_subnet_cidrs)}"

    allocation_id = aws_eip.nat_eip[count.index].id
    subnet_id = aws_subnet.public[0].id
}
