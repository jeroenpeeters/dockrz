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
      'http://10.19.88.93:2375',
      'http://10.19.88.94:2375',
      'http://10.19.88.95:2375',
      'http://10.19.88.96:2375',
      'http://10.19.88.97:2375',
      'http://10.19.88.98:2375',
      'http://10.19.88.99:2375',
      'http://10.19.88.100:2375',
      'http://10.19.88.101:2375',
      'http://10.19.88.102:2375']
    registry:
      protocol: 'http'
      host:     'docker1.rni.org'
      port:     '5000'

  coreos:
    ssh: 'ssh core@coreos.rni.org '
    etcd: 'http://coreos.rni.org:4001/v2/keys'
