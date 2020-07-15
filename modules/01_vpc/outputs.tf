output "name" {
  value = ibm_is_vpc.default_rt_vpc.name
}

output "id" {
  value = ibm_is_vpc.default_rt_vpc.id
}


output "resource_group_name" {
  value = var.resource_group_name
}

output "zones" {
  value = data.ibm_is_zones.region_zones.zones
}

output "zone1" {
  value = element(data.ibm_is_zones.region_zones.zones, 0)
}

output "zone2" {
  value = element(data.ibm_is_zones.region_zones.zones, 0)
}

output "zone3" {
  value = element(data.ibm_is_zones.region_zones.zones, 0)
}