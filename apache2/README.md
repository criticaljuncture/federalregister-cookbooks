# apache2_federalregister cookbook

These are basic abstractions, additions, or simply wrappers to the default community cookbooks(things like custom log formats, etc.).

## Dependencies
apache2 community cookbook

## Supported Platforms

Ubuntu 12.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['apache2']['htpasswd_dir']</tt></td>
    <td>String</td>
    <td>directory where the password file for http basic passwords resides</td>
    <td><tt>/etc/apache2/passwd</tt></td>
  </tr>
  <tr>
    <td><tt>['apache2']['htpasswd_file']</tt></td>
    <td>String</td>
    <td>path to the password file for http basic passwords resides</td>
    <td><tt>/etc/apache2/passwd/passwords</tt></td>
  </tr>
</table>

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
