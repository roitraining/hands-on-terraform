angular.module('appname')
  .controller('AliensController', function($scope, $http, $interval, $document, $timeout) {

    $scope.pageName = "Aliens";

    var promise;
    var timeoutPromise
    var hero;
    var enemy;
    var missile;
    var bomb;
    var explosionImage;
    var heroImage;
    var enemyImage;
    var bombImage;
    var missileImage;
    var winningScore = 100;
    
    function init() {
      initializeGameObjects();
      resetScore();
      getImageURLs();
      updateImages();
    }
    
    // Initialize the game
    init();
    
    function resetScore(){
      $scope.score = 0;
      $scope.lives = 10;
    }
    function initializeGameObjects(){
      hero = {
        left: 10,
        direction: 1,
        speed: 15,
        image: "hero.svg"
      };
      enemy = {
        left: 25,
        direction: 1,
        speed: 5,
        image: "enemy.svg"
      };
      missile = {
        left: 0,
        top: -150,
        speed: 20,
        image: "missile.svg"
      };
      bomb = {
        left: 100,
        top: 500,
        speed: 5,
        rotation: 0,
        image: "bomb.svg",
        exploding:false
      };
      
      $scope.missiletop = missile.top + "px";
      $scope.missileleft = missile.left + "px";
      $scope.bombtop = bomb.top + "px";
      $scope.bomvleft = bomb.left + "px";
      $scope.bombrotation = bomb.rotation + "deg";
    }
    
    function getImageURLs(){
      $http.get(hero.image)
      .then(function(response) {
        heroImage = response.data;
        $('.hero').html(heroImage);
      });

    $http.get(enemy.image)
      .then(function(response) {
        enemyImage = response.data;
        $('.enemy').html(enemyImage);
      });

    $http.get(missile.image)
      .then(function(response) {
        missileImage = response.data;
        $('.missile').html(missileImage);
      });

    $http.get(bomb.image)
      .then(function(response) {
        bombImage = response.data;
        $('.bomb').html(bombImage);
      });
      
      $http.get('explosion.svg')
      .then(function(response) {
         explosionImage = response.data;
      });
    }
    
    function updateImages(){
      $('.hero').html(heroImage);
      $('.enemy').html(enemyImage);
      $('.missile').html(missileImage);
      $('.bomb').html(bombImage);
      
    }

    $scope.showMissile = function() {
      return (missile.top != -150);
    };

    $scope.startGame = function() {

      // MAKE SURE THE GAME ISN'T RUNNING ALREADY
      $interval.cancel(promise);
      
      // Make sure the Images are correct
      updateImages();
      resetScore();
      
      // Starts the loop to run the game. 
      // Promise object is used to stop the loop
      promise = $interval(function() {
        
        // Move the hero  
        $scope.heroleft = hero.left + "px";

        // Move the enemy
        if (enemy.left > 500 || enemy.left < 1) enemy.direction *= -1;
        enemy.left = enemy.left + (enemy.speed * enemy.direction);
        $scope.enemyleft = enemy.left + "px";

        // Move the missile
        if (missile.top >= -150) {
          missile.top = missile.top - missile.speed;
          if (missile.top <= -150) missile.top = -150;
          $scope.missiletop = missile.top + "px";
          $scope.missileleft = missile.left + "px";
        }

        // Move the Bomb
        if (bomb.top != 220 && ! bomb.exploding) {
          bomb.top = bomb.top + bomb.speed;
          if (bomb.top >= 220) bomb.top = 220;

          bomb.rotation = bomb.rotation + 6;
          if (bomb.rotation >= 360) bomb.rotation = 0;

          $scope.bombtop = bomb.top + "px";
          $scope.bombleft = bomb.left + "px";
          $scope.bombrotation = bomb.rotation + "deg"
  
        } 
        else if(bomb.exploding){
          //do nothing
        }
        else {
          bomb.rotation = 0;
          bomb.top = -100;
          bomb.left = enemy.left + 50;
        }

        // See if the bomb hits the hero
        if (!bomb.exploding && bomb.left > hero.left && bomb.left < hero.left + 100 && bomb.top > 180) {
          // It's a hit
          $scope.lives -= 1;
          
          bomb.exploding = true;
          $('.bomb').html(explosionImage);
          
          $timeout.cancel(timeoutPromise);  //does nothing, if timeout alrdy done
          timeoutPromise = $timeout(function(){   
            $('.bomb').html(explosionImage);//Set timeout
              bomb.top = 220;
              bomb.exploding = false;
              $('.bomb').html(bombImage);
          }, 200);
        
        }

        // See if the missile hits the bomb
        if (missile.left > bomb.left && missile.left < bomb.left + 50 && missile.top < bomb.top + 50 && missile.top > bomb.top) {
          // It's a hit
          $scope.score += 1;
          bomb.top = 220;
        }

        // See if the missile hits the enemy
        if (missile.left > enemy.left && missile.left < enemy.left + 100 && missile.top < -100 && missile.top != -150) {
          // It's a hit
          $scope.score += 10;
          missile.top = -150;
        }

      }, 25);
    }

    $scope.$watch("lives", function(newValue) {
      if (newValue <= 0) {
        $interval.cancel(promise);
        $('.hero').html(explosionImage);
      }
    });

    $scope.$watch("score", function(newValue) {
      if (newValue >= winningScore) {
        $interval.cancel(promise);
        $('.enemy').html(explosionImage);
      }
    });

    $scope.pauseGame = function() {
      $interval.cancel(promise);
    }

    $scope.resetGame = function() {
     init();
    }

    var handleKeyDown = function(event) {
      switch (event.keyCode) {
        case 37: // Left
          hero.left = hero.left - hero.speed;
          if (hero.left < 0) hero.left = 0;
          break;
        case 39: // Right
          hero.left = hero.left + hero.speed;
          if (hero.left > 500) hero.left = 500;
          break;
        case 32: // Space
          missile.left = hero.left + 50;
          missile.top = 200;
          break;
      }
      $scope.$apply();
    };

    $document.on('keydown', handleKeyDown);

    $scope.$on('$destroy', function() {
      $document.unbind('keydown', handleKeyDown);
    });



  })