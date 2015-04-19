## angular-module-tree

### How to

```javascript

angular.module('app',['aaa']);

angular.module('aaa.bbb')
    .controller('BbbCtrl',function () {});
    
angular.module('aaa.bbb.xxx')
    .controller('XxxCtrl',function () {});

```
