# BieberStreamer
A live stream dedicated to the wiley Canadian.  See what all the fooss is aboot.


# About
Built as an exercise in Rails4 websockets, threading, Twitter streaming, and Redis Pub/Sub.  What better practice than by using the heavy traffic of #bieber? 

A Twitter Streaming API worker runs in a separate thread inside the Rack middleware and publishes serialized tweets via Redis.  Any client may make a connection using the EventSource class to an endpoint on the app server.A simple messaging broker handles the pub-sub messaging between the two.  


# Install
First update the environment.yml with your app info. Then run:
  
    $ bundle install
    $ RACK_ENV=development rackup config.ru -p 3000

Visit http://localhost:3000 in your browser and admire that live, pop-sensational feed.



# LICENSE
The MIT License (MIT)

Copyright (c) 2014 Alex Ehrnschwender

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
