# == Class: nova::vncproxy
#
# Configures nova vnc proxy
#
# === Parameters:
#
# [*enabled*]
#   (optional) Whether to run the vncproxy service
#   Defaults to true
#
# [*manage_service*]
#   (optional) Whether to start/stop the service
#   Defaults to true
#
# [*host*]
#   (optional) Host on which to listen for incoming requests
#   Defaults to '0.0.0.0'
#
# [*port*]
#   (optional) Port on which to listen for incoming requests
#   Defaults to '6080'
#
# [*ensure_package*]
#   (optional) The state of the nova-novncproxy package
#   Defaults to 'present'
#
# [*vncproxy_protocol*]
#   (optional) The protocol to communicate with the VNC proxy server
#   Defaults to 'http'
#
# [*vncproxy_path*]
#   (optional) The path at the end of the uri for communication with the VNC
#   proxy server
#   Defaults to '/vnc_auto.html'
#
class nova::vncproxy(
  $enabled           = true,
  $manage_service    = true,
  $vncproxy_protocol = 'http',
  $host              = '0.0.0.0',
  $port              = '6080',
  $vncproxy_path     = '/vnc_auto.html',
  $ensure_package    = 'present'
) {

  include ::nova::deps
  include ::nova::params

  # See http://nova.openstack.org/runnova/vncconsole.html for more details.

  nova_config {
    'vnc/novncproxy_host': value => $host;
    'vnc/novncproxy_port': value => $port;
  }

  include ::nova::vncproxy::common

  nova::generic_service { 'vncproxy':
    enabled        => $enabled,
    manage_service => $manage_service,
    package_name   => $::nova::params::vncproxy_package_name,
    service_name   => $::nova::params::vncproxy_service_name,
    ensure_package => $ensure_package,
  }

}
