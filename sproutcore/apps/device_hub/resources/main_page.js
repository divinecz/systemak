// ==========================================================================
// Project:   DeviceHub - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals DeviceHub */

// This page describes the main user interface for your application.
DeviceHub.mainPage = SC.Page.design({

  // The main pane is made visible on screen as soon as your app is loaded.
  // Add childViews to this pane for views to display immediately on page
  // load.
  mainPane: SC.MainPane.design({
    childViews: "toolbarView splitView".w(),

    toolbarView: SC.ToolbarView.design({
      layout: {
        top: 0,
        left: 0,
        right: 0,
        height: 36
      },
      childViews: "labelView refreshButton addButton removeButton".w(),
      anchorLocation: SC.ANCHOR_TOP,
      labelView: SC.LabelView.design({
        layout: {
          centerY: 0,
          height: 24,
          right: 10,
          width: 150
        },
        textAlign: "right",
        controlSize: SC.LARGE_CONTROL_SIZE,
        fontWeight: SC.BOLD_WEIGHT,
        value: "Device Hub"
      }),
      refreshButton: SC.ButtonView.design({
        layout: {
          centerY: 0,
          height: 24,
          left: 10,
          width: 100
        },
        icon: sc_static("icons/arrow-circle-double.png"),
        title: "Obnovit",
        target: "DeviceHub.devicesController",
        action: "refreshDevices"
      }),
      addButton: SC.ButtonView.design({
        layout: {
          centerY: 0,
          height: 24,
          left: 115,
          width: 100
        },
        icon: sc_static("icons/plus-circle.png"),
        title: "Přidat"
      }),
      removeButton: SC.ButtonView.design({
        layout: {
          centerY: 0,
          height: 24,
          left: 220,
          width: 100
        },
        icon: sc_static("icons/minus-circle.png"),
        title: "Odstranit",
        target: "DeviceHub.devicesController",
        action: "deleteDevice"
      })
    }),

    splitView: SC.SplitView.design({
      layout: {
        top: 36,
        right: 0,
        bottom: 0,
        left: 0
      },
      defaultThickness: 0.25,
      topLeftView: SC.ScrollView.design({
        hasHorizontalScroller: NO,
        backgroundColor: "white",
        anchorLocation: SC.ANCHOR_BOTTOM,
        contentView: SC.SourceListView.design({
          contentBinding: "DeviceHub.devicesController.arrangedObjects",
          selectionBinding: "DeviceHub.devicesController.selection",
          contentValueKey: "name",
          hasContentIcon: YES,
          contentIconKey: "icon",
          rowHeight: 25,
          destroyOnRemoval: YES
        })
      }),

      bottomRightView: SC.View.design({
        backgroundColor: "#d4d7e0",
        childViews: "wellView tabView".w(),
        wellView: SC.WellView.design({
          layout: {
            top: 15,
            left: 15,
            right: 15,
            height: 80
          },
          contentView: SC.View.design({
            childViews: "deviceCurrentStateNameLabelView deviceCurrentStateNameValueLabelView deviceIpAddressLabelView deviceIpAddressValueLabelView".w(),
            deviceCurrentStateNameLabelView: SC.LabelView.design({
              layout: {
                top: 0,
                height: 20,
                width: 100,
                left: 20
              },
              value: "Stav zařízení"
            }),
            deviceCurrentStateNameValueLabelView: SC.LabelView.design({
              layout: {
                top: 0,
                height: 20,
                width: 200,
                left: 150
              },
              valueBinding: "DeviceHub.deviceController.currentStateName"
            }),
            deviceIpAddressLabelView: SC.LabelView.design({
              layout: {
                top: 30,
                height: 20,
                width: 100,
                left: 20
              },
              value: "IP Adresa"
            }),
            deviceIpAddressValueLabelView: SC.LabelView.design({
              layout: {
                top: 30,
                height: 20,
                width: 200,
                left: 150
              },
              valueBinding: "DeviceHub.deviceController.ipAddress"
            })
          })
        }),
        tabView: SC.TabView.design({
          layout: {
            left: 15,
            right: 15,
            top: 110,
            bottom: 15
          },
          nowShowing: "DeviceHub.mainPage.packetsTableView",
          itemTitleKey: "title",
          itemValueKey: "value",
          items: [{
            title: "Pakety",
            value: "DeviceHub.mainPage.packetsTableView"
          },
          {
            title: "Chybová hlášení",
            value: ""
          }]
        })

      })

    })

  }),

  packetsTableView: SC.TableView.design({
    layout: {
      left: 15,
      right: 15,
      top: 15,
      bottom: 15
    },
    backgroundColor: "white",
    columns: [
    SC.TableColumn.create({
      key: "time",
      label: "Čas",
      width: 100
    }), SC.TableColumn.create({
      key: "address",
      label: "Adresa",
      width: 100
    }), SC.TableColumn.create({
      key: "data",
      label: "Data",
      width: 200
    })],

    contentBinding: "DeviceHub.packetsController.arrangedObjects",
    selectionBinding: "DeviceHub.packetsController.selection",
    selectOnMouseDown: YES,
    exampleView: SC.TableRowView,
    recordType: DeviceHub.Packet
  })

});
