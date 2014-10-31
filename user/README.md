# user_federalregister-cookbook

A wrapper cookbook around the community 'user' cookbook. Manages our users
and uploads SSH keys for use in pulling from Github, etc.

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
    <td><tt>['user']['ssh_private_keys']</tt></td>
    <td>Array</td>
    <td>An array of strings. Each string should be the content of the private key with the newlines converted to '\n'.</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

## Usage

* specify the appropriate ssh private key content on your user in your data bag

### user_federalregister::default

* Assumes a 'users' data bag exists

## License and Authors

Author:: Critical Juncture, LLC (<info@criticaljuncture.org>)
