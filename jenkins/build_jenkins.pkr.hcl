build {
  name = "jenkins-ami"
  sources = [
    "source.amazon-ebs.jenkins_ubuntu"
  ]

  provisioner "shell" {
    script = "scripts/base_setup.sh"
  }

  provisioner "shell" {
    script = "scripts/install_jenkins.sh"
  }

  provisioner "shell" {
    script = "scripts/install_ansible.sh"
  }

  provisioner "shell" {
    script = "scripts/install_terraform.sh"
  }

  provisioner "shell" {
    script = "scripts/install_terragrunt.sh"
  }

  provisioner "shell" {
    script = "scripts/install_aws.sh"
  }
}
