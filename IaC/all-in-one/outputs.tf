output "jenkins" {
  description = "public IP address of jenkins"
  value       = aws_instance.jenkins.public_ip
}


output "kube_control" {
  description = "public IP address of kube_control"
  value       = aws_instance.kube_control.public_ip
}

output "kube_worker_1" {
  description = "public IP address of kube_worker_1"
  value       = aws_instance.kube_worker_1.public_ip
}

output "kube_worker_2" {
  description = "public IP address of kube_worker_2"
  value       = aws_instance.kube_worker_2.public_ip
}