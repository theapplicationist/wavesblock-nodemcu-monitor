<?php

$nodeStatus = file_get_contents('http://localhost:6869/node/status');
$nodeStatus = json_decode($nodeStatus, TRUE);

$connectedPeers = file_get_contents('http://localhost:6869/peers/connected');
$connectedPeers = json_decode($connectedPeers, TRUE);
$connectedPeerCount = count($connectedPeers['peers']);

$nodeVersion = file_get_contents('http://localhost:6869/node/version');
$nodeVersion = json_decode($nodeVersion, TRUE);

$options = array(
  'http'=>array(
    'method'=>"GET",
    'header'=>"X-API-Key: YOUR_API_KEY"
  )
);

$context = stream_context_create($options);

$debugStatus = file_get_contents('http://localhost:6869/debug/info', false, $context);
$debugStatus = json_decode($debugStatus, TRUE);

$balance = file_get_contents('http://localhost:6869/debug/minerInfo', false, $context);
$balance = json_decode($balance, TRUE)[0];

$activation = file_get_contents('http://localhost:6869/activation/status', false, $context);
$activation = json_decode($activation, TRUE);

$votedFeatures = 'V: ';
foreach($activation['features'] as $feature) {
  if($feature['nodeStatus'] == 'VOTED') {
    $votedFeatures = $votedFeatures . $feature['id'];
  }
}

$cpu = sys_getloadavg();

function get_server_memory_usage(){

    $free = shell_exec('free');
    $free = (string)trim($free);
    $free_arr = explode("\n", $free);
    $mem = explode(" ", $free_arr[1]);
    $mem = array_filter($mem);
    $mem = array_merge($mem);
    $memory_usage = $mem[2]/$mem[1]*100;

    return $memory_usage;
}

$ram = get_server_memory_usage(); 
$disk = 100 - floor(100 * disk_free_space("/") / disk_total_space("/"));

$responseObj = (object) [
    'peers' => $connectedPeerCount,
    'status' => $nodeStatus, 
    'miningStatus' => $debugStatus['minerState'] == "mining blocks" ? "Mining" : "Not Mining", 
    'version' => $nodeVersion, 
    'balance' =>  intval($balance['miningBalance']/100000000),
    'cpu' => $cpu[0] * 100 . '%', 
    'ram' => intval($ram) . '%', 
    'disk' => $disk . '%', 
    'voting' => $votedFeatures
  
    
];

echo json_encode($responseObj);

?>



