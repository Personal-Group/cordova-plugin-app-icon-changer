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

AppIconChanger.prototype.getAlternativeAppIconNames = function (onSuccess, onFail) {
  exec(onSuccess, onFail, "AppIconChanger", "getAlternativeAppIconNames", []);
};

AppIconChanger.prototype.getAlternativeAppIconByName = function (options, onSuccess, onFail) {
  exec(onSuccess, onFail, "AppIconChanger", "getAlternativeAppIconByName", [options]);
};

module.exports = new AppIconChanger();
