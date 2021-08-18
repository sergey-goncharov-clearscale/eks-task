resource "aws_internet_gateway" "default" {
    vpc_id = aws_vpc.sandbox.id

    tags = merge(
        var.default_tags,
        {
            Name = "IGW-${var.task_id}"
        }
    )
}