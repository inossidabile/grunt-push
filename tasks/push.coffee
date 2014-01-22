git = require 'gift'

module.exports = (grunt) ->

  normalizeRepository = (config, callback) ->
    if config? && config.length > 0
      callback(config)
    else
      repo = git(process.cwd())
      repo.config (err, config) ->
        grunt.fatal(err) if err
        callback(config.items["remote.#{config.remote}.url"])

  ensureConfig = (target) ->
    grunt.config.requires("push.#{target}")
    grunt.config.requires("push.#{target}.options")
    grunt.config.requires("push.#{target}.options.cwd")
    grunt.config.requires("push.#{target}.options.branch")

    config = grunt.config("push.#{target}.options")
    config.remote  ||= 'origin'
    config.message ||= "Updated at #{(new Date).toISOString()}"

    config

  actions =
    prepare: (done, target) ->
      config = ensureConfig(target)

      normalizeRepository config.repository, (url) ->
        git.clone url, config.cwd, (err) ->
          grunt.fatal(err) if err && err.code != 128
          git(config.cwd).checkout config.branch, (err) ->
            grunt.fatal(err) if err
            done()

    add: (done, target) ->
      config = ensureConfig(target)
      repo   = git(config.cwd)

      repo.add ['-A', '.'], (err) ->
        grunt.fatal(err) if err
        repo.commit config.message, (err) ->
          grunt.fatal(err) if err
          done()

    deliver: (done, target) ->
      config = ensureConfig(target)

      git(config.cwd).remote_push "-f #{config.remote} #{config.branch}", (err) ->
        grunt.fatal(err) if err
        done()

  for action, method of actions
    do (action, method) ->
      grunt.registerTask "push:#{action}", ->
        grunt.config.requires('push')

        done = @async()

        if @args[0]?
          method(done, @args[0].replace '.', '\\.')
        else
          for target in Object.keys(grunt.config.get 'push')
            method(done, target)