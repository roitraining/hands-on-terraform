output "allow_ssh_id" {
  value = aws_security_group.allow-ssh.id
}

output "allow_http_id" {
  value = aws_security_group.allow-http.id
}
