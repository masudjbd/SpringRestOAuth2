<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initialscale=1.0">
<title>Employee</title>
<link
	href="${pageContext.request.contextPath}/resource/css/bootstrap.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resource/css/bootstrap-responsive.css"
	rel="stylesheet" />

<link
	href="${pageContext.request.contextPath}/resource/css/datepicker.css"
	rel="stylesheet" />

<script
	src="${pageContext.request.contextPath}/resource/js/angular.min.js"></script>
<style type="text/css">
body {
	padding-top: 60px;
	padding-bottom: 40px;
}
</style>


<script>
	var myApp = angular.module("myApp", []);

	myApp.controller("myController", [
			'$scope',
			'$filter',
			'$http',
			function($scope, $filter, $http, $location) {
				$scope.name = "Masud";
				$http.get("${pageContext.request.contextPath}/employee/list")
						.success(function(result) {

							$scope.employees = result;
						}).error(function(response) {
							console.log(response);
							if (response.error === "unauthorized") {
								$scope.message = response.error_description;

							}
						});
				
				
				$scope.oauth = function(){
					if($scope.username==null){
						alert("username required");
					}

					if($scope.client_id==null){
						alert("client id required");
					}
					
					if($scope.password==null){
						alert("password required");
					}
					
					if($scope.grant_type==null){
						alert("grant_type required");
					}
					
					if($scope.username != null && $scope.client_id != null && $scope.password !=null && $scope.grant_type != null){

						$http.get("${pageContext.request.contextPath}/oauth/token?grant_type="+$scope.grant_type+"&client_id="+$scope.client_id + "&username="+$scope.username+"&password="+$scope.password)
						.success(function(result){
							console.log(result);
							
							$scope.refresh_token = result.refresh_token;
							
							$(".step1").addClass("hide");
							$(".step2").addClass("show");
							
							
							
						})
						.error(function(response){
							console.log(response);
						});
						
						
					}
					
				}
				
				$scope.getAccess = function(){
					
					 
					//make second loop
					$http.get("${pageContext.request.contextPath}/oauth/token?grant_type=refresh_token&client_id="+$scope.client_id + "&refresh_token="+$scope.refresh_token)
					.success(function(result){
						console.log(result);
						
						$scope.access_token = result.access_token;

						$(".step1").removeClass("show");
						$(".step2").removeClass("show");
						$(".step3").addClass("show");
						
						
					})
				}
				
				$scope.getResource = function(){
					
					 
				//make third loop
				$http.get("${pageContext.request.contextPath}/employee/list?access_token="+$scope.access_token)
				.success(function(result){
					 
					$scope.employees = result;
					
					$(".form-horizontal").hide("slow");
					
					window.location="${pageContext.request.contextPath}/test/list";
					
				});
				
				}
				
				if($scope.employees==null ){
					$(".form-horizontal").show("slow");
				}else{
					$(".form-horizontal").hide("slow");
				}
				 
				
			} ]);
	
	 
</script>



</head>
<body ng-app="myApp">


	<!-- Fixed navbar -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">Spring Rest OAuth2 with
					AngularJS</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">Home</a></li>
					<li><a href="#about">CCD</a></li>
					<li><a href="#contact">AHD</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Dropdown <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="#">List Employee</a></li>
							<li><a href="#">Add Employee</a></li>
							<li><a href="#">Something else here</a></li>
							<li role="separator" class="divider"></li>
							<li class="dropdown-header">Nav header</li>
							<li><a href="#">Separated link</a></li>
							<li><a href="#">One more separated link</a></li>
						</ul></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="../navbar/">Default</a></li>
					<li><a href="../navbar-static-top/">Static top</a></li>
					<li class="active"><a href="./">Fixed top <span
							class="sr-only">(current)</span></a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav>

	<div class="container" ng-controller="myController">

		<!-- Main component for a primary marketing message or call to action -->
		<div class="jumbotron">
			<h1>Employee List</h1>

			<div class="alert alert-warning" ng-if="message != null"
				ng-bind="message"></div>

			<form   class="form-horizontal">
				<div class="form-group step1">
					<label for="inputEmail3" class="col-sm-2 control-label">Username</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" ng-model="username" id="inputEmail3"
							placeholder="Username">
					</div>
				</div>
				
				<div class="form-group  step1">
					<label for="inputPassword3" class="col-sm-2 control-label">Password</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" ng-model="password" id="inputPassword3"
							placeholder="Password">
					</div>
				</div>

				<div class="form-group  step1">
					<label for="inputEmail3" class="col-sm-2 control-label">Client
						ID</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" ng-model="client_id" id="inputClientId"
							placeholder="Client ID">
					</div>
				</div>
				<div class="form-group  step1">
					<label for="inputEmail3" class="col-sm-2 control-label">Grant Type
						 </label>
					<div class="col-sm-10">
						 <select  class="form-control" ng-model="grant_type" >
						 	<option value="password">Password</option>
						 	<option value="refresh_token">Refresh Token</option>
						 	<option value="access_token">Access Token</option>
						 	
						 </select>
					</div>
				</div>
				
				<div class="alert alert-success" ng-cloak="" ng-if="refresh_token != null" ng-bind="refresh_token"></div>
				<div class="alert alert-success" ng-cloak="" ng-if="access_token != null" ng-bind="access_token"></div>
				
				<input type="hidden" ng-model="access_token" />
				
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" ng-click="oauth()" class="btn btn-info step1">Get Refresh Token (1)</button>
						<button type="submit" ng-click="getAccess()" class="btn hide btn-info step2">Get Access Token (2)</button>
						<button type="submit" ng-click="getResource()"  class="btn hide btn-info step3">Get Resource (3)</button>
						
					</div>
				</div>
			</form>


			<table ng-if="employees != null"  ng-cloak="" class="table table-striped">
				<thead>
					<tr>
						<th>SL</th>
						<th>Name</th>
						<th>Salary</th>
						<th>Action</th>
					</tr>
				</thead>

				<tbody>
					<tr ng-cloak="" ng-repeat="emp in employees">
						<td>{{ emp.id }}</td>
						<td>{{ emp.name }}</td>
						<td>{{ emp.salary }}</td>
						<td>
							<div class="btn-group" role="group">
								<button type="button" class="btn btn-info">
									<i class="glyphicon glyphicon-edit"></i> Edit
								</button>
								<button type="button" class="btn btn-danger">
									<i class="glyphicon glyphicon-trash"></i> Remove
								</button>
							</div>
						</td>
					</tr>
				</tbody>

			</table>


		</div>

	</div>
	<!-- /container -->



	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/js/bootstrap.min.js"></script>
</body>
</html>
