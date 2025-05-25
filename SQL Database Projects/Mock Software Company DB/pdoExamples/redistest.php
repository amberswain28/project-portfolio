<?php

$redis = new Redis();
//Connecting to Redis
$redis->connect('localhost', 6379);

if ($redis->ping()) {
 echo "PONG";
}

$redis->set("foo", "bar");
var_dump($redis->get("foo"));
?>
