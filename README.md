# Bender Rodriguez

A chat-bot framework in haskell.

## Installing

Install cabal first.

Then, run the following commands:

```
$ git clone https://github.com/IITH-SBJoshi/haskell-4.git
$ cd haskell-4
$ cabal sandbox init
$ cabal install -j
```

To run:

```
$ cd .cabal-sandbox/bin
$ ./haskell4
```

In case Cabal does not work due to some reason, you might have to download all required modules manually,
and run: 

```
$ ./make.sh
$ ./Bender
```

## Writing Plugins

Take inspiration from the already given plugins.

A plugin takes data type has a name, a Text.Regex that it triggers on and an action that it performs if the regex is matched. The types of this function can be found in the documentation. 

Each plugin should export a `pExport` variable, which is of type PluginD

Plugins are assumed to do their own IO operations.