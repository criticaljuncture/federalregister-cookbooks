# iodocs-cookbook

Installs and configures the iodocs interactive API documentation by Mashery.

This cookbook does not create the user or group that iodocs will run under,
(by default "iodocs:iodocs") - it is up to the user to ensure these exist on
the system being provisioned.

This cookbook also creates an upstart script for starting and stopping
iodocs.

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
    <td><tt>['iodocs']['path']</tt></td>
    <td>String</td>
    <td>where iodocs repo should be cloned to</td>
    <td><tt>/var/www/apps/iodocs</tt></td>
  </tr>
  <tr>
    <td><tt>['iodocs']['repo_url']</tt></td>
    <td>String</td>
    <td>which iodocs repo to clone - probably your fork</td>
    <td><tt>git://github.com/mashery/iodocs.git</tt></td>
  </tr>
  <tr>
    <td><tt>['iodocs']['repo_ref']</tt></td>
    <td>String</td>
    <td>which repo branch/commit to clone</td>
    <td><tt>master</tt></td>
  </tr>
  <tr>
    <td><tt>['iodocs']['address']</tt></td>
    <td>String</td>
    <td>which address iodocs is listening on</td>
    <td><tt>0.0.0.0</tt></td>
  </tr>
  <tr>
    <td><tt>['iodocs']['port']</tt></td>
    <td>Integger</td>
    <td>which port iodocs is running on</td>
    <td><tt>3000</tt></td>
  </tr>
  <tr>
    <td><tt>['iodocs']['title']</tt></td>
    <td>String</td>
    <td>title of iodocs installation</td>
    <td><tt>I/O Docs - http://github.com/mashery/iodocs</tt></td>
  </tr>
  <tr>
    <td><tt>['iodocs']['debug']</tt></td>
    <td>Boolean</td>
    <td>whether iodocs should run in debig mode</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['iodocs']['session_secret']</tt></td>
    <td>String</td>
    <td>session secret for iodocs - you should set this to something real</td>
    <td><tt>12345</tt></td>
  </tr>
  <tr>
    <td><tt>['iodocs']['user']</tt></td>
    <td>String</td>
    <td>which user iodocs should run under</td>
    <td><tt>iodocs</tt></td>
  </tr>
  <tr>
    <td><tt>['iodocs']['group']</tt></td>
    <td>String</td>
    <td>which group iodocs should run under</td>
    <td><tt>iodocs</tt></td>
  </tr>
  <tr>
    <td><tt>['iodocs']['redis_database']</tt></td>
    <td>Integer</td>
    <td>which redis database iodocs should use</td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['iodocs']['redis_host']</tt></td>
    <td>String</td>
    <td>which redis host iodocs should connect to</td>
    <td><tt>0.0.0.0</tt></td>
  </tr>
  <tr>
    <td><tt>['iodocs']['redis_password']</tt></td>
    <td>String</td>
    <td>password for the redis db that iodocs should use</td>
    <td><tt>""</tt></td>
  </tr>
</table>

## Usage

### iodocs::default

Include `iodocs` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[iodocs::default]"
  ]
}
```

## License and Authors

Author:: Critical Juncture, LLC (<info@criticaljuncture.org>)
