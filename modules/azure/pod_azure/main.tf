resource "ansible_group" "PoD" {
  inventory_group_name = "${var.prov}_${replace(var.region," ","")}_${replace(var.name," ","")}"
  children = ["services",var.environment]
  vars = {
    pod_name = "${var.prov}_${replace(var.region," ","")}_${var.name}"
  }
}

