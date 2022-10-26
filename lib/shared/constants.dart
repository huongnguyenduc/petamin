//Firebase
const userCollection = 'Users';
const callsCollection = 'Calls';
const tokensCollection = 'Tokens';

const fcmKey = 'AAAA2vxfEEo:APA91bFfHvgWkI7jBKCLlE5_vceEgHEVB4KLMDkyNXjvMdSQub8xQE_AAj0d65UrXfdHuCVx5LveuZC9mIFyLLOiT67aLfP3WdHU1pYsUHdWRKR7vrt5YQ_HtmYYHrM1FMQam5nKLsCU'; //replace with your Fcm key
//Routes
const loginScreen = '/';
const homeScreen = '/homeScreen';
const callScreen = '/callScreen';
const testScreen = '/testScreen';



//Agora
const agoraAppId = '192a26c66db7459284748c71ad2d3570'; //replace with your agora app id
const agoraTestChannelName = 'testt'; //replace with your agora channel name
const agoraTestToken = '007eJxTYJh8eOp/1qZ1WVPE1j++PzPKbF25hYWy/lLHl8eiw+O4peYrMBhaGiUamSWbmaUkmZuYWhpZmJibWCSbGyamGKUYm5obBE+ISG4MZGRwZpVmZWSAQBCflaEktbikhIEBABQ4HVA='; //replace with your agora token

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