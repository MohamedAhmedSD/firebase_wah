# Cloud messaging => to send notification into devices
- from FB console => cloud messaging => write title && text =>ss send
- need token??
    - is address of device we need send notification to it
    - any device has its unique token
- how I get device token??
    [1] ensure add : => lesson 37 => min 2
        - firebase messaging into pub.ymal
        - web => index => script => call it
          <script src="https://www.gstatic.com/firebase/7.20.0/firebase-messaging.js"></script>
    [2] write our funcion and call it on init to get tokin
    [3] test:
        - app should on background situation to recive message or terminitaed == closed
        - if you in forground == open app =>
            - it reach but not view on UI
            - what benefit from that??
                    - by using onMessage method => you can create certain event

#########################################################
[FG] foreground , [BG] background, [T] terminate
onMessage => only [FG]
onBackgroundMessage => reach for 3 levels, but can see only when [BG] or [T] 
getInitialMessage()