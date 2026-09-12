# PetPulse
PetPulse is an intelligent iPhone and iPad app that helps pet owners understand what their pets do when they are away. Connected to a compatible camera—such as a Tapo camera or an iPhone used as a camera—PetPulse automatically observes and logs important moments: when a pet eats, drinks water, rests, changes rooms, barks, or shows unusual activity.

## Local Camera Streaming POC

The first camera proof of concept uses a Tapo C200 on the local network. It validates the video path before PetPulse integrates native playback or AI-based activity detection.

```text
Tapo C200 -- RTSP --> MediaMTX on Mac -- HLS / HTTP --> PetPulse, VLC on iPhone, iPad, or Mac
```

### What has been validated

- A dedicated Tapo Camera Account authorizes third-party access without exposing the primary Tapo account.
- VLC acts as an RTSP client and confirmed that the camera can stream directly to both Mac and iPad over the local network.
- MediaMTX runs on the Mac as a local media proxy. It pulls RTSP from the camera and republishes it as HLS.
- The HLS stream has been played successfully on an iPad through the Mac's local network address.

### Why this architecture

Apple's native media frameworks play HLS, while the Tapo camera supplies RTSP. A local relay bridges those protocols and creates a path that can later support continuous observation, event detection, and notifications without requiring the PetPulse app to remain open.

### Current constraints

- The Mac is a temporary local hub: it must be powered on, MediaMTX must be running, and devices must share the same network.
- Never commit or document camera credentials, private IP addresses, RTSP URLs, OTPs, or HLS URLs.
- Video has been validated through HLS. The camera's G.711 audio requires separate compatibility validation for HLS playback.
