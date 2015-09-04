console = {
  log: function (string) {
    window.webkit.messageHandlers.BlackHawk.postMessage({className: 'Console', functionName: 'log', data: string});
  }
}