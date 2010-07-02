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
SC.CollectionViewDelegate,
/** @scope DeviceHub.devicesController.prototype */
{

  selectionDidChange: function() {}.observes("selection"),

  loadDevices: function() {
    var devices = DeviceHub.store.find(DeviceHub.DEVICES_QUERY);
    var packets = DeviceHub.store.find(DeviceHub.PACKETS_QUERY);
    DeviceHub.devicesController.set("content", devices);
    DeviceHub.devicesController.set("packets", packets);
  },

  refreshDevices: function() {
    DeviceHub.store.reset();
    this.get("content").refresh();
    this.get("packets").refresh();
  },

  addDevice: function() {
    DeviceHub.devicePage.getPath("mainPane").append();
  },

  deleteDevice: function() {
    SC.AlertPane.warn("Opravdu si přejete odstranit zařízení?", "Odstraněním zařízení budou nenávratně ztracena i všechna jeho data.", "", "Odstranit", "Zrušit", DeviceHub.devicesController);
  },

  collectionViewDeleteContent: function(view, content, indexes) {
    var records = indexes.map(function(index) {
      return this.objectAt(index);
    },
    this);
    records.invoke('destroy');
    var selectionIndex = indexes.get('min') - 1;
    if (selectionIndex < 0) selectionIndex = 0;
    this.selectObject(this.objectAt(selectionIndex));
  },

  alertPaneDidDismiss: function(pane, status) {
    if (status == SC.BUTTON1_STATUS) {
      var list = DeviceHub.mainPage.getPath("mainPane.splitView.topLeftView.contentView");
      list.set("canDeleteContent", YES);
			list.deleteSelection();
			list.set("canDeleteContent", NO);
    }
  },

});
