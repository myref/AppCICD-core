resource "ansible_group" "apps" {
  inventory_group_name = var.application
  children = ["${var.prov}_${replace(var.region," ","")}_${var.az}"]
  vars = {
    app = "${var.application}"
  }
}
