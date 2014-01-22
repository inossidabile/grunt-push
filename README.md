# grunt-push

> Pushes data to git branch.

## Getting Started
This plugin requires Grunt `~0.4.2`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-push --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-push');
```

## The "push" task

### Overview
In your project's Gruntfile, add a section named `push` to the data object passed into `grunt.initConfig()`.

```js
grunt.initConfig({
  push: {
    your_target: {
      // Target-specific file lists and/or options go here.
    },
  },
});
```

### Options

#### options.repository
Type: `String`
Default value: repository taken from the project itself.

Repository to clone from.

#### options.branch
Type: `String`

Branch to checkout and to push to.

#### options.directory
Type: `String`

Directory to perform at.