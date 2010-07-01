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
      childViews: "labelView addButton".w(),
      anchorLocation: SC.ANCHOR_TOP,
      labelView: SC.LabelView.design({
        layout: {
          centerY: 0,
          height: 24,
          left: 8,
          width: 200
        },
        controlSize: SC.LARGE_CONTROL_SIZE,
        fontWeight: SC.BOLD_WEIGHT,
        value: "Device Hub"
      }),
      addButton: SC.ButtonView.design({
        layout: {
          centerY: 0,
          height: 24,
          right: 12,
          width: 150
        },
        title: "Přidat zařízení"
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
          rowHeight: 25
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
                top: 5,
                height: 20,
                width: 100,
                left: 20
              },
              value: "Stav zařízení"
            }),
            deviceCurrentStateNameValueLabelView: SC.LabelView.design({
              layout: {
                top: 5,
                height: 20,
                width: 200,
                left: 150
              },
              valueBinding: "DeviceHub.deviceController.currentStateName"
            }),
            deviceIpAddressLabelView: SC.LabelView.design({
              layout: {
                top: 35,
                height: 20,
                width: 100,
                left: 20
              },
              value: "IP Adresa"
            }),
            deviceIpAddressValueLabelView: SC.LabelView.design({
              layout: {
                top: 35,
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
          itemTitleKey: "title",
          //itemValueKey: "value",
          items: [{
            title: "Pakety"
          },
          {
            title: "Chybová hlášení"
          }]
        })

      })

    })

  })

});
