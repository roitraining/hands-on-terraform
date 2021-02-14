angular.module('appname', ['ngRoute'])
.controller('MainCtrl', function($scope) {
  $scope.welcomeMessage = "Welcome to Space Invaders";
  $scope.appName = "Space Invaders";
  
})
.config(function($routeProvider){
  $routeProvider
        .when('/',
            {
                controller: 'AliensController',
                templateUrl:'views/aliens.html'
            })
        .otherwise({ redirectTo: '/' });
});


