'use strict'
unless angular
	throw new Error('angular-module-tree: Missing Angular')
originalModule = angular.module

createNamespace = (name) ->
	if parent = name.split('.').slice(0,-1).join('.')
		return if parent is 'ng'
		try
			module = originalModule parent
			if module.requires.indexOf(name) < 0
				module.requires.push name
			module
		catch
			originalModule parent, [name]
		createNamespace parent

angular.module = (name, requires, configFn) ->
	if requires
		createNamespace name
		try
			for req in originalModule(name).requires
				if req.indexOf(name + '.') is 0 and requires.indexOf(req) < 0
					requires.push req
		originalModule arguments...
	else
		originalModule name
