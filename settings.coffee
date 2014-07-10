@settings =
  docker:
    endpoints: [
      'http://docker1.rni.org:4243',
      'http://docker2.rni.org:4243',
      'http://docker3.rni.org:4243',
      'http://docker4.rni.org:4243',
      'http://docker5.rni.org:4243',
      'http://docker6.rni.org:4243',
      'http://docker7.rni.org:4243',
      'http://docker8.rni.org:4243',
      'http://docker9.rni.org:4243',
      'http://10.19.55.141:4243',
      'http://10.19.55.142:4243',
      'http://10.19.55.143:4243',
      'http://10.19.55.144:4243']
    registry:
      protocol: 'http'
      host:     'docker1.rni.org'
      port:     '5000'

  coreos:
    ssh: 'ssh core@coreos.rni.org '  
    etcd: 'http://coreos.rni.org:4001/v2/keys'