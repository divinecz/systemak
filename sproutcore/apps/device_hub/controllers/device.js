// ==========================================================================
// Project:   DeviceHub.deviceController
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals DeviceHub */

/** @class



  (Document Your Controller Here)



  @extends SC.Object

*/
DeviceHub.deviceController = SC.ObjectController.create(
SC.CollectionViewDelegate,
/** @scope DeviceHub.deviceController.prototype */
{

  contentBinding: "DeviceHub.devicesController.selection",

  cancel: function() {
    DeviceHub.devicePage.getPath("mainPane").remove();
  }

});
