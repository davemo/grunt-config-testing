# global module:false

# require 'coffee-script'

module.exports = (grunt) ->

  grunt.loadTasks "tasks"

  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-uglify"

  # Project configuration.
  grunt.initConfig
    # Metadata.
    pkg: grunt.file.readJSON("package.json")
    banner: "/*! <%= pkg.title || pkg.name %> - sha: <%= sha %> */\n"

    # Task configuration.
    git_rev_parse:
      prop: "sha"

    concat:
      options:
        banner: "<%= banner %>"
        stripBanners: true

      bundle:
        files:
          "dist/app.js": ["vendor/**/*.js", "app/**/*.js"]

    uglify:
      options:
        banner: "<%= banner %>"

      dist:
        src: "dist/app.js"
        dest: "dist/app.min.js"

  # Default task.
  grunt.registerTask "default", ["git_rev_parse", "concat", "uglify"]
