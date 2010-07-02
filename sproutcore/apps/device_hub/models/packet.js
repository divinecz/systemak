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
/** @scope DeviceHub.Packet.prototype */
{
  primaryKey: "id",

  createdAt: SC.Record.attr(SC.DateTime, {
    key: "created_at"
  }),
  address: SC.Record.attr(String, {
    key: "address"
  }),
  data: SC.Record.attr(String, {
    key: "data"
  }),
  device: SC.Record.toOne("DeviceHub.Device", {
    inverse: "packets",
    isMaster: NO
  }),
  time: function() {
    return this.get("createdAt").toFormattedString("%H:%M:%S");
  }.property().cacheable()

});
