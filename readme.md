# nimview Svelte Todo-list Application

This is the source code for the demo app on the Nimview page.
To prepare the build, install [nim](https://nim-lang.org/install.html) >= 1.4.8 and run
- nimble install nimview
- npm install

Then to build a release 
- npm run build
- nim c -r --app:gui -d:release src/App.nim

Or during development
- npm run dev
- nim c -r -d:debug src/App.nim
- open browser 