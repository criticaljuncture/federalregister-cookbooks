# apt_federalregister-cookbook

Installs packages needed for the current node (these are usually packages
that are needed for particular gems in repos that are deployed to that server).

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
    <td><tt>['apt']['packages']</tt></td>
    <td>Array of Strings</td>
    <td>packages to include for the current node</td>
    <td><tt>[]</tt></td>
  </tr>
</table>
## Usage

### apt_federalregister::default

Include `apt` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[apt_federalregister]"
  ]
}
```

## License and Authors

Author:: Critical Juncture, LLC (<info@criticaljuncture.org>)
