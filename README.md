# NetLinx Source File Utility

A toolset for working with NetLinx `.src` source code packages.

[![Gem Version](https://badge.fury.io/rb/netlinx-src.svg)](http://badge.fury.io/rb/netlinx-src)


## Installation

Install Ruby `>= 2.0.0` for [Windows](http://rubyinstaller.org/downloads/) or [Linux](https://github.com/sstephenson/rbenv#basic-github-checkout).

	gem install netlinx-src


## Rake Tasks

Commands are executed with

	rake [task]

#### pack

Create a NetLinx `.src` source code package, excluding any files specified in `.srcignore`.
This command will look for a `.apw` NetLinx Workspace file in the directory `rake pack` was executed in to determine the file name.

#### unpack

Unpack a NetLinx `.src` file into a directory named `extracted`.

#### srcignore

Generate a default `.srcignore` file in the working directory.

#### mkzip

Create a copy of the `.src` file and append `.zip` so it can be opened in any standard file compression utility.

#### rmzip

Delete any `.src.zip` files in the working directory.


## Rakefile

To add the default Rake tasks to a project's `Rakefile`:

```ruby
require 'netlinx/rake/src'
```
