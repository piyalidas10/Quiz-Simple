# Quiz-Simple
Simple Quiz using AngularJS

he markup in index.html is straightforward. ngView is a directive that complements the $route service by including the rendered template of the current route into the main layout (index.html) file.

    <!doctype html>
    <html ng-app="quizOnline">
    <head>
    <meta charset="utf-8">
    <title>Online quiz using angularjs</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="style.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.4.7/angular.min.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.4.7/angular-route.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular-filter/0.5.4/angular-filter.js"></script>
    <script src="app.js"></script>
    </head>

    <body>

      <nav class="navbar navbar-default">
          <div class="container">
            <div class="navbar-header">
              <a class="navbar-brand" href="#">Online Quiz</a>
            </div>
          </div>
        </nav>

      <div ng-view></div>	


    </body>
    </html>
    
To make your applications ready for routing, you must include the AngularJS Route module:

    <scriptsrc="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular-route.js"></script>

Then you must add the ngRoute as a dependency in the application module::

    var app = angular.module("myApp", ["ngRoute"]);

Now your application has access to the route module, which provides the $routeProvider.

Use the $routeProvider to configure different routes in your application:

    var app =angular.module('quizOnline',['ngRoute','angular.filter']);

    app.config([ '$routeProvider', '$locationProvider',
        function($routeProvider, $locationProvider) {   
          $routeProvider
          .when('/:postName',{
              templateUrl : 'views/fullblogSec.html',
              controller: 'blogController'
          })
          .when('/',{
              templateUrl : 'views/home.html'
          })
          .otherwise({
            redirectTo : '/'
          });
          //$locationProvider.html5Mode(true); 
        } 
    ]);

Applications can only have one ng-view directive, and this will be the placeholder for all views provided by the route.

In app.js we defined a custom directive called quizbox. It looks like below:

    app.directive('quizbox',function(){
        return{
          restrict : 'E',
          templateUrl : 'views/quizbox.html'
        }
    });
    
By adding a restrict property with the value "E", the directive can only be invoked by Element name:

<quizbox></quizbox>
The markup in home.html

    <div class="container" ng-controller="mainCtrl">

        <div class="col-md-8 col-md-offset-2 col-sm-10 col-sm-offset-1 col-xs-12">
          <div class="quizContent clearfix">
                <form>
                    <quizbox></quizbox>

                    <div class="btn-block text-center">
                        <p style="color:#FFF">{{ans}}</p>
                        <button class="btn btn-default" ng-click="showResult(ans)">Submit</button>
                    </div>

                    <div class="col-xs-12 text-center showResult">
                        <h1>you got {{ correctCount }} out of {{questions_count.length}} right</h1>
                    </div>
                </form>	
             </div>   
         </div>

    </div>
Now we need some methods to start a quiz, get a question and check the answer. 

The markup in quizbox.html

	<div class="quizBox col-xs-12" ng-repeat="(key,value) in questions | groupBy: 'question_id'">
				<h4><span>{{key}}</span>
				 	<!--<div ng-repeat="qs in value">{{qs.question}}</div>-->
				 	<div ng-repeat="(key1,value1) in value | groupBy: 'question'">{{key1}}</div>
				</h4>
			
			<div class="quizOptions col-xs-12">
			

					<div class="options" ng-repeat="option in value">
						<label for="ans{{option.choice_id}}">
							<input type="radio" name="ques{{option.question_id}}" id="{{option.choice_id}}" value="{{option.choice_id}}" ng-model="ans[option.question_id]">{{option.choice}}
						</label>
					</div>					
				
				
			</div>	
			
		</div>
    
The showResult(ans) method needs to send the selected options by user.  'ans' module holds the all selected options.

The code in controller:

      app.controller('mainCtrl',function($scope, $http){

      //full questions with multiple options
      $http({
            method:'GET', 
            url:'JSON/questions.php'
          })
          .success(function(response){
            $scope.questions = response;
            console.log($scope.questions);
          });

      //view from questions
      $http({
            method:'GET', 
            url:'JSON/questions_count.php'
          })
          .success(function(response){
            $scope.questions_count = response;
            console.log($scope.questions_count);
          });

      //pick correct answers from question_choices
      $http({
            method:'GET', 
            url:'JSON/correctans.php'
          })
          .success(function(response){
            $scope.correct_ans = response;
            console.log($scope.correct_ans);
          });

      $scope.ans = {};
      $scope.answers = [];
        $scope.correctCount = 0;

      $scope.showResult = function(ans) {
        $scope.correctCount = 0;
          var qLength = $scope.questions_count.length;

        for(var i=1;i<=qLength;i++){
          $scope.answers.push(ans[i]);
        }
        console.log($scope.answers);

        for(var j=0;j<$scope.answers.length;j++){
          var userchoice = $scope.correct_ans[j].choice_id;
          if ($scope.answers[j] === userchoice)
            {
              $scope.correctCount++;
            }
        }

        console.log($scope.correctCount);


      }	
        });
    
    
I push all selected ans by user in $scope.ans array.  At first have counted the questions length using $scope.questions_count.length.

    for(var i=1;i<=qLength;i++){
          $scope.answers.push(ans[i]);
    }
        
$scope.correct_ans holds the correct answer's value. Using for loop, compare the correct answer from database with the user's choice. If selected choice is correct then $scope.correctCount increase value by 1. $scope.correctCount is act like counter.

    for(var j=0;j<$scope.answers.length;j++){
          var userchoice = $scope.correct_ans[j].choice_id;
          if ($scope.answers[j] === userchoice)
            {
              $scope.correctCount++;
            }
        }
        

