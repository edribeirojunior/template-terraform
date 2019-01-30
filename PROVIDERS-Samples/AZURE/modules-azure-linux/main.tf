data "azurerm_resource_group" "main"{
    name = "${var.prefix}"
}

data "azurerm_subnet" "internal"{
    name = "AZURE_MV"
    virtual_network_name = "${var.prefix}-vnet"
    resource_group_name = "${var.prefix}"
}

resource "azurerm_public_ip" "main" {
  name                         = "acceptance${var.machine_name}PublicIp"
  location                     = "Brazil South"
  resource_group_name          = "${data.azurerm_resource_group.main.name}"
  public_ip_address_allocation = "static"

  tags {
    environment = "${var.tag}"
  }
}

resource "azurerm_network_security_group" "main" {
  name                = "SecurityGroup-${var.machine_name}"
  location            = "Brazil South"
  resource_group_name = "${data.azurerm_resource_group.main.name}"

  security_rule {
    name                       = "Any-To-MV"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "192.168.0.0/20"
    destination_address_prefix = "*"
  }

  tags {
    environment = "${var.tag}"
  }
}

resource "azurerm_network_interface" "main" {
  name                = "${var.machine_name}-nic"
  location            = "${data.azurerm_resource_group.main.location}"
  resource_group_name = "${data.azurerm_resource_group.main.name}"
  network_security_group_id = "${azurerm_network_security_group.main.id}"

  ip_configuration {
    name                          = "labconfiguration"
    subnet_id                     = "${data.azurerm_subnet.internal.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.main.id}"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.machine_name}"
  location              = "${data.azurerm_resource_group.main.location}"
  resource_group_name   = "${data.azurerm_resource_group.main.name}"
  network_interface_ids = ["${azurerm_network_interface.main.id}"]
  vm_size               = "Standard_D4s_v3"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "6.9"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.machine_name}disk1"
    disk_size_gb      = "100"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "${var.machine_name}"
    admin_username = "${var.username}"
    admin_password = "${var.password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags {
    environment = "${var.tag}"
  }
}

output "ip" {
  value = "${azurerm_public_ip.main.ip_address}"
}
