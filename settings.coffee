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
      'http://10.19.88.2:2375',
      'http://10.19.88.3:2375',
      'http://10.19.88.4:2375',
      'http://10.19.88.5:2375',
      'http://10.19.88.6:2375',
      'http://10.19.88.7:2375',
      'http://10.19.88.8:2375',
      'http://10.19.88.9:2375',
      'http://10.19.88.10:2375',
      'http://10.19.88.11:2375']
    registry:
      protocol: 'http'
      host:     'docker1.rni.org'
      port:     '5000'

  coreos:
    ssh: 'ssh core@cluster.ictu '
    etcd: 'http://cluster.ictu:4001/v2/keys'
