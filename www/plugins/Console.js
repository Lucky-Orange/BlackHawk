console = {
  log: function (string) {
    Queue.push(Task.init(Queue.length));
    window.webkit.messageHandlers.BlackHawk.postMessage({className: 'Console', functionName: 'log', taskId: Queue.length - 1, data: string});
  }
}