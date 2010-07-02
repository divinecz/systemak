// ==========================================================================
// Project:   DeviceHub.devicePage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals DeviceHub */

// This page describes a part of the interface for your application.
DeviceHub.devicePage = SC.Page.design({

  mainPane: SC.PanelPane.design({
    layout: {
      centerX: 0,
      width: 400,
      centerY: 0,
      height: 200
    },
    contentView: SC.View.design({

      childViews: "title prompt createButton cancelButton nameLabel nameTextField ipAddressLabel ipAddressTextField".w(),

      title: SC.LabelView.design({
        layout: {
          top: 12,
          left: 20,
          height: 24,
          right: 20
        },
        controlSize: SC.LARGE_CONTROL_SIZE,
        fontWeight: SC.BOLD_WEIGHT,
        value: "Přidat zařízení"
      }),

      prompt: SC.LabelView.design({
        layout: {
          top: 36,
          left: 20,
          height: 18,
          right: 20
        },
        value: "Zadejte údaje o novém zařízení:"
      }),

      nameLabel: SC.LabelView.design({
        layout: {
          top: 70,
          left: 50,
          width: 70,
          height: 18
        },
        textAlign: SC.ALIGN_RIGHT,
        value: "Název"
      }),

      nameTextField: SC.TextFieldView.design({
        layout: {
          top: 70,
          left: 130,
          height: 20,
          width: 200
        },
        hint: "Zařízení",
        valueBinding: "DeviceHub.deviceController.name"
      }),

      ipAddressLabel: SC.LabelView.design({
        layout: {
          top: 100,
          left: 50,
          width: 70,
          height: 18
        },
        textAlign: SC.ALIGN_RIGHT,
        value: "IP Adresa"
      }),

      ipAddressTextField: SC.TextFieldView.design({
        layout: {
          top: 100,
          left: 130,
          height: 20,
          width: 200
        },
        hint: "192.168.1.1",
        valueBinding: "DeviceHub.deviceController.ipAddress"
      }),

      createButton: SC.ButtonView.design({
        layout: {
          bottom: 20,
          right: 20,
          width: 90,
          height: 24
        },
        title: "Vytvořit",
        isDefault: YES,
        action: "submit"
      }),

      cancelButton: SC.ButtonView.design({
        layout: {
          bottom: 20,
          right: 120,
          width: 90,
          height: 24
        },
        title: "Zrušit",
        isCancel: YES,
				target: "DeviceHub.deviceController",
        action: "cancel"
      })

    })
  })

});
