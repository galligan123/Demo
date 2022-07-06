param dnsZone string

resource publicDns 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: dnsZone
  location: 'global'
}

resource Apex_A 'Microsoft.Network/dnsZones/A@2018-05-01' = {
  parent: publicDns
  name: 'www.drhauschkaltd.ie'
  properties: {
    TTL: 3600
    'ARecords': [
      {
        ipv4Address: '78.153.214.19'
      }
    ]
  }
}

resource Apex_MX 'Microsoft.Network/dnsZones/MX@2018-05-01' = {
  parent: publicDns
  name: '@'
  properties: {
    TTL: 3600
    MXRecords: [
      {
        preference: 1
        exchange: 'drhauschkaltd-ie.mail.protection.outlook.com'
      }
    ]
  }
}

resource Apex_TXT 'Microsoft.Network/dnsZones/TXT@2018-05-01' = {
  parent: publicDns
  name: '@'
  properties:{
    TTL:3600
    TXTRecords: [
      {
        value: [
          'MS=ms97974778'
          'v=spf1 include:spf.protection.outlook.com -all'
        ]
      }
    ]
  }
}

resource autodiscover 'Microsoft.Network/dnsZones/CNAME@2018-05-01' = {
  parent: publicDns
  name: 'autodiscover'
  properties:{
    TTL:3600
    CNAMERecord: {
      cname: 'autodiscoveroutlook.com'
    }
      
  }
}
