resource "shoreline_notebook" "error_opening_mysql_in_xampp" {
  name       = "error_opening_mysql_in_xampp"
  data       = file("${path.module}/data/error_opening_mysql_in_xampp.json")
  depends_on = [shoreline_action.invoke_check_mysql_port,shoreline_action.invoke_xampp_setup]
}

resource "shoreline_file" "check_mysql_port" {
  name             = "check_mysql_port"
  input_file       = "${path.module}/data/check_mysql_port.sh"
  md5              = filemd5("${path.module}/data/check_mysql_port.sh")
  description      = "Check if there are any other services running on the same port as MySQL, and stop those services if necessary."
  destination_path = "/tmp/check_mysql_port.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "xampp_setup" {
  name             = "xampp_setup"
  input_file       = "${path.module}/data/xampp_setup.sh"
  md5              = filemd5("${path.module}/data/xampp_setup.sh")
  description      = "If the issue persists, try repairing or reinstalling XAMPP to ensure that all necessary components are properly installed and configured."
  destination_path = "/tmp/xampp_setup.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_check_mysql_port" {
  name        = "invoke_check_mysql_port"
  description = "Check if there are any other services running on the same port as MySQL, and stop those services if necessary."
  command     = "`chmod +x /tmp/check_mysql_port.sh && /tmp/check_mysql_port.sh`"
  params      = ["MYSQL_PORT_NUMBER"]
  file_deps   = ["check_mysql_port"]
  enabled     = true
  depends_on  = [shoreline_file.check_mysql_port]
}

resource "shoreline_action" "invoke_xampp_setup" {
  name        = "invoke_xampp_setup"
  description = "If the issue persists, try repairing or reinstalling XAMPP to ensure that all necessary components are properly installed and configured."
  command     = "`chmod +x /tmp/xampp_setup.sh && /tmp/xampp_setup.sh`"
  params      = ["XAMPP_VERSION"]
  file_deps   = ["xampp_setup"]
  enabled     = true
  depends_on  = [shoreline_file.xampp_setup]
}

