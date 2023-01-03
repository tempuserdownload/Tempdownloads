class telegraf(
  $websiteurl = undef,
  $influxtoken = undef,
  $organization = undef,
  $bucket = undef,
) {
  #VARIABLE DECLAREREM
  $telversion = '1.22.1-1_amd64'
  # $websiteurl = '"http://10.68.55.27:8086"'
  # $influxtoken = '"Supersecrettoken123=="'
  # $organization = '"org"'
  # $bucket = '"first bucket"'

  #plaats de bestanden
  file { 'deb tel':
    ensure => 'file',
    source => "puppet:///modules/grafana/telegraf_$telversion.deb",
    path   => "/opt/telegraf_$telversion.deb",

  }

  exec { "dpkg tel":
    command => "sudo dpkg -i telegraf_$telversion.deb",
    cwd     => "/opt",
    path    => ['/bin'],
  }


  file { 'push template':
    ensure => 'file',
    source => "puppet:///modules/grafana/template.conf",
    path   => "/etc/telegraf/telegraf.conf",

  }

#veranderd de URL laar de juiste
  file_line { 'serverurl':
    path  => '/etc/telegraf/telegraf.conf',
    line  => "  urls = [$websiteurl]",
    match => '  urls = #';
  }

  file_line { 'token':
    path  => '/etc/telegraf/telegraf.conf',
    line  => "  token = $influxtoken",
    match => '  token = #';
  }


  #voegt de org toe aan de file
  file_line { 'org':
    path  => '/etc/telegraf/telegraf.conf',
    line  => "  organization = $organization",
    match => '  organization = #';
  }
  
#voegt de bucket naam toe aan de file
  file_line { 'bucket':
    path  => '/etc/telegraf/telegraf.conf',
    line  => "  bucket = $bucket",
    match => '  bucket = #';
  }


#activeert de service
  $vc2 = [ 'telegraf']
  service { $vc2: }


}
