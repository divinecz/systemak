// ==========================================================================
// Project:   DeviceHub.devicesController
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals DeviceHub */

/** @class

  (Document Your Controller Here)

  @extends SC.ArrayController
*/
DeviceHub.devicesController = SC.ArrayController.create(
/** @scope DeviceHub.devicesController.prototype */
{

  selectionDidChange: function() {}.observes('selection'),

  loadDevices: function() {
    var devices = DeviceHub.store.find(DeviceHub.DEVICES_QUERY);
    var packets = DeviceHub.store.find(DeviceHub.PACKETS_QUERY);
    DeviceHub.devicesController.set("content", devices);
		DeviceHub.devicesController.set("packets", packets);
  },

  refreshDevices: function() {
		this.get("content").refresh();
		this.get("packets").refresh();
  }

});
