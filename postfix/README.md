# postfix_federalregister-cookbook

Wrapper cookbook around the postfix cookbook. Adds ability to specify
attributes suchs as servers allowed access and username/passwords for relay
via databags.

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
    <td><tt>['postfix']['credentials_data_bag_name']</tt></td>
    <td>String</td>
    <td>databag that contains your sendgrid credentials - expects a 'sendgrid' item in the bag</td>
    <td><tt>'credentials'</tt></td>
  </tr>
  <tr>
    <td><tt>['postfix']['allowed_server_hostnames']</tt></td>
    <td>Array</td>
    <td>specifies which server hostnames should be looked for in the databag and authorized for relay access</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['postfix']['servers_data_bag_name']</tt></td>
    <td>String</td>
    <td>databag that contains your server ipaddress - expects a ip_addresses item in the bag with hostname keys that match the allowed server hostnames above</td>
    <td><tt>'servers'</tt></td>
  </tr>
</table>

## Usage

### postfix::default

Include `postfix` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[postfix_federalregister]"
  ]
}
```

## License and Authors

Author:: Critical Juncture, LLC (<info@criticaljuncture.org>)
