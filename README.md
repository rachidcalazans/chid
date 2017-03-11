# Chid
Chid is an assistant to help your day-to-day life. It can be used in some 
installations, news, configurations, workstations and more.

![](http://g.recordit.co/T2qyg12gE7.gif)

## Installation

After clone this repository and enter in the project directory run:

    $ gem install bundler # If you do not has installed

    $ bundle install

    $ rake init

That command will configura the Chid app.  
Will append in your .bashrc an alias as **chid**. That alias will be able to run:

    $ chid # To initialize the Chid app.

Or run rake tasks:

    $ chid help # Rake task called :help

To see all tasks with descriptions you can run:

    $ chid -T
    
Or:

    $ rake -T
    
Obs.: With the alias **chid** you can run the **chid app** from every directory.
