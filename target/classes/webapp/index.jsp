<%--
  Created by IntelliJ IDEA.
  User: realibi
  Date: 02-Jan-21
  Time: 4:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Text search</title>
    <script
            src="https://code.jquery.com/jquery-3.5.1.min.js"
            integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Anton&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Oswald&display=swap" rel="stylesheet">
</head>
<body>

<style>
    body{
        background-color: #2a394f;
        color: white;
    }
    .header-text{
        font-family: 'Anton', sans-serif;
    }
    .block-header-text{
        font-family: 'Oswald', sans-serif;
    }
</style>

<div class="container">
    <div class="row">
        <div class="col-12" style="width: 100%; margin-top: 30px; text-align: center">
            <h2 class="header-text">Search text occurrences in files</h2>
        </div>
    </div>

    <div class="row" style="margin-top: 30px;">
        <div class="col-12" style="width: 100%;">
            <div class="row">
                <div class="col-10">
                    <input type="text" id="searchTextInput" style="height: 100%; width: 100%; vertical-align: middle; border: 1px solid #212121; border-radius: .25rem;">
                </div>
                <div class="col-2">
                    <button id="startSearchBtn" type="button" onclick="searchText()" class="btn btn-outline-warning" style="width: 100%">Search</button>
                    <button hidden id="stopSearchBtn" type="button" onclick="stopSearch()" class="btn btn-outline-danger" style="width: 100%">Stop</button>
                </div>
            </div>
        </div>
    </div>

    <div class="row" style="margin-top: 30px;">
        <div class="col-6" style="width: 100%">
            <div class="folderFiles" style="background-color: #3d619c; padding: 20px; border: 1px solid transparent; border-radius: .25em">
                <h3 class='block-header-text'>Files in folder:</h3>
            </div>
        </div>
        <div class="col-6" style="width: 100%" >
            <div class="results" style="background-color: #42506b; padding: 20px; border: 1px solid transparent; border-radius: .25em"></div>
        </div>
    </div>
</div>

<script>
    const startSearchButton = $("#startSearchBtn");
    const stopSearchButton = $("#stopSearchButton");

    $(document).ready(function(){
        stopSearchButton.hidden = true;
        loadFiles();
    });

    const clearResultsBlock = () => {
        $(".results").empty()
    }

    const loadFiles = () => {
        $.ajax({
            type: "GET",
            url: "<%=request.getContextPath() %>/api/files",
            success: function(result){
                console.log(result);
                for(let i = 0; i < result.length; i++) {
                    $(".folderFiles").append(
                        "<p>" + result[i] + "</p>"
                    );
                }
            }
        });
    }

    const searchText = () => {
        clearResultsBlock();
        startSearchButton.hidden = true;
        stopSearchButton.hidden = false;

        const searchText = $("#searchTextInput").val();

        $.ajax({
            type: "GET",
            url: "<%=request.getContextPath() %>/api/files/search/" + searchText,
            success: function(result){
                console.log(result);
                $(".results").append("<h3 class='block-header-text'>Results:</h3>");
                for(let i = 0; i < result.length; i++){
                    Object.keys(result[i]).forEach(function(key) {
                        const value = result[i][key];
                        $(".results").append(
                            "<p>" + key + ": " + value.toString() + "</p>"
                        );
                    });
                }
                startSearchButton.hidden = false;
                stopSearchButton.hidden = true;
            }
        });
    }
</script>

</body>
</html>
