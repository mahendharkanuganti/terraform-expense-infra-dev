## creating the key pait for logging into vpn instance.
## this public key was generated in git bash in ~ (home directory)
## cd ~/.ssh; ssh-keygen openvpn

resource "aws_key_pair" "vpn" {
  key_name   = "vpn"

  # you can paste the public key directly like this
  # public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETQWdQTVdDlm6N7SOTiyYAl8og32SyCwehU/5ygi1/d mahen@Darling"

  public_key = file("~/.ssh/openvpn.pub")
   # ~ means windows home directory
}

## creating vpn instance using the opensource module from

module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  key_name = aws_key_pair.vpn.key_name
  name = "${var.project_name}-${var.environment}-vpn"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]

  # convert StringList to list and get first element
  subnet_id              = local.public_subnet_id
  ami = data.aws_ami.ami_info.id

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-vpn"
    }
  )
}