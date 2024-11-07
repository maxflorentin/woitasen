output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

output "security_group_id" {
  value = aws_security_group.lb_sg.id
}
