gulp = require 'gulp'
coffee = require 'gulp-coffee'
sourcemaps = require 'gulp-sourcemaps'
plumber = require 'gulp-plumber'
karma = require 'gulp-karma'


gulp.task 'coffee', ->
	gulp.src 'src/**/*.coffee'
	.pipe plumber()
	.pipe sourcemaps.init()
	.pipe coffee bare: true
	.pipe sourcemaps.write 'maps'
	.pipe gulp.dest 'dist'

gulp.task 'test', ->
	gulp.src 'dummy'
	.pipe plumber()
	.pipe karma
		configFile: 'test/karma.conf.coffee'
		action: 'run'

gulp.task 'watch', ->
	gulp.watch '**/*.coffee', ['test', 'coffee']

gulp.task 'default', ['coffee']
