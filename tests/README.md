# Run Terraform test

To run tests, you can either specify the `resource_group_name` and `location` variables in the `.tftest.hcl` test file:

```hcl
variables {
  resource_group_name = "<an existing resource group>"
  location = "<location>"
}
```

.. or, specify variables in the command line:

```console
terraform test -var="resource_group_name=<an existing resource group>" -var="location=<location>"
```
