@settings =
  docker:
    endpoints: [
      'http://docker1.rni.org:4243',
      'http://docker2.rni.org:4243',
      'http://docker3.rni.org:4243',
      'http://docker4.rni.org:4243',
      'http://docker5.rni.org:4243',
      'http://docker6.rni.org:4243',
      'http://10.19.55.141:4243',
      'http://10.19.55.142:4243',
      'http://10.19.55.143:4243',
      'http://10.19.55.144:4243']
    registry:
      endpoint: 'http://docker1.rni.org:5000'

  fleet:
    endpoint: 'ssh rni@docker-cluster.rni.org -p 443 '
