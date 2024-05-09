# Module Gotchas in Terraform

Software is all about composition.

Terraform and Infrastructure as Code are no exceptions. We should use modules to create and compose our building blocks,
just as we use functions to compose and create our business logic.

There are two gotchas we need to be aware of when using modules in Terraform:

- File paths
- Inline blocks

## Inline blocks

When we use modules, we should be careful with inline blocks, although they allow you to define some properties in the
resource, it comes with a trade-off.
We lose the flexibility to define and customize the resource properties in the root module.

There are also the possibility of conflicts between the inline blocks and the module properties, which can lead to
unexpected results.

Finally, inline blocks have been deprecated in Terraform maybe for these reasons.

```hcl
module "s3_bucket" {
  source = "../modules/separate-resource"
  name   = "jorgetovar"
}


resource "aws_s3_bucket_versioning" "versioning" {
  bucket = module.s3_bucket.bucket_name
  versioning_configuration {
    status = "Enabled"
  }
}

```

### Complexity

We should organize our modules in a way that we can easily interact with a part of the infrastructure without having to
understand the whole system.
Our job is to remove the accidental complexity and make the system easier to understand. When we use inline blocks, we
are adding complexity to the system (properties and thing that we may not need to know about).

### Abstractions

But we can also leverage abstractions and hide some details that are unnecessary, if all the buckets that we create have
versioning, maybe it makes more sense to move that resource to the module.

## File Paths

By default, Terraform uses the path relative to the current working directory, in our case, the localhost root module.
Therefore, the module should be able to read files from its folder instead of the one where we are currently executing
the commands.

We can leverage the path variables of terraform to read the files that are in the module folder.The path variables are :

- Path.module : The path to the module folder
- Path.root : The path to the root module folder
- Path.cwd : The path to the current working directory

```hcl
templatefile("${path.module}/${element(local.templates, count.index)}"
```