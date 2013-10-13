module.exports = (grunt) ->

  grunt.registerTask "git_rev_parse", "Git revision parse", ->

    property = grunt.config("git_rev_parse").prop
    done = @async()
    gitRevParseCommand =
      cmd: "git"
      args: "rev-parse --short HEAD".split(" ")

    writesGitRevision = (err, result) ->
      if err
        grunt.log.error(err)
        return done(false)

      grunt.config property, result.stdout
      grunt.log.write "#{gitRevParseCommand.cmd} #{gitRevParseCommand.args.join(" ")}: "
      grunt.log.ok result.stdout
      done()

    grunt.util.spawn(gitRevParseCommand, writesGitRevision)

