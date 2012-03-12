##hosting
Yet another apache/mysql/ftp webhost creation util

It enables you to create webhosting for customers really quick - but you'll propperly need to rewrite/modify some of the classes to fit your specific needs

Its written in CoffeeScript and is intented to be used with nodejs

I'm using it with ubuntu server and the standard configuration of the packages libapache2-mod-php5 (this package automaticly selects apache +php for installation), mysql-server and pure-ftpd-mysql

## Requirements

Nodejs and these npm packages

1. cli
2. coffee-script
3. mysql
4. node-ffi

Install with npm install package.

## Usage
Its a pretty straight forward command line util, start with hosting --help

![Screenshot](/fasmide/hosting/raw/master/example/screenshot.png)

## License
MIT License
Copyright (C) 2011 by Kristian Mide

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.