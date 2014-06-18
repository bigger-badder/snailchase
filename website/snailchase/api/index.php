<?php

  $db = new SQLite3('highscores.db');

  if($db) {

    $query = "CREATE TABLE IF NOT EXISTS highscores (
        name VARCHAR(16) NOT NULL,
        score SMALLINT
      );";

    $db->exec($query);

  } else {

    echo '{ "error":"cannot connect to database" }';

  }

  function decodeHighscore($hSString) {

    return $hSString;
  }

  function saveHighscore($db, $name, $highscore) {

    $query = 'INSERT INTO highscores (name, score) VALUES ("' . $name . '", ' . decodeHighscore($highscore) . ' );';

    $db->exec($query);
  }

  function getHighscores($db) {

    $query = 'SELECT * FROM highscores ORDER BY score DESC LIMIT 5;';

    $results = $db->query($query);

    try { 

      $output = array();
 
      while($res = $results->fetchArray(SQLITE3_ASSOC)) {

        array_push($output, $res);

      }
 
      echo json_encode($output);

    } catch (Exception $e) {

      echo '{ "error":"an unknow error occured" }';
      
    }
  }

  function submitHighscore($db) {
    
    try {

      $req_body = json_decode(file_get_contents('php://input'));

      if($req_body->highscore && $req_body->name) {

        saveHighscore($db, $req_body->name, $req_body->highscore);

        echo '{ "success":true }';

      } else {

        echo '{ "error":"missing highscore and / or name" }';

      }

    } catch (Exception $e) {

      echo '{ "error":"an unknow error occured" }';

    }

  }

  switch($_SERVER['REQUEST_METHOD']) {

    case 'GET':
      getHighscores($db);
      break;
    case 'POST':
      submitHighscore($db);
      break;
    default:
      getHighscores($db);
  }

  
