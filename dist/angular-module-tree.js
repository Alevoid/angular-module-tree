'use strict';
var createNamespace, originalModule;

if (!angular) {
  throw new Error('angular-module-tree: Missing Angular');
}

originalModule = angular.module;

createNamespace = function(name) {
  var module, parent;
  if (parent = name.split('.').slice(0, -1).join('.')) {
    try {
      module = originalModule(parent);
      if (module.requires.indexOf(name) < 0) {
        module.requires.push(name);
      }
      module;
    } catch (_error) {
      originalModule(parent, [name]);
    }
    return createNamespace(parent);
  }
};

angular.module = function(name, requires, configFn) {
  var i, len, ref, req;
  if (requires) {
    createNamespace(name);
    try {
      ref = originalModule(name).requires;
      for (i = 0, len = ref.length; i < len; i++) {
        req = ref[i];
        if (req.indexOf(name + '.') === 0 && requires.indexOf(req) < 0) {
          requires.push(req);
        }
      }
    } catch (_error) {}
    return originalModule.apply(null, arguments);
  } else {
    return originalModule(name);
  }
};

//# sourceMappingURL=maps/angular-module-tree.js.map