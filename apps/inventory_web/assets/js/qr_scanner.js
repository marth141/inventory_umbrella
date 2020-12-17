const QrReader = {
  mounted() {
    var resultContainer = document.getElementById("qr-reader-results");
    var lastResult,
      countResults = 0;

    var self = this;

    function onScanSuccess(qrCodeMessage) {
      if (qrCodeMessage !== lastResult) {
        ++countResults;
        lastResult = qrCodeMessage;
        resultContainer.innerHTML += `<div>[${countResults}] - ${qrCodeMessage}</div>`;
        self.pushEvent("jsEventToPhx", { foo: qrCodeMessage }, (reply, ref) =>
          console.log(reply)
        );
      }
    }

    var html5QrcodeScanner = new Html5QrcodeScanner("qr-reader", {
      fps: 10,
      qrbox: 250,
    });
    html5QrcodeScanner.render(onScanSuccess);

    console.log("mounted!");
  },
};

export default QrReader;
