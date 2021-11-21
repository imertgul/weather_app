# weather_app

It is a demo weather app.
| Service      | Source |
| ----------- | ----------- |
| Countries & Cities| countriesnow.space|
| Weather data      | OpenWeather       |
| Auth service      | Cognito           |

JSON serialization with genereted code [Docs](https://docs.flutter.dev/development/data-and-backend/json)


## Features
 - Search and save cities for weather data
   - Cities saved on shared preferences. Not related with accounts.
 - Location based weather data
 - Cognito Auth. 
 - Click on weather card to see more information with basic animation.

You can test the app on [live demo](https://weatherapp-c1b34.web.app/) without auth version or download apk from releases(with auth).

<img src="https://raw.githubusercontent.com/imertgul/weather_app/master/screenshots/Screenshot_1637516720.png" width = 150>
<img src="https://raw.githubusercontent.com/imertgul/weather_app/master/screenshots/Screenshot_1637516736.png" width = 150>
<img src="https://raw.githubusercontent.com/imertgul/weather_app/master/screenshots/Screenshot_1637516742.png" width = 150>
<img src="https://raw.githubusercontent.com/imertgul/weather_app/master/screenshots/Screenshot_1637516747.png" width = 150>


## Start Projects
You have to set and configure [Amplify CLI](https://docs.amplify.aws/lib/auth/getting-started/q/platform/flutter/) to run application.

- You can start app on `feature/no_auth` branch without configration of Amplify

After that you have to set Open Weather api key for `WeatherHelper` class.


```
flutter pub get
flutter run
```
If you want to run for web without debugging service(Amplify not supported on Flutter Web). 
```
flutter run -d web-server --web-port 8000
```


 ## Known bugs
- Error messages on flutter web is broken by minifier
- Location service fails on safari browser. 
- You can find and city on the earth from cities api.  