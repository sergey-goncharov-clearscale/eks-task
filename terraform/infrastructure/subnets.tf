#Public subnets
resource "aws_subnet" "public" {
  count = "${length(var.public_subnet_cidrs)}"

  vpc_id = "${aws_vpc.sandbox.id}"
  cidr_block = "${var.public_subnet_cidrs[count.index]}"
  availability_zone = "${var.availability_zones[count.index]}"
  map_public_ip_on_launch = true

  tags = merge(
      "${var.default_tags}",
      {
          Name = "subnet-public-${var.subnet_index[count.index]}"
      }
  )
}

#Private subnet
resource "aws_subnet" "private" {
    count = "${length(var.private_subnet_cidrs)}"

    vpc_id = "${aws_vpc.sandbox.id}"
    cidr_block = "${var.private_subnet_cidrs[count.index]}"
    availability_zone = "${var.availability_zones[count.index]}"
    
    tags = merge(
        "${var.default_tags}",
        {
            Name = "subnet-private-${var.subnet_index[count.index]}"
        }
    )
}
