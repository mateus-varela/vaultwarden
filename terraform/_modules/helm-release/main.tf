resource "helm_release" "this" {
  namespace     = var.namespace
  repository    = var.repository
  name          = var.app["name"]
  chart         = var.app["chart"]
  version       = lookup(var.app, "version", null)
  force_update  = lookup(var.app, "force_update", true)
  wait          = lookup(var.app, "wait", true)
  recreate_pods = lookup(var.app, "recreate_pods", true)
  max_history   = lookup(var.app, "max_history", 0)
  lint          = lookup(var.app, "lint", true)
  values        = var.values
  create_namespace = true


  dynamic "set" {
    for_each = var.set
    content {
      # type  = set.value.type
      name  = set.value.name
      value = set.value.value
    }
  }

  dynamic "set_sensitive" {
    for_each = var.set_sensitive

    content {
      type  = set_sensitive.value.type
      name  = set_sensitive.value.path
      value = set_sensitive.value.value
    }
  }
}