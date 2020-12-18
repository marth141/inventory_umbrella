const QrReader = {
  mounted() {
    var lastResult,
      countResults = 0;

    var hook = this;

    function onScanSuccess(qrCodeMessage) {
      if (qrCodeMessage !== lastResult) {
        ++countResults;
        lastResult = qrCodeMessage;
        hook.pushEvent("qrCodeMessage", { qrCodeMessage });
      }
    }

    var html5QrcodeScanner = new Html5QrcodeScanner("qr-reader", {
      fps: 10,
      qrbox: 250,
    });
    html5QrcodeScanner.render(onScanSuccess);
  },
};

export default QrReader;
