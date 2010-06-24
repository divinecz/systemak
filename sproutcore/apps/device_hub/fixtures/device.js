// ==========================================================================
// Project:   DeviceHub.Device Fixtures
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals DeviceHub */

sc_require('models/device');

DeviceHub.Device.FIXTURES = [

// TODO: Add your data fixtures here.
// All fixture records must have a unique primary key (default 'guid').  See 
// the example below.
{
  id: 1,
  name: "Zařízení #1",
  ip_address: "192.168.1.1",
  current_state: "online"
},

{
  id: 2,
  name: "Zařízení #2",
  ip_address: "192.168.1.2",
  current_state: "online"
},

{
  id: 3,
  name: "Zařízení #3",
  ip_address: "192.168.1.3",
  current_state: "offline"
}

];
