var externalApp = {
    alertType: {
        OK: 'Ok',
        OK_CANCEL: 'OkCancel'
    },

    launch: function (arguments, success, fail) {
        return cordova.exec(success, fail, "ExternalAppLauncher", "launch", arguments);
    }
};


