navigator.vibrate = function() {
  Queue.push(Task.init(Queue.length));
  window.webkit.messageHandlers.BlackHawk.postMessage({className: 'Vibration', functionName: 'vibrate', taskId: Queue.length - 1});
}