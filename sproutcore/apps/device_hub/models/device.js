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
  ip_address: SC.Record.attr(String),
  current_state: SC.Record.attr(String),
  icon: sc_static("icons/server.png"),
  stateIcon: function() {
    this.get("current_state");
    return sc_static("icons/server.png");
  }.property()
});
