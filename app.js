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

app.directive('quizbox',function(){
		return{
			restrict : 'E',
			templateUrl : 'views/quizbox.html'
		}
});

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