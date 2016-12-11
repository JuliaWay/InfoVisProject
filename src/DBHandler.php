<?php

class DBHandler
{
    const TABLE = 'cars';
    var $connection;

    /**
     * @param $host String host to connect to.
     * @param $user String username to use with the connection. Make sure to grant all necessary privileges.
     * @param $password String password belonging to the username.
     * @param $db String name of the database.
     */
    function __construct($host,$user,$password,$db){

        $this->connection = mysqli_connect($host, $user, $password, $db);
        if(!$this->connection){
          echo "Connection Failed </br>";
        }
        if(!$this->ensureCarsTable()){
          echo "Table not found </br>";
        }
    }

    /**
     * makes sure that the cars table is present in the database
     * before any interaction occurs with it.
     */
    function ensureCarsTable(){
        if($this->connection){
          $query = "SELECT * FROM cars_data";
          return mysqli_query($this->connection, $query);
        }
        return false;
    }

    /**
     * @return array of all rows()
     */
    function fetchAll(){
        $cars = array();
        $query = "SELECT * FROM cars_data";
        $res = mysqli_query($this->connection,$query);
        while ($row = $res->fetch_assoc()) {
          $cars[] = $row;
        }
        return $cars;
    }

    /**
     * @return array of all rows grouped by weekday and hour()
     *right query
     *SELECT SUM(sub.CARS)/COUNT(sub.CARS) AS VALUE, sub.HOUR, sub.WEEKDAY FROM
     *(SELECT COUNT(`ID`) AS CARS, `DATE`, `HOUR`, `WEEKDAY` FROM `cars` GROUP BY `HOUR`, `DATE`)
     *sub GROUP BY sub.WEEKDAY, sub.HOUR
     *
     */
    function fetchCarsWeekdayHour(){
        $cars = array();
        /*$query = "SELECT COUNT(*) AS VALUE, HOUR, WEEKDAY
                      FROM cars_data
                      GROUP BY HOUR, WEEKDAY";*/
	$query = "select avg(number) as VALUE, HOUR, WEEKDAY from ( SELECT COUNT(*) AS number, minute, HOUR, DAY, month, date, weekday
                      FROM cars_data
                      GROUP BY minute, HOUR, DAY, month, date) temp group by hour, weekday";
        $res = mysqli_query($this->connection,$query);
        while ($row = $res->fetch_assoc()) {
          $cars[] = $row;
        }
        return $cars;
    }

    /*
    gets names of all the cars
    */
    function fetchAllCars(){
        $cars = array();
        $query = "SELECT NAME
                      FROM cars_data
                      GROUP BY NAME";
        $res = mysqli_query($this->connection,$query);
        while ($row = $res->fetch_row()) {
          $cars[] = $row;
        }
        return $cars;
    }

    /**
     * useful to sanitize data before trying to insert it into the database.
     * @param $string String to be escaped from malicious SQL statements
     */
    function sanitizeInput($string){
        $string = $this->connection->real_escape_string($string);
    }
}
