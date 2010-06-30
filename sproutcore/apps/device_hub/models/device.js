// ==========================================================================
// Project:   DeviceHub.Device
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals DeviceHub */

/** @class

  (Document your Model here)

  @extends SC.Record
  @version 0.1
*/
DeviceHub.Device = SC.Record.extend(
/** @scope DeviceHub.Device.prototype */
{
  primaryKey: "id",

  name: SC.Record.attr(String),
  ipAddress: SC.Record.attr(String, { key: "ip_address" }),
  currentState: SC.Record.attr(String, { key: "current_state" }),
  packets: SC.Record.toMany("DeviceHub.Packet", {
    inverse: "device", isMaster: YES
  }),

  icon: sc_static("icons/server.png"),
  stateIcon: function() {
    this.get("currentState");
    return sc_static("icons/server.png");
  }.property()
});
