# varnishd_federalregister-cookbook

Wrapper cookbook around the varnishd cookbook for FederalRegister.gov
to create our vcl file based on server information in databags

## Supported Platforms

Ubuntu

## Attributes

No attributes have been added

## Usage

### varnishd_federalregister

Include `varnishd_federalregister` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[varnishd_federalregister]"
  ]
}
```

## License and Authors

Author:: Critical Juncture, LLC (<info@criticaljuncture.org>)
