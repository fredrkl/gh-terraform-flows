# GitHub (GH) terraform actions

GH-Actions flows for applying terraform

## Prerequisites

- Fork this repo
- Create a new _Azure Entra Application_ and with _Federated credentials_ assigned to your repo.
- Create the following GH Actions secrets:
  - `azure_client_id`: The _Application (client) ID_ of the _Azure AD Application_.
  - `azure_tenant_id`: The _Directory (tenant) ID_ of the _Azure AD Application_.
  - `azure_subscription_id`: The _Subscription ID_ of the _Azure Subscription_.
- Be sure to give the _Azure Entra Application_ you created permissions to the _Azure Subscription_ you are going to use.
- Create a storage account and update the main.tf backend configuration with the storage account name and container name.
- Be sure to give the _Azure Entra Application_ you created permissions to the _Storage Account_ you are going to use with the _Storage Blob Data Contributor_ role and _Storage Account Key Operator Service Role_ role.

## Pre-commit hooks for terraform files (optional)

> :exclamation: The pre-commit hooks are only running on staged files.

To set up pre-commit hooks for terraform files, run the following commands:

```bash
brew install pre-commit
pre-commit install
```

If you want to uninstall the pre-commit hooks, run the following command:

```bash
pre-commit uninstall
```

## Using Azure Storage Account for Terraform state

The Terraform state is stored in an Azure Storage Account configured in the ./terraform/main.tf file.

## Running ConfTest locally

To run the ConfTests locally, first install the ConfTest binary. The easiest way to do this is to use brew:

```bash
brew install conftest
```

Please see the [installation instructions](https://www.conftest.dev/install/) for other options.

```bash
conftest test unit-tests/example-terraform-plan.json
```

### Lessons learned

When running the conftest, e.g,

```bash
conftest test --policy somefolder/* unit-tests/example-terraform-plan.json
```

the policy folder need to be all .rego files.
