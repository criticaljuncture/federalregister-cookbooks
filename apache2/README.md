# apache2_federalregister cookbook

These are basic abstractions, additions, or simply wrappers to the default community cookbooks(things like custom log formats, etc.).

## Dependencies
apache2 community cookbook

## Supported Platforms

Ubuntu 12.04

## Attributes

No additional attributes at this time.

## Usage

### apache2_federalregister::default

Include `apache2_federalregister` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[apache2_federalregister]"
  ]
}
```

## License and Authors

Author:: Critical Juncture, LLC (<info@criticaljuncture.org>)
