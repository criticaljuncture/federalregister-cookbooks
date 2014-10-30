# passenger-apache2-federalregister cookbook

Wrapper cookbook around the passenger-apache2 cookbook that overrides the
passenger.conf file for apache2. This allows us to set things like global queue
and max requests, etc.

## Supported Platforms

Used on ubuntu - may work on other systems but untested there.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['passenger']['pool_idle_time']</tt></td>
    <td>Integer</td>
    <td>The maximum number of seconds that an application process may be idle. That is, if an application process hasn’t received any traffic after the given number of seconds, then it will be shutdown in order to conserve memory.</td>
    <td><tt>3600</tt></td>
  </tr>
  <tr>
    <td><tt>['passenger']['max_requests']</tt></td>
    <td>Integer</td>
    <td>The maximum number of requests an application process will process. After serving that many requests, the application process will be shut down and Passenger will restart it.</td>
    <td><tt>10000</tt></td>
  </tr>
  <tr>
    <td><tt>['passenger']['use_global_queue']</tt></td>
    <td>Boolean</td>
    <td>Whether to turn on Passenger's global queueing. If global queuing is turned on, then Passenger will use a global queue that’s shared between all backend processes.</td>
    <td><tt>false</tt></td>
  </tr>
</table>

## Usage

### passenger_apache2_federalregister::default

Include `passenger_apache2_federalregister` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[passenger_apache2_federalregister]"
  ]
}
```

## License and Authors

Author:: Critical Juncture, LLC (<info@criticaljuncture.org>)
License:: Apache 2.0
