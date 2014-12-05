# redis_federalregister-cookbook

Wrapper cookbook for the redis recipe that allows setting redis to run as a daemon,
and updates the redis config to support the current stable version of Redis (2.3.18).

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
    <td><tt>['redis']['daemonize']</tt></td>
    <td>String</td>
    <td>whether redis should run as a daemon</td>
    <td><tt>'no'</tt></td>
  </tr>
</table>

## Usage

### redis::default

Include `redis_federalregister` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[redis_federalregister]"
  ]
}
```

## License and Authors

Author:: Critical Juncture, LLC (<info@criticaljuncture.org>)
