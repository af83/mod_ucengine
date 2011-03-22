# Ejabberd => U.C.Engine

Experimental gateway between ejabberd and U.C.Engine for demonstration purpose.

It send MUC messages to U.C.Engine.

## Install ?

You should't try to install it, but in case of:

1. Checkout ejabberd-modules with subversion
2. git clone git://github.com/AF83/mod_ucengine.git
3. cd mod_ucengine
4. mkdir ebin
5. ./build.sh
6. copy ebin dir in ejabberd ebin dir.
7. Add to ejabberd config with good value
   {mod_ucengine, [{host, "localhost"}, {port, 5300}, {uid, "ejabberd"}, {credential, "secret"}]}

## License

(c) 2011 af83

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
