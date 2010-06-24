// ==========================================================================
// Project:   DeviceHub.RailsDataSource
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals DeviceHub */

/** @class

  (Document Your Data Source Here)

  @extends SC.DataSource
*/
sc_require('models/device');
DeviceHub.DEVICES_QUERY = SC.Query.local(DeviceHub.Device, {
  orderBy: 'name'
});

DeviceHub.RailsDataSource = SC.DataSource.extend(
/** @scope DeviceHub.RailsDataSource.prototype */
{

  // ..........................................................
  // QUERY SUPPORT
  // 
  fetch: function(store, query) {
    switch (query) {
    case DeviceHub.DEVICES_QUERY:
      {
        SC.Request.getUrl('/devices.json').json().notify(this, 'didFetchDevices', store, query).send();
        return YES;
      }
    }
    return NO;
  },

  didFetchDevices: function(response, store, query) {
    if (SC.ok(response)) {
      store.loadRecords(DeviceHub.Device, response.get('body'));
      store.dataSourceDidFetchQuery(query);

    } else store.dataSourceDidErrorQuery(query, response);
  },

  // ..........................................................
  // RECORD SUPPORT
  // 
  retrieveRecord: function(store, storeKey) {

    // TODO: Add handlers to retrieve an individual record's contents
    // call store.dataSourceDidComplete(storeKey) when done.
    return NO; // return YES if you handled the storeKey
  },

  createRecord: function(store, storeKey) {

    // TODO: Add handlers to submit new records to the data source.
    // call store.dataSourceDidComplete(storeKey) when done.
    return NO; // return YES if you handled the storeKey
  },

  updateRecord: function(store, storeKey) {

    // TODO: Add handlers to submit modified record to the data source
    // call store.dataSourceDidComplete(storeKey) when done.
    return NO; // return YES if you handled the storeKey
  },

  destroyRecord: function(store, storeKey) {

    // TODO: Add handlers to destroy records on the data source.
    // call store.dataSourceDidDestroy(storeKey) when done
    return NO; // return YES if you handled the storeKey
  }

});
