$(document).ready( function(){
  if (console) {
    console.log('Console plugin ready!');
    if (navigator.accelerometer) {
      console.log('Accelerometer plugin ready!');
    }
  }
});
function accelerometerOnSuccess(acceleration) {
    alert('Acceleration X: ' + acceleration.x + '\n' +
          'Acceleration Y: ' + acceleration.y + '\n' +
          'Acceleration Z: ' + acceleration.z + '\n' +
          'Timestamp: '      + acceleration.timestamp + '\n');
};
function accelerometerOnError(e) {
    alert(e);
};