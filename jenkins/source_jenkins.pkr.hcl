source "amazon-ebs" "jenkins_ubuntu" {
  ami_description = "Minimal Ubuntu Image with Jenkins Server"
  ami_name        = "jenkins-ubuntu-{{timestamp}}"
  profile         = var.aws_profile
  instance_type   = var.instance_type
  region          = var.region

  source_ami_filter {
    filters = {
      name                = "ubuntu-minimal/images/*ubuntu-noble-24.04-amd64-minimal-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }

    most_recent = true
    owners      = ["099720109477"]
  }

  ssh_username = "ubuntu"

  tags = {
    "Name" = "Jenkins Server"
  }
}
