LispWeb
============
![Current Version](https://img.shields.io/badge/version-1.0.0--beta-green.svg)

LispWeb is a functional web language with native support of data sources.
It is an all-in-one language (a.k.a. multi-tier). 
It supports server code, client code and data sources code in only a single language.

## Functional

The high expressiveness of functional programming languages is mainly due to functions that are [first-class citizen](https://en.wikipedia.org/wiki/First-class_citizen)

In functional languages you can sum integers in a very class manner

```ocaml
List.fold_left (fun sum x -> sum + x) 0 [1;2;3] (*OCaml*)
```

Copy/paste

`echo "print_int(List.fold_left (fun sum x -> sum + x) 0 [1;2;3])" | ocaml -stdin`

It will display `6`

## Parenthesis 

Most people are frigthened by parenthesis while it is a big advantage. 
It leaves no space for ambiguity.
Do you know that in C, arguments of function are evaluated in reverse order?

If you try to compile and execute

```c
#include <stdio.h>
char c = 'a';
int f(){c = 'f';return 6;}
int g(){c = 'f';return 7;}
void h(int x, int y){}
int main() {h(f(),g());printf("%c\n",c);return 0;}
```

It will display "f" because execute order is *right to left*.

Copy/paste 

`printf "#include <stdio.h>\nchar c='a';int f(){c='f';return 6;}int g(){c='f';return 7;}void h(int x,int y){}int main(){h(f(),g());printf(\"%%c\",c);return 0;}\n" | gcc -x c - & ./a.out`.

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