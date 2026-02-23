# Whip App

A mobile-first web app inspired by the whip-sound gag from *The Big Bang Theory*: snap your phone like a whip, and the app plays a dramatic whip crack with visual effects.

## Original Idea

The core concept is simple:

1. Open a web app on your phone.
2. Do a fast “whip” hand gesture.
3. Play a whip-crack sound instantly, with feedback that feels punchy.

This project implements that idea using phone motion sensors (`devicemotion`), Web Audio, vibration (where supported), and lightweight PWA support.

## Features

- Motion gesture detection for whip-like snaps.
- Whip crack audio playback (`assets/crack_the_whip.mp3`).
- Visual feedback:
  - Flash overlay
  - Whip SVG crack animation
  - Spark burst particles
  - Crack counter with bounce effect
- Haptic vibration on supported devices.
- iOS motion-permission flow (`DeviceMotionEvent.requestPermission()`).
- Tap-to-crack fallback for desktop or sensor-limited devices.
- PWA-ready basics:
  - `manifest.json`
  - `sw.js` service worker with static asset caching

## Project Structure

```text
.
├── index.html                  # Main app UI + JS logic
├── manifest.json               # PWA manifest
├── sw.js                       # Service worker cache logic
└── assets/
    └── crack_the_whip.mp3      # Whip crack sound sample
```

## Requirements

- Python 3 (to run a local static server)
- ngrok (to expose your local server over HTTPS for easy phone testing)
- A phone with motion sensors (best experience)

## Run Locally (Python Server)

From the project root:

```bash
cd /Users/anish/Documents/stuff/wip-app
python3 -m http.server 8000
```

Then open:

- On your computer: `http://localhost:8000`
- On the same phone (if local access works for your setup): `http://<your-computer-ip>:8000`

## Expose with ngrok (Recommended for Phone Testing)

Keep the Python server running, then in a second terminal:

```bash
ngrok http 8000
```

ngrok will print a forwarding URL like:

```text
https://abcd-1234.ngrok-free.app
```

Open that HTTPS URL on your phone.

Why ngrok helps:

- Easy external/mobile access
- HTTPS endpoint (important for browser/device APIs and mobile testing convenience)

## How to Use

1. Open the app URL on your phone.
2. If on iPhone/iOS, tap **Enable Whip** and allow motion access.
3. If on other devices, tap **Start** once to unlock audio.
4. Snap your phone quickly like cracking a whip.
5. If motion is unavailable, use **[ Tap to Crack ]**.

## iOS Notes

- iOS may require motion access permission in browser settings.
- If permission is denied, enable motion/orientation access in Safari settings and retry.
- Audio must be unlocked by a user gesture, so tapping the start/enable button first is required.

## Troubleshooting

- No sound:
  - Make sure you tapped **Start** / **Enable Whip** first (audio unlock).
  - Check phone volume and silent mode settings.
- No motion response:
  - Confirm browser has motion permission.
  - Try a stronger/faster whip gesture.
  - Use tap fallback to confirm the app is functioning.
- ngrok URL not loading:
  - Confirm Python server is running on port `8000`.
  - Confirm ngrok is forwarding the same port.
  - Restart ngrok and use the latest generated URL.

## PWA / Caching Notes

- Service worker caches:
  - `/index.html`
  - `/manifest.json`
  - `/sw.js`
  - `/assets/crack_the_whip.mp3`
- Cache key is versioned in `sw.js` (`whip-app-v5`).
- If you change cached files and don’t see updates, bump cache version in `sw.js` and reload.

## Quick Dev Workflow

```bash
# Terminal 1
cd /Users/anish/Documents/stuff/wip-app
python3 -m http.server 8000

# Terminal 2
ngrok http 8000
```

Then test on both:

- Desktop browser (`http://localhost:8000`)
- Phone browser (`https://<your-ngrok-domain>`)

## Future Improvements

- Adjustable motion sensitivity slider
- Multiple whip sound packs
- Better gesture classification to reduce false triggers
- Save/share crack count stats
- Optional calibration flow per device
