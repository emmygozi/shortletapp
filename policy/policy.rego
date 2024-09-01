package terraform



namespace_defined {
    input.resource.type == "kubernetes_namespace"
}


valid_replicas {
    input.resource.type == "kubernetes_deployment"
    input.resource.config.spec.replicas >= 1
}

# Check if the firewall rule exists
firewall_rule_exists {
    input.resource.type == "google_compute_firewall"
}

# Ensure firewall rules have a name
firewall_rule_has_name {
    input.resource.type == "google_compute_firewall"
    input.resource.config.name != ""
}

# Ensure the firewall rule allows traffic from specified sources
firewall_rule_allows_traffic {
    input.resource.type == "google_compute_firewall"
    input.resource.config.allowed != []
}

# Check if a VPC exists
vpc_exists {
    input.resource.type == "google_compute_network"
}

# Ensure VPC has a name
vpc_has_name {
    input.resource.type == "google_compute_network"
    input.resource.config.name != ""
}

# Ensure VPC is not auto-created (optional based on your policy)
vpc_auto_create_disabled {
    input.resource.type == "google_compute_network"
    input.resource.config.auto_create_subnetworks == false
}

# Check if a subnet exists
subnet_exists {
    input.resource.type == "google_compute_subnetwork"
}

# Ensure subnet has a name
subnet_has_name {
    input.resource.type == "google_compute_subnetwork"
    input.resource.config.name != ""
}

# Ensure subnet has a valid IP range
subnet_ip_range_valid {
    input.resource.type == "google_compute_subnetwork"
    input.resource.config.ip_cidr_range != ""
}

# Ensure subnet is correctly associated with a VPC
subnet_association_valid {
    input.resource.type == "google_compute_subnetwork"
    input.resource.config.network != ""
}



allow {
    namespace_defined
    valid_replicas
    firewall_rule_exists
    firewall_rule_has_name
    firewall_rule_allows_traffic
    vpc_exists
    vpc_has_name
    vpc_auto_create_disabled
    subnet_exists
    subnet_has_name
    subnet_ip_range_valid
    subnet_association_valid
}
