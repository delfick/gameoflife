Implementation of gameoflife in coffeescript, using nodejs

Installation
============

After installing nodejs and npm

 * https://github.com/creationix/nvm
 * http://npmjs.org/
 
Run ``./install.sh`' to install all the necessary stuff that it uses.

It will install coffee-script globally (so that you have the ``cake`` command available) and everything else will be installed locally.

This includes coffeejade (includes changing one of the dependencies in it's package.json so that it can be installed) and all the dependencies specified in package.json.

Running
=======

After using ``./install.sh``, just run ``cake server``.

This will start watching the directory for any changes and ensure that all the coffeescript, jade and stylus files are compiled on change into the "compiled" folder.

It will also start a nodejs server that runs on port 8000, which will auto restart when server.coffee is changed.

Testing
=======

Any of the following commands will run the tests

 * ``cake test``
 * ``npm test``
 * ``./tests.coffee``
