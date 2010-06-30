// ==========================================================================
// Project:   DeviceHub.Packet
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals DeviceHub */

/** @class

  (Document your Model here)

  @extends SC.Record
  @version 0.1
*/
DeviceHub.Packet = SC.Record.extend(
/** @scope DeviceHub.Packet.prototype */ {

  device: SC.Record.toOne("DeviceHub.Device", {
    inverse: "packets", isMaster: NO 
  })

}) ;
