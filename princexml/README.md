# princexml_federalregister-cookbook

Cookbook for installing princexml on FederalRegister.gov

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
    <td><tt>['princexml']['version']</tt></td>
    <td>String</td>
    <td>what version to install</td>
    <td><tt>8.1 rev 5</tt></td>
  </tr>
  <tr>
    <td><tt>['princexml']['package_name']</tt></td>
    <td>String</td>
    <td>package to install - based off of 'version' attribute</td>
    <td><tt>string for ubuntu 12.04 64bit</tt></td>
  </tr>
  <tr>
    <td><tt>['princexml']['download_url']</tt></td>
    <td>String</td>
    <td>url to get package from - based off of 'package_name' attribute</td>
    <td><tt>url for ubuntu 12.04 64bit</tt></td>
  </tr>
  <tr>
    <td><tt>['princexml']['google_fonts']</tt></td>
    <td>Array</td>
    <td>array of strings denoting Google fonts to install</td>
    <td><tt>[]</tt></td>
  </tr>
</table>

## Usage

### princexml_federalregister

Include `princexml_federalregister` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[princexml_federalregister]"
  ]
}
```

## License and Authors

Author:: Critical Juncture, LLC (<info@criticaljuncture.org>)
