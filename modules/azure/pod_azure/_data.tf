data "azurerm_resource_group" "myPOD" {
  name = var.resource_group_name
}

data "template_file" "script" {
  template = "${file("${path.module}/configs/backendJump.cfg")}"

}

data "template_cloudinit_config" "jumphost_config" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.script.rendered}"
  }
}