//Firebase
const userCollection = 'Users';
const callsCollection = 'Calls';
const tokensCollection = 'Tokens';

const fcmKey = 'AAAAvTfKGKg:APA91bEuZ5X_i-_HObpnLcEOy6T7jfGpVXR191phJgOKQ-hn6HpZtgInnclP6Kx87MPdr1QDY8270TQfyhIgoTM3cZFC5U7SVg1iDmrv-aW0tOZx6DoVbCcOIX0Q8nv0bxZCyWixhzId'; //replace with your Fcm key
//Routes
const loginScreen = '/';
const homeScreen = '/homeScreen';
const callScreen = '/callScreen';
const testScreen = '/testScreen';



//Agora
const agoraAppId = '192a26c66db7459284748c71ad2d3570'; //replace with your agora app id
const agoraTestChannelName = 'testt'; //replace with your agora channel name
const agoraTestToken = '007eJxTYNg+Zc+lmJYUx6+X0x6pfZYofcC7ImFyTeCDyvNZtzPXsy1RYDC0NEo0Mks2M0tJMjcxtTSyMDE3sUg2N0xMMUoxNjU3+FCtlVxwVju5q/wKEyMDBIL4rAwlqcUlJQwMACbJI4Q='; //replace with your agora token

//EndPoints -- this is for generating call token programmatically for each call
const cloudFunctionBaseUrl = '/'; //replace with your clouded api base url
const fireCallEndpoint = 'app/access_token'; //replace with your clouded api endpoint


const int callDurationInSec = 45;

//Call Status
enum CallStatus {
  none,
  ringing,
  accept,
  reject,
  unAnswer,
  cancel,
  end,
}