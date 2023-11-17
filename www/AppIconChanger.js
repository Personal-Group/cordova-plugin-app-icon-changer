var exec = require("cordova/exec");

var AppIconChanger = function () {};

AppIconChanger.prototype.isSupported = function (onSuccess, onFail) {
  exec(onSuccess, onFail, "AppIconChanger", "isSupported", []);
};

AppIconChanger.prototype.changeIcon = function (options, onSuccess, onFail) {
  exec(onSuccess, onFail, "AppIconChanger", "changeIcon", [options]);
};

AppIconChanger.prototype.currentIconName = function (options, onSuccess, onFail) {
  exec(onSuccess, onFail, "AppIconChanger", "currentIconName", []);
};

AppIconChanger.prototype.getAppIcon = function (options, onSuccess, onFail) {
  exec(onSuccess, onFail, "AppIconChanger", "getAppIcon", [options]);
};

module.exports = new AppIconChanger();
