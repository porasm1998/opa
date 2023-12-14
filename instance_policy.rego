package terraform #policy package
 
allowed_instance_types := ["t2.micro", "t2.small", "t3.micro"] #conditions

#policy_rule
deny[msg] {
    some i
    resource := input.resource_changes[i]
    resource.type == "aws_instance"
    not allowed_instance_types[resource.change.after.instance_type]
    msg := sprintf("resource %v uses disallowed instance type %v", [resource.address, resource.change.after.instance_type])
}
