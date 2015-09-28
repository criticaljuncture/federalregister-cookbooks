# html_diff_service cookbook

Installs a basic set of code and packages needed for creating user friendly html diffs.

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
    <td><tt>['html_diff_service']['application_name']</tt></td>
    <td>String</td>
    <td>the name of the application to retrieve from the databag</td>
    <td><tt>html_diff_service</tt></td>
  </tr>
</table>
## Usage

### apt_federalregister::default

Include `apt` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[html_diff_service]"
  ]
}
```

## License and Authors

Author:: Critical Juncture, LLC (<info@criticaljuncture.org>)
