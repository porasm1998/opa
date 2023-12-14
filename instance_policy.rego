package terraform

# Define a set of allowed instance types
allowed_instance_types := {"t2.micro", "t2.small", "t3.micro"}

# Deny rule that triggers if a resource is of a type not in the allowed set
deny[msg] {
    resource := input.resource_changes[_]
    resource.type == "aws_instance"
    instance_type := resource.change.after.instance_type
    not allowed_instance_types[instance_type]
    msg := sprintf("Instance type '%v' is not allowed (resource: %v)", [instance_type, resource.address])
}
