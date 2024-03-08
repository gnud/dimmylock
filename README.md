# Screensaver hook for buggy monitors in KDE

It's made for X based graphical environments.

## Purpose


Often, when we shut off our monitors to prevent overheating during extended periods of activity, such as overnight processes, we encounter an inconvenience upon reactivation.

Typically, after using the monitor's power button to turn it off, we discover upon turning it back on that the window arrangements have shifted—condensing onto the laptop's screen or the primary monitor.

To circumvent this issue, we implement a solution that monitors for the lock event signal via D-Bus, specifically listening for:
"interface='org.freedesktop.ScreenSaver"

Upon detecting this event, we execute: ```xset dpms force off``` to make sure it watis for Screen lock.

The event signal listener is start with a systemd service.

Before starting, pleas configure the:
/etc/dimmylockrc file:
```
ARG1=MYUSER
ARG2=USERUID
```

then restart the systemd service:

```bash
sudo systemctl restart dimmylock
```

Check status:

```bash
sudo systemctl status dimmylock
```

It should be green, else check the dimmylockrc file to match your signed user having plasma session.

**NOTE**: this is for single KDE user, not tested for multiple users.

**NOTE**: Make sure power management like:
- external monitors
- laptop lid close events is set to Do nothing + "Even when an external monitor is connected.
- Screen energy saving is off

We can simply just lock the screen on demand and power usage will be avoided.

## TODOS:

- [] Test laptops with lid enabled and external monitors, to make a hook to run our script
- Test screen savers whether our hook will run
- Test on wayland and add supprot if needed or if possible


## Usage

In KDE using the lock global shorcut Control + Alt + L (or any custom combination you have), will trigger the lock signal and run the command to turns off the monitors.

After initiating this process, all screens will become blank within a few milliseconds. To reactivate the screens, simply move your mouse like crazy for a few seconds.
Be aware that some screens might take a bit longer to wake up due to variances in monitor behavior or graphics driver responses.

## FAQ

Why we run it through python as a subprocess?
- Well, for some reason it starts another process and allows several seconds to avoid any inputs from mouse or keyboard that may accidentally interput and turn on the monitors back on.
