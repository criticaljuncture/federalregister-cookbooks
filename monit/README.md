# monit-cookbook

Wrapper cookbook around the monit-ng cookbook. Utilizes the monit_check resource to configure our checks.

## Supported Platforms

Ubuntu

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt></tt></td>
    <td></td>
    <td></td>
    <td><tt></tt></td>
  </tr>
</table>

## Usage

### monit_federalregister

Include `monit` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[monit_federalregister]"
  ]
}
```

## License and Authors

Author:: Critical Juncture, LLC (<info@criticaljuncture.org>)
