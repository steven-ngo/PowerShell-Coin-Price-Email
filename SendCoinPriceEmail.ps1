
# Define the list of cryptocurrencies   
$cryptos = @("bitcoin", "ethereum", "ripple", "binancecoin", "solana")

# Define the URL of the API endpoint
$url = "https://api.coingecko.com/api/v3/simple/price?ids=$($cryptos -join ",")&vs_currencies=usd"

# Make the API call
$response = Invoke-RestMethod -Uri $url -Method Get

$bitcoinPrice       =  $response.bitcoin.usd.ToString("N0")
$ethereumPrice      =  $response.ethereum.usd.ToString("N0")
$XRPPrice           =  $response.ripple.usd.ToString("N0")
$binancecoinPrice   =  $response.binancecoin.usd.ToString("N0")
$solanaPrice        =  $response.solana.usd.ToString("N0")



$body =  @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Top 5 Coin Prices</title>
</head>
<body>
  <h2>Top 5 Coin Prices</h2>
  <table border="1">
    <tr>
      <th>Cryptocurrency</th>
      <th>Price (USD)</th>
    </tr>
    <tr>
      <td>Bitcoin</td>
      <td>$bitcoinPrice</td>
    </tr>
    <tr>
      <td>Ethereum</td>
      <td>$ethereumPrice</td>
    </tr>
    <tr>
      <td>XRP</td>
      <td>$XRPPrice</td>
    </tr>
    <tr>
      <td>Binance Coin</td>
      <td>$binancecoinPrice</td>
    </tr>
    <tr>
      <td>Solana</td>
      <td>$solanaPrice</td>
    </tr>
  </table>
</body>
</html>

"@

$from = ''
$to = ''
$token = ''

$message = new-object System.Net.Mail.MailMessage

$message.From = $from
$message.To.Add($to)
$message.IsBodyHtml = $True
$message.Subject = "This is Coin Price Today"
$message.body = $body

$smtp = new-object Net.Mail.SmtpClient("smtp.gmail.com",587)

$smtp.EnableSsl = $true
$smtp.Credentials = New-Object System.Net.NetworkCredential($from, $token);

$smtp.Send($message)

