LispWeb
============
![Current Version](https://img.shields.io/badge/version-1.0.0--beta-green.svg)

This is a node.js chat application powered by SockJS and Express that provides the main functions you'd expect from a chat, such as emojis, private messages, an admin system, etc.

![Chat Preview](http://i.imgur.com/lgRe8z4.png)

## Demo
You can test a fully working live demo at https://antun.me/node-chat/
- Type `/help` to get a list of the available chat commands

---

## Features
- Material Design
- Emoji support
- User @mentioning
- Private messaging
- Message deleting (for admins)
- Ability to kick/ban users (for admins)
- See other user's IPs (for admins)
- Other awesome features yet to be implemented

.
![User Features](http://i.imgur.com/WbF1fi2.png)

.
![Admin Features](http://i.imgur.com/xQFaadt.png)


####There are 3 admin levels:
- **Helper:** Can delete chat messages
- **Moderator:** The above plus the ability to kick and ban users
- **Administrator:** All the above plus send global alerts and promote/demote users

---

## Setup
Clone this repo to your desktop and run `npm install` to install all the dependencies.

You might want to look into `config.json` to make change the port you want to use and set up a SSL certificate.

---

## Usage
After you clone this repo to your desktop, go to its root directory and run `npm install` to install its dependencies.

Once the dependencies are installed, you can run  `npm start` to start the application. You will then be able to access it at localhost:3000

To give yourself administrator permissions on the chat, you will have to type `/role [your-name]` in the app console.

---

## License
>You can check out the full license [here](https://github.com/IgorAntun/node-chat/blob/master/LICENSE)

This project is licensed under the terms of the **LGPL v3** license