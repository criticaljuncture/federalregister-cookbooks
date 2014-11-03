# s3cmd_federalregister-cookbook

Wrapper cookbook around the s3cmd cookbook. Adds the ability to pass aws
credentials and to turn on thing like https and gpg

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
    <td><tt>['s3cmd']['credentials_data_bag_name']</tt></td>
    <td>String</td>
    <td>databag that contains your aws credentials - expects a 'aws' item in the bag</td>
    <td><tt>'credentials'</tt></td>
  </tr>
  <tr>
    <td><tt>['s3cmd']['aws_access_key_id']</tt></td>
    <td>String</td>
    <td>AWS Access Key</td>
    <td><tt>''</tt></td>
  </tr>
  <tr>
    <td><tt>['s3cmd']['aws_secret_access_key']</tt></td>
    <td>String</td>
    <td>AWS Secret Key</td>
    <td><tt>''</tt></td>
  </tr>
  <tr>
    <td><tt>['s3cmd']['use_https']</tt></td>
    <td>String</td>
    <td>whether to use https when connecting to S3</td>
    <td><tt>'True'</tt></td>
  </tr>
  <tr>
    <td><tt>['s3cmd']['gpg_passphrase']</tt></td>
    <td>String</td>
    <td>gpg passphrase to use when encrypting/decrypting data stored on S3</td>
    <td><tt>''</tt></td>
  </tr>
</table>

## Usage

### s3cmd_federalregister::default

Include `s3cmd` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[s3cmd_federalregister]"
  ]
}
```

## License and Authors

Author:: Critical Juncture, LLC (<info@criticaljuncture.org>)
