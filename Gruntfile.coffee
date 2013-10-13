module.exports = (grunt) ->

  grunt.loadTasks "tasks"

  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-parallel"

  # Project configuration.

  config =
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

    parallel:
      minification:
        tasks: [
          { grunt: true, args: ['uglify:dist'] }
          { grunt: true, args: ['uglify:alternate'] }
        ]

    uglify:
      options:
        banner: "<%= banner %>"

      dist:
        src: "dist/app.js"
        dest: "dist/app.min.js"

      alternate:
        files:
          "dist/other-app.js" : [
            "dist/app.js"
            "other-things/**/*.js"
          ]

  grunt.initConfig(config)
  grunt.registerTask "default", ["git_rev_parse", "concat", "uglify"]
