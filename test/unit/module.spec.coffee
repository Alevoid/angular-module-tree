'use strict'

describe 'Angular module', ->
	it 'should create module', ->
		expect(angular.module 'a', []).toBe angular.module 'a'
		expect(angular.module 'b', ['x','y','z']).toBe angular.module 'b'


	it 'should create parent modules', ->
		angular.module 'c.a.a', []
		angular.module 'c.a.b', []
		expect(angular.module 'c' ).toBeDefined()
		expect(angular.module('c').requires).toEqual jasmine.arrayContaining ['c.a']
		expect(angular.module 'c.a').toBeDefined()
		expect(angular.module('c.a').requires).toEqual jasmine.arrayContaining ['c.a.a', 'c.a.b']
		expect(angular.module 'c.a.a').toBeDefined()
		expect(angular.module 'c.a.b').toBeDefined()

	it 'should allow module redefinition', ->
		angular.module 'd', ['x']
		angular.module 'd.a.b', []
		angular.module 'd', ['y']
		expect(angular.module 'd.a.b').toBeDefined()
		expect(angular.module('d').requires).toEqual jasmine.arrayContaining ['y', 'd.a']
		expect(angular.module('d').requires).not.toEqual jasmine.arrayContaining ['x']
		expect(angular.module('d.a').requires).toEqual jasmine.arrayContaining ['d.a.b']

		angular.module 'f.a', []
		angular.module 'f.b.a', []
		expect(angular.module 'f', []).not.toBe(angular.module 'f', [])
		expect(angular.module('f').requires).toEqual jasmine.arrayContaining ['f.b','f.a']

	it 'should ignore "ng" prefix', ->
		angular.module 'ng.foo.bar', []
		expect(angular.module 'ng.foo.bar').toBeDefined()
		expect(angular.module 'ng.foo').toBeDefined()
		expect(angular.module('ng.foo').requires).toEqual jasmine.arrayContaining ['ng.foo.bar']
		expect(angular.module('ng').requires).not.toEqual jasmine.arrayContaining ['ng.foo']

