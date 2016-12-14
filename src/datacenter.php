<?php
/**
 * Created by PhpStorm.
 * User: Tobi
 * Date: 30/11/2016
 * Time: 16:46
 */


header('Content-type: application/json');
header("Access-Control-Allow-Method: *");

// WARNING: Access-Control-Allow-Origin: * is dangerous
// Do not use this line on public servers.
header("Access-Control-Allow-Origin: *");


error_reporting(E_ERROR);


  // this file holds the connection info in $host, $user, $password, $db;
  include_once('connectionInfo.php');

  // the DBHandler takes care of all the direct database interaction.
  require_once('DBHandler.php');

  $dbHandler = new DBHandler($host,$user,$password,$db);

  $failureObj = array(
      'status' => 'error',
      'code' => 500,
      'message' => 'load parameter not set. ',
      'reasons' => array('The page is not formatted with valid XML', 'The page is not available', 'The URL is invalid')
  );

  // now, let's see whether the user has submitted the form

/*
  chart data
*/
  if(isset($_GET['data'])){
      $data = $dbHandler->fetchCarsWeekdayHour();
      if($data){
          $fp = fopen('data.json', 'w');
          fwrite($fp, json_encode($data));
          fclose($fp);
          $response = ['data'];
          echo json_encode($response);
        }else{
          echo json_encode('Bad "fetchCarsWeekdayHour" query...');
        }

  }/*
    chart data per car
  */
    else if(isset($_GET['name'])){
        $data = $dbHandler->fetchDataPerCar($_GET['name']);
        if($data){
            $fp = fopen('data.json', 'w');
            fwrite($fp, json_encode($data));
            fclose($fp);
            $response = ['data'];
            echo json_encode($response);
          }else{
            echo json_encode('Bad "fetchCarsWeekdayHour" query...');
          }

    /*
     cars data
    */
    }else if(isset($_GET['cars'])){
    $cars = $dbHandler->fetchAllCars();
    if($cars){
      $all= array('Alle');
      foreach($cars as $car){
        $all = array_merge($all,$car);
      }
      $cars = array('cars' => $all);
        echo json_encode($cars);
      }else{
        echo json_encode('Bad "fetchAllCars" query...');
      }
  } else {
      echo json_encode($failureObj);
  }

?>
