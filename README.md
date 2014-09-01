# chef-pxe

PXE boot cookbook.
* Depends on [apt](https://supermarket.getchef.com/cookbooks/apt) cookbook.
* Depends on [yum](https://supermarket.getchef.com/cookbooks/yum) cookbook.
* Depends on [tftp](https://supermarket.getchef.com/cookbooks/tftp) cookbook.
* Depends on [apache2](https://supermarket.getchef.com/cookbooks/apache2) cookbook.

## Supported Platforms
Supported systems:
<ol>
  <li>Ubuntu 12.04</li>
  <li>Centos 6.5</li>
</ol>

## Attributes

| Key | Type | Description | Value |
|-----|------|-------------|-------|
| default['dhcp']['eth'] | text | Ethernet adapter name for dhcp server. | E.g "eth1" |
| default['dhcp']['configs']['subnet'] | text | Subnet IP | E.g. '192.168.56.0' |
| default['dhcp']['configs']['routers'] | text | IP of dhcp router | E.g. '192.168.56.5' |
| default['dhcp']['configs']['next_server'] | text | IP that points to TFTPD server | E.g. "192.168.56.5" |
| default['dhcp']['configs']['dynamic_range'] | text | Range of IP for clients | E.g. "192.168.56.100 192.168.56.200" |
| default['dhcp']['configs']['subnet_mask'] | text | Subnet mask | E.g. "255.255.255.0" |
| default['download']['default_image'] | boolean | Prepare default PXE netboot image. True will download a minimal centos. | true/false |
| default['pxe']['hostname'] | text | IP or hostname for apache virtual host | E.g. "192.168.56.5" |


## TODO:
* Complete the documentation.

## Usage

### chef-pxe::default

Include `chef-pxe` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[chef-pxe::default]"
  ]
}
```

If you have a restrict access to internet, change attribute value 
``` default['download']['from_web'] = 'false' ```.
it allows you to add netboot image by yourself.

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Denis Chekirda (dchekirda@gmail.com)
