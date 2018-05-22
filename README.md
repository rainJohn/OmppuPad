# OmppuPad

Smart home control center/Dashboard written in [Flutter](https://flutter.io/).

## About

The idea for this project started with an old iPad 2 (2011) laying around at home.
The main goal was to repurpose it and have an excuse to test drive Flutter.

Eventually, the project has expanded to become a smart home hub for personal use:

![alt text](https://github.com/christat/OmppuPad/blob/master/example/omppu_pad.png "Dashboard screenshot")

Overall, it's impressive how quick and easy it is to build fairly elaborate apps with Flutter. :fireworks:

#### NOTE

If you have an ARM 32-bit iPad (such as myself), you will have to go through some extra steps to deploy. 

For more information, follow this [Github issue](https://github.com/flutter/flutter/issues/2089) and 
follow the steps to enable a workaround.

## Features

- Weather forecast through [OpenWeatherMap API](https://openweathermap.org/forecast5)
- Finnish Public Transport routing API from [HSL Open Data](https://digitransit.fi/en/developers/apis/1-routing-api/)
- Philips [Hue API](https://www.developers.meethue.com/philips-hue-api) per-room light toggles
- Global theme configuration with Dark Mode toggle
- Device battery indicator (as app is fullscreen)
- Spotify integration (WIP)

## Configuration

For the application to work as intended, a configuration file `keychain.yml` needs to
be provided under the `lib/assets` folder, with the following contents:

```yaml
hue_api_key: <key>
hue_bridge_addr: <bridge addr>
open_weather_map_api_key: <key>
```

## Work In Progress

- [ ] Integration with Spotify's Beta Remote API.

## Wishlist

This app is far from something deployable. Namely:

- [ ] API Keys on client side/no proper protection
- [ ] No automagic discovery of Hue bridge
- [ ] stop queries are hardcoded (stop ids)
- [ ] No choice of lat,lon for date and forecast

## Credits

Weather icons designed by Freepik from Flaticon.

## License

MIT




