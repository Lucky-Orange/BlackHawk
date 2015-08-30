navigator.vibrate = function() {
  window.webkit.messageHandlers.BlackHawk.postMessage({className: 'Vibration', functionName: 'vibrate', taskId: 0});
}