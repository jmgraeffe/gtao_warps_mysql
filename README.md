# GTA Orange: Warps MySQL
This resource implements Minecraft-like Warps in GTA Orange. All warps will be stored in a MySQL database, with the goal to not hold a database connection all the time to save resources.

Also it uses a lot of GTA Orange libraries and functions like the MySQL lib, Player lib, UI lib and client scripts, so it should be very nice to learn scripting with it. Why not implement a little permission/admin system into it?

## Features / Commands

* `/warp [name]` - Warps you to a specific warp point.
* `/rwarp [playername] [warpname]` - Warps someone else to a specific warp point.
* `/warps` - Lists all existing warps.
* `/warpmenu` - Opens a fancy menu with all the warps, and if you click on a button, it warps to the given point.
* `/setwarp [name]` - Creates a new warp with the specified name and your current position.
* `/delwarp [name]` - Deletes the warp with the name x.
* `/relwarps` - Reloads the warps from the database. Useful for web services in later developments, but then you need to fire it regularly.

## Installation

1. Download the zip from Github.
2. Copy the contents (resource.yml, ...) to a folder named `warps_mysql` in your server's resource folder.
3. Add the resource to the config.yml.
4. Set up a database and import the sql dump named warps.sql.
5. Have fun!

### <3 [GTA-Orange.net](http://gta-orange.net)
