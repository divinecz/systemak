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

  selectionDidChange: function() {
	  // var packets = DeviceHub.store.find(DeviceHub.DEVICES_QUERY);
	  // DeviceHub.devicesController.set("content", devices);
	}.observes('selection')

});
