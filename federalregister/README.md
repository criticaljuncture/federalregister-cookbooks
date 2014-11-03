# federalregister-cookbook

Collection of recipes that handle application specific needs that aren't encompassed
in more generic community cookbooks.

## Supported Platforms

Ubuntu

## Attributes

### Apt

## Usage

### federalregister::default

Does nothing

### federalregister::log_rotate

Sets up log rotation based on passed configs.

To use:

```json
{
  "run_list": [
    "recipe[apt_federalregister]"
  ]
}
```

Sample config:

```json
{
  "name": "apache2-access",
  "path": "/var/log/apache2/access.log",
  "bucket": "apache2.logs.internal.federalregister.gov",
  "template": "apache2.logrotate.erb",
  "interval": "weekly",
  "keep_for": 4
}
```

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>name</tt></td>
    <td>String</td>
    <td>The name of the logrotate file that is created</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>path</tt></td>
    <td>String</td>
    <td>Where the logfile to be rotated lives</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>bucket</tt></td>
    <td>String</td>
    <td>Name of the bucket on S3 to send the logs to (via s3cmd)</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>template</tt></td>
    <td>String</td>
    <td>The name of the logrotate template to use - currently apache2, nginx, or rails</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>interval</tt></td>
    <td>String</td>
    <td>How often to rotate the files </td>
    <td><tt>'daily'</tt></td>
  </tr>
  <tr>
    <td><tt>keepfor</tt></td>
    <td>Integer</td>
    <td>Number of intervals to keep the rotated files on the server after which they are deleted</td>
    <td><tt>7</tt></td>
  </tr>
</table>

## License and Authors

Author:: Critical Juncture, LLC (<info@criticaljuncture.org>)
