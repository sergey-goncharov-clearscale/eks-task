resource "aws_vpc" "sandbox" {
    cidr_block = "${var.vpc_cidr}"

    tags = merge(
        var.default_tags,
        {
            Name = "VPC-${var.task_id}"
        }
    )
}