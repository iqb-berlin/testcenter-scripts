<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Testcenter Status</title>
  <style>
    * {
      font-family: sans-serif;
      font-size: large;
    }
    td {
      padding: 10px;
      border: 1px solid silver;
    }
    a, a:visited, .tc_nice {
      color: black;
      text-shadow: 1px 1px 10px #fff, 1px 1px 10px #ccc;
    }
  </style>
</head>
<body>
  <h1>Übersicht Testcenter-Instanzen</h1>
  <table>
    <thead>
      <tr>
        <td>Url</td>
        <td>Title</td>
        <td>Version</td>
      </tr>
    </thead>
    <tbody id="instances">
      <?php
          error_reporting(E_ALL);
          ini_set('display_errors', 1);

          function fetch(string $url): object {
            $curl = curl_init();
            curl_setopt_array($curl, [
              CURLOPT_URL => $url,
              CURLOPT_RETURNTRANSFER => true,
              CURLOPT_ENCODING => "",
              CURLOPT_MAXREDIRS => 10,
              CURLOPT_TIMEOUT => 5,
              CURLOPT_FOLLOWLOCATION => true,
              CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
              CURLOPT_HEADER => false,
              CURLOPT_FAILONERROR => false, // allows to read body on error
              CURLOPT_SSL_VERIFYHOST => 0,
              CURLOPT_SSL_VERIFYPEER => false,
              CURLOPT_VERBOSE => 1
            ]);

            $curlResponse = curl_exec($curl);
            $errorCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);

            if (($errorCode === 0) or ($curlResponse === false)) {
              return (object) ['error' => "not available", 'code' => $errorCode];
            }

            if ($errorCode >= 400) {
              return (object) ['error' => $curlResponse, 'code' => $errorCode];
            }

            return json_decode($curlResponse);
          }

          function splitVersion(string $versionString): array {
            $objectVersionParts = preg_split("/[.-]/", $versionString);

            return [
              (int) $objectVersionParts[0],
              isset($objectVersionParts[1]) ? (int) $objectVersionParts[1] : 0,
              isset($objectVersionParts[2]) ? (int) $objectVersionParts[2] : 0,
              $objectVersionParts[3] ?? ""
            ];
          }

          function colorVersion(int $a, int $b, int $c): string {
            $rgb = [0, 0, 0];
            $rgb[($a + 2) % 3] = ($b * 100) % 256;
            $rgb[$a % 3] = ($c * 30) % 256;
            return "rgba($rgb[0], $rgb[1], $rgb[2], 0.6)";
          }



          $tcInstances = [
            'https://iqb-testcenter.de',
            'https://iqb-testcenter2.de',
            'https://iqb-testcenter3.de',
            'https://iqb-testcenter4.de',
            'https://www.iqb-fragebogen.de',
            'https://testcenter.iqb.hu-berlin.de'
          ];
          foreach ($tcInstances as $url) {
            echo "";
            $r = fetch("$url/api/system/config");
            if (!isset($r->error)) {
              $title = $r->appConfig->appTitle;
              $version = $r->version;
              $versionParts = splitVersion($r->version);
              $color = colorVersion(...$versionParts);
              $css = $r->appConfig->backgroundBody;
              echo "<tr class='ok'>";
              echo "<td style='background: $css'><a href='$url'>$url</a></td>";
              echo "<td class='tc_nice' style='background: $css'>$title</td>";
              echo "<td style='background: $color'>$version</td>";
              echo "</tr>";
            } else {
              echo "<tr class='error'><td><a href='$url'>$url</a></td><td>Error ($r->code)</td><td>$r->error</td></tr>";
            }

            echo "</tr>";
          }
      ?>
    </tbody>
  </table>
</body>