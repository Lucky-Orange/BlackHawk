Queue = [];
Task = {
  id: 0,
  callback: function(){},
  errorCallback: function(){},
  init: function(id, callback, errorCallback) {
    this.id = id;
    this.callback = callback;
    this.errorCallback = errorCallback;
    return this
  }
};
fireTask = function(i, j) {
  Queue[i].callback(JSON.parse(j));
};
onError = function (i, j) {
  Queue[i].errorCallback(j);
};