exec { 'rser-start':
  command => 'sudo service rserve start',
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}