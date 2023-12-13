<template>
  <header>
    <div class="container">
      <div class="logo">
        <a href="/">ZK Sync Era zkBitcoin Staking Ethereum DAPP</a>
      </div>
      <nav>
        <ul><li>LINKS TO zkBTC Dapps Below
          <li><a style="font-size: 25px;" href="https://testnet.zkbitcoin.org/dapp_auctions/">zkBTC Auctions DAPP</a>
</li>
          <li><a style="font-size: 25px;" href="https://testnet.zkbitcoin.org/dapp_staking_eth/">zkBTC Staking Ethereum DAPP</a></li>
          <li><a style="font-size: 25px;" href="https://testnet.zkbitcoin.org/dapp_staking_0xbtc/">zkBTC Staking 0xBitcoin DAPP</a></li>
        </ul>
      </nav>
    </div>
  </header>
</template>

<script>
export default {
  name: 'Header',
};
</script>

<style scoped>
header {
  background-color: #333;
  color: #fff;
  padding: 20px 0;
}

.container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  max-width: 960px;
  margin: 0 auto;
}

.logo a {
  font-size: 24px;
  font-weight: bold;
  color: #fff;
  text-decoration: none;
}

nav ul {
  display: flex;
  list-style: none;
  margin: 0;
  padding: 0;
}

nav li {
  margin-right: 20px;
}

nav li:last-child {
  margin-right: 0;
}

nav a {
  font-size: 16px;
  color: #fff;
  text-decoration: none;
}
</style>
