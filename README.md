# 🏛️ Detective City Hall

<p align="center">
A modern, lightweight, and fully configurable City Hall system for QBCore & Qbox servers.<br>
Players can apply for jobs, purchase official documents, and access city information through a beautiful NUI interface.
</p>

---

# ✨ Preview
<img src="https://files.catbox.moe/3sth76.png" width="850"/>

<img src="https://files.catbox.moe/qm6p6j.png" width="450"/>

<img src="https://files.catbox.moe/fkw9wd.png" width="450"/>
> Modern NUI Interface

* 🎨 Responsive Design
* 🌙 Dark Theme
* ⚡ Fast Performance
* 📱 Clean Layout
* 🔥 Optimized Lua Code

---

# 📦 Features

## 🏢 City Hall System

* Interactive City Hall Ped
* Configurable Blip
* Beautiful NUI Interface
* Easy Navigation
* Lightweight & Optimized

---

## 💼 Job Center

Allow players to browse and apply for jobs directly from City Hall.

Features include:

* Multiple Job Listings
* One-Click Apply
* Job Information
* Custom Icons
* Fully Configurable

Example Jobs

* Police
* EMS
* Mechanic
* Taxi
* Trucker
* Garbage
* Tow
* Custom Jobs

---

## 📄 Document Store

Players can purchase official licenses and identification.

Supported Documents

* 🆔 Identity Card
* 🚗 Driver License
* 🔫 Weapon License

Everything is configurable through the shared configuration.

---

## 🎯 Target Support

Supports both popular targeting systems.

* qb-target
* ox_target

Simply change one option in the configuration.

---

## 🗺️ Blip System

Fully configurable map blip.

Includes

* Sprite
* Scale
* Colour
* Name
* Visibility

---

## 👤 Ped System

Customize every aspect of the NPC.

Options

* Model
* Coordinates
* Heading
* Scenario
* Animation
* Target Distance
* Label
* Icon

---

## 🎨 Modern NUI

The interface includes:

* Animated UI
* Smooth Transitions
* Responsive Layout
* Clean Typography
* Hover Effects
* Mobile Friendly
* Dark Theme

Tabs

* Jobs
* Documents
* Information

---

# ⚙️ Requirements

* FiveM FXServer
* QBCore Framework

One of the following:

* qb-target
* ox_target

---

# 📥 Installation

## 1.

Copy the resource into your server.

```
resources/[detective]/detective_cityhall
```

---

## 2.

Add to server.cfg

```
ensure detective_cityhall
```

---

## 3.

Restart the server

```
restart detective_cityhall
```

---

# ⚙️ Configuration

All primary settings are located inside

```
shared.lua
```

Example

```lua
Config.TargetSystem = "qb-target"
```

or

```lua
Config.TargetSystem = "ox_target"
```

---

## Ped

```lua
Config.Ped = {
    model = "a_m_m_business_01",
    coords = vector4(),
    interactDistance = 2.0,
    icon = "fas fa-building",
    label = "Open City Hall"
}
```

---

## Blip

```lua
Config.Blip = {
    enabled = true,
    sprite = 487,
    scale = 0.8,
    colour = 3,
    label = "City Hall"
}
```

---

# 🌐 NUI Configuration

The resource contains two interfaces.

```
html/index.html
```

Main City Hall Interface

```
html/config.html
```

Offline Configuration Interface

Settings are stored using browser LocalStorage.

---

# 📁 Resource Structure

```
detective_cityhall
│
├── client/
│   ├── main.lua
│
├── server/
│   ├── main.lua
│
├── html/
│   ├── css/
│   ├── js/
│   ├── images/
│   ├── index.html
│   └── config.html
│
├── shared.lua
├── fxmanifest.lua
└── README.md
```

---

# 🚀 Performance

✔ Idle

```
0.00 ms
```

✔ Optimized Loops

✔ Event Driven

✔ Lightweight NUI

✔ No Unnecessary Threads

✔ Production Ready

---

# 🛠 Troubleshooting

## qb-target Export Error

```
No such export AddTargetEntity
```

Possible causes

* qb-target is outdated
* qb-target isn't started
* Wrong target selected

Solution

* Update qb-target
* Ensure qb-target starts before detective_cityhall
* Switch to ox_target

```lua
Config.TargetSystem = "ox_target"
```

---

## NUI Not Opening

Check:

* Resource started
* Ped spawned
* Target resource running
* Browser cache

Restart

```
restart detective_cityhall
```

---

## Config Page Issues

If config.js throws errors

Verify that

```
config.js
```

is loaded only by

```
config.html
```

and **not**

```
index.html
```

---

# 🔧 Customization

You can easily customize

* Jobs
* Documents
* Ped
* Blip
* UI Colors
* Icons
* Labels
* Language
* Target System

No core edits required.

---

# ❤️ Why detective City Hall?

* Modern Design
* Easy Installation
* Beginner Friendly
* Developer Friendly
* Optimized Performance
* Fully Configurable
* Open Source
* Supports Multiple Target Systems
* Professional UI
* Clean Codebase

---

# 🤝 Contributing

Pull Requests are welcome.

If you discover bugs or have ideas for improvements, feel free to contribute and help improve the project.

---

# 📜 License

This project is released as Open Source.

You are free to:

* Modify
* Improve
* Fork
* Learn from the code

Please do not remove original credits when redistributing.

---

# 💙 Credits

Special thanks to **SWGAURKO**

Made with ❤️ for the FiveM Community.
