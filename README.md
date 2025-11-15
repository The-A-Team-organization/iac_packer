# AMI Builder — README

#### This project provides a modular structure for building custom Amazon Machine Images (AMI) using HashiCorp Packer.

#### It is designed to automate the creation of optimized and repeatable AMI images based on Ubuntu Minimal 24.04 or any other base image.

#### Each AMI profile contains its own configuration, variables, and provisioning scripts.

---

## Typical AMI Folder Contents

### Folder `responsibility_name_of_castom_ami/`

Contain all the files needed to build an AWS AMI using Packer:

---

1. ### `source_*name*.pkr.hcl`

The source_name.pkr.hcl file defines the AMI source configuration — the base image, AWS parameters, and metadata used by Packer to launch the temporary build instance and create the final AMI.

#### What this configuration does:

- Defines the AMI base image using `source_ami_filter`, selecting the latest Ubuntu Minimal 24.04 image published by Canonical (`owner`: 099720109477(example)) or another
- Sets AWS parameters (`region`, `instance type`, `profile`) from variables
- Configures AMI metadata, including:
- - `ami_name` with a timestamp
- - `ami_description`
- - resource tags
- Specifies the SSH user used during provisioning (`ubuntu`)
- Creates an EBS-backed HVM AMI using the amazon-ebs builder

2. ### `build_*name*.pkr.hcl`

#### What this configuration does:

- The build block defines how the AMI is assembled using the previously declared source
- It sequentially runs all provisioning scripts located in the `scripts/`
- - ```
    # Example
    build {
        name = "jenkins-ami"

        sources = [
        "source.amazon-ebs.jenkins_ubuntu"
        ]

        # Executes provisioning scripts in order
        provisioner "shell" { script = "scripts/base_setup.sh" }
        provisioner "shell" { script = "scripts/install_jenkins.sh" }
        provisioner "shell" { script = "scripts/install_ansible.sh" }
        provisioner "shell" { script = "scripts/install_terraform.sh" }
        provisioner "shell" { script = "scripts/install_terragrunt.sh" }
        provisioner "shell" { script = "scripts/install_aws.sh" }
    }
    ```

- Creates a temporary EC2 instance using the specified source

- Captures the final state of the instance and produces a reusable AMI

3. ### `variables.pkr.hcl`

#### Declares variables, for example:

```
variable "aws_profile" {}
variable "instance_type" {}
variable "region" {}
```

4. ### `versions.pkr.hcl`

#### Contain and declare only basic setting for plugin, for example:

```
packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
```

---

## How to Run and Build image

### 1. Navigate to the directory containing the Packer configuration

```
cd jenkins
```

### 2. Build the AMI

Firstly, initialize the required plugins:

```
packer init .
```

Secondly, validate files structure:

```
packer validate .
```

Then start the AMI build process:

```
packer build .
```
