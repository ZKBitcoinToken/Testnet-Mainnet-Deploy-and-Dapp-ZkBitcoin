<template>
  <div id="app" v-if="!mainLoading">
    <Header />
    <h1>Download Testnet Miner for zkBitcoin @ <a href="https://github.com/Untouchable2k/zkBTC-Miner-Windows/tree/main">Click here to download Windows GPU and CPU Miner</a></h1>
    <h1>Get ZK Sync Testnet ETH @ <a href="https://faucet.triangleplatform.com/zksync/testnet?">CLICK HERE TO GO TO ETH FAUCET</a></h1>
    <h1>  Get Test LP Tokens to Test Staking Contract Here</h1>
<br>
        <button
          class="my-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="GetFreeLPTokens"
        >
          <span v-if="selectedToken && !txStatus">Get Test LP Tokens to test Staking Contract</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>
        <br>
    <h1> ZKBitcoin Dapp, v0.0.2</h1>
    <h2>Greeter says: {{ greeting }} 👋</h2>
 <h2>Your LP Tokens {{  MaxsliderValue2/1e18 }} LP Tokens </h2>
    <h2>Your Approved LP Tokens for Contract {{  ApprovedLPforContract / 1e18 }}% Approved LP Tokens</h2>
 
<label for="slider">Slider Value:</label>
<input
  type="range"
  id="slider"
  name="slider"
  min="0"
  :max="MaxsliderValue2/1e18"
  :step="MaxsliderValue2/1e20"
  v-model="sliderValue2"
/>

Adjust below to add a portion of the LP Tokens
<p>Selected slider value: {{ sliderValue2 }}</p>

      <button
          class="my-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="GetPermitAndStake"
        >
          <span v-if="shouldDisplayButton1 && selectedToken && !txStatus">Click this to permit Approve LP Tokens to the Staking <br>and Stake {{ sliderValue2 }} LP Tokens in <br>one transaction</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>
	<button
          class="my-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="ApproveLPtoStake"
        >
          <span v-if="shouldDisplayButton1 && selectedToken && !txStatus"> or Click this to approve {{ sliderValue2}} LP Tokens to the Staking Contract in<br> 2 transactions</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>
 <button
          class="my-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="AddPortionToStake"
        >
          <span v-if="!shouldDisplayButton1 && selectedToken && !txStatus">Step 2) Click this to deposit {{ sliderValue2}} LP Tokens to the Staking Contract</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>
    <h2>Your Balance of LP Tokens in Staking Contract {{ greetingStakeBalance/ 1e18 }} </h2>
    <h2>Total Balance of LP Tokens in Staking Contract {{ greetingStakeBalanceTotal / 1e18 }} </h2>
    <h2>Your Percent of the Pool {{ (greetingStakeBalance / greetingStakeBalanceTotal).toFixed(4) * 100 }}% </h2>
     <!--
    <h2>Your Reward {{  StakeReward }} zkBitcoin 👋</h2>
    <h2>Your Reward2 {{  StakeReward2 }} 0xBitcoin Tokens 👋</h2>
    <h2>Your Reward3 {{  StakeReward3 }} Ethereum Tokens 👋</h2> 
    -->
    <h2>Your Reward {{  (StakeReward/1e18).toFixed(8) }} zkBitcoin Tokens </h2>
    <h2>Your Reward2 {{   (StakeReward2/1e8).toFixed(8) }} 0xBitcoin Tokens </h2>
    <h2>Your Reward3 {{   (StakeReward3/1e18).toFixed(8) }} Ethereum Tokens </h2> 
 
    <button
          class="my-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="GetStakingRewardsOnly"
        >
          <span v-if="selectedToken && !txStatus">Claim Staking Rewards Only</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>
<br>
<br>
<label for="slider">Slider Value:</label>
<input
  type="range"
  id="slider"
  name="slider"
  min="0"
  :max="MaxsliderValue/1e18"
  :step="MaxsliderValue/1e20"
  v-model="sliderValue"
/>

Adjust below to remove a portion of the LP Tokens
<p>Selected slider value: {{ sliderValue }}</p>

         <button
          class="my-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="RemovePortionOfStake"
        >
          <span v-if="selectedToken && !txStatus">Click this to withdraw {{ sliderValue}} LP Tokens to Withdraw</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>

<br><br>

         <button
          class="my-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="ExitOnly"
        >
          <span v-if="selectedToken && !txStatus">Remove All LP Tokens Staked and Claim Rewards</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>


        <br>
        <h1>Auction Stuff</h1><br>
Input ETH to Send:
<input
  class="form-control"
  type="number"
  id="number2"
  v-model="number2"
  :placeholder="startEthToSend"
  :step="StepEthToSend"
  :max="maxQuantity"
  min=0
/>
<h1>Total ETH TO SEND Contract is: {{ message }} ETH</h1>

    <h2>Current Era: {{ currentEra }}</h2>
    <h2>Current Day: {{ greetingAuctionNumber }}</h2>
    <h2>Current Auction Total: {{ currentAuctionTotal / 1e18 }} Ethereum</h2>
    <h2>Current Auction Your Total: {{ UserTotal / 1e18 }} Ethereum</h2>
    <h2>Your Percent of Current Auction: {{ (!isNaN(UserTotal / currentAuctionTotal) ? (UserTotal / currentAuctionTotal * 100).toFixed(3) : 0) }}% </h2>
    <h2>Auction LENGTH: {{ (AuctionLengthInHours) }} Seconds</h2>
    <h2>Time Left in Auction: {{ (NextDayTime * 1.00).toFixed(3) }} Hours</h2>
    <h2>Auction % Remaining: {{((100* NextDayTime/(AuctionLengthInHours/(60*60)))).toFixed(2) }} %</h2>
    <h3>With your current bids you will recieve {{ (!isNaN(UserTotal / currentAuctionTotal) ? (UserTotal / currentAuctionTotal * 32768).toFixed(3) : 0) }} zkBitcoin, if no other bids are cast and the auction ends with a dust bid.</h3>
   <h3>If you bid {{number2}} Ethereum you will recieves {{ (( (parseFloat(number2)+parseFloat(UserTotal)/1e18)) / (parseFloat(currentAuctionTotal)/1e18+(parseFloat(number2))) * 32768).toFixed(5) }} zkBitcoin, if you bid {{ number2 }} Ethereum below and if the auction ends with a dust bid.</h3>
    <div>
      This a simple dApp, which you can choose the amount of ETH you want to bid at auction for ZKBitcoin Tokens.
    </div>
    Input ETH TO SEND: <input class="form-control" type="number" id="number2" v-model="number2" placeholder="0.01" :step="StepEthToSend" :max="maxQuantity" min=0>
    <h1>Total ETH TO SEND Contract is: {{ message }} ETH</h1>
  <!--  <p>Message2 is: {{ message21 }}</p>
    <button @click="SetMessage">Set message</button>

    <input type="text" id="name2" v-model="name2" placeholder="edit me" />
      -->
    <div class="main-box">
    <div class="balance" v-if="selectedToken">
        <p>
          Your ETH Balance: <span v-if="retreivingBalance">Loading...</span>
          <span v-else>{{ currentBalance }} {{ selectedToken.symbol }}</span>
        </p>
        <p>
          Expected fee: <span v-if="retreivingFee">Loading...</span>
          <span v-else>{{ currentFee }} {{ selectedToken.symbol }}</span>
          <button class="refresh-button" v-on:click="updateFee">Refresh</button>
        </p>
      </div>        
      <button
          class="my-button5"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="sendETHtoAuction"
        >
          <span v-if="selectedToken && !txStatus">Bid {{ number2 }} ETH on the Current Auction</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>
<h2>You can claim: {{ CLAIM_AMOUNT/1e18 }} zkBitcoin Tokens from auctions</h2>
      <button
          class="my-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="sendETHtoAuction2"
        >
          <span v-if="selectedToken && !txStatus">Claim zkBitcoin from Auctions</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>
     <!--
    <button @click="changeTokenETH">Change token</button>
      <div>
        Select token:
        <select v-model="selectedTokenAddress" v-on:change="changeToken">
          <option
            v-for="token in tokens"
            v-bind:value="token.address"
            v-bind:key="token.address"
          >
            {{ token.symbol }}
          </option>
        </select>
      </div>
      <div class="balance" v-if="selectedToken">
        <p>
          Balance: <span v-if="retreivingBalance">Loading...</span>
          <span v-else>{{ currentBalance }} {{ selectedToken.symbol }}</span>
        </p>
        <p>
          Expected fee: <span v-if="retreivingFee">Loading...</span>
          <span v-else>{{ currentFee }} {{ selectedToken.symbol }}</span>
          <button class="refresh-button" v-on:click="updateFee">Refresh</button>
        </p>
      </div>
      -->


      <br><br>Fun Command, change the greeting on top of webpage
      <div class="greeting-input">
        <input
          v-model="newGreeting"
          :disabled="!selectedToken || txStatus != 0"
          placeholder="Write new greeting here..."
        />

        <button
          class="change-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="changeGreeting"
        >
          <span v-if="selectedToken && !txStatus">Change greeting</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>

<br>
      </div>
    </div>
    <br><br>






<br><br>
<h1> Advanced Auctions - Bid in the future or on multiple auctions at once!!! </h1>


<br>

  <div>
    <label for="era">Era:</label>
    <input v-model="era" type="number" id="era" :min="this.currentEra" max="15" class="larger-input" />
<br>
    <label for="day">Starting Auction #:</label>
    <input v-model="StartingDay" type="number" id="StartingDay" :placeholder="greetingAuctionNumber" min="1" class="larger-input"/>
<br>
    <label for="amountOfDays">Number of auctions to bid on:</label>
    <input v-model="amountOfDays" type="number" id="amountOfDays" min="1" class="larger-input"/>
<br>
  </div>
 <h1>{{ headerText }}</h1>
<h3>Bid {{ (number2/amountOfDays) }} ETH on each of the {{ amountOfDays }} auctions in Era #{{era}} for a total of {{ number2 }} ETH</h3>
<h3>The current Era # is {{ currentEra }} and the current Auction # is {{ greetingAuctionNumber }}</h3>
<input
  class="form-control"
  type="number"
  id="number2"
  v-model="number2"
  :placeholder="startEthToSend"
  :step="StepEthToSend"
  :max="maxQuantity"
  min=0
/>
<br>

    <button
          class="my-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="sendETHtoAuctionAdvanced"
        >
          <span v-if="selectedToken && !txStatus">Advanced Auction: {{headerText }}</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx... {{ headerText }}</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>
<br><br><br>













    Get Test LP Tokens to Test Staking Contract Here
<br>
        <button
          class="my-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="GetFreeLPTokens"
        >
          <span v-if="selectedToken && !txStatus">Get Test LP Tokens to test Staking Contract</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>
        <br>   <br><br>
    Get Test 0xBitcoin Token   to Test Staking Contract (by sending it some 0xBitcoin as a reward to test the payout)
<br>
        <button
          class="my-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="GetFreeLPTokens2"
        >
          <span v-if="selectedToken && !txStatus">Get Test 0xBitcoin Tokens to test sending Rewards Contract some to test rewards</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>
        <br>
      <h2>Staking New Period Starts at: {{ (StakingNewPeriod) }} seconds</h2>
      <h2>Current Timestamp Start at: {{ (CurrentTimestamp) }} seconds</h2>
    
        <br>Start New 40 Day Staking Period
        <button
          class="change-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee || parseFloat(StakingNewPeriod) > parseFloat(CurrentTimestamp)"
          v-on:click="initilizeNewStakingPeriod"
        >
          <span v-if="selectedToken && !txStatus">initilizeNewStakingPeriod</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>
        
<br><br>
These are admin functions below
<br><br>

        <button
          class="change-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="initilizeABAS"
        >
          <span v-if="selectedToken && !txStatus">ABAS initilize</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>
2nd

        <button
          class="change-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="initilizeAuction"
        >
          <span v-if="selectedToken && !txStatus">InitilizeAuction</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>
        <br>
<h1>Testing Permit</h1>
  <button
          class="my-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="GetPermitData"
        >
          <span v-if="selectedToken && !txStatus">Permit Data Test</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>
 <button
          class="my-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="Permit2"
        >
          <span v-if="selectedToken && !txStatus">Permit Test</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>

<br> <button
          class="my-button"
          :disabled="!selectedToken || txStatus != 0 || retreivingFee"
          v-on:click="GetPermitAndStake"
        >
          <span v-if="selectedToken && !txStatus">GetPermitAndStake</span>
          <span v-else-if="!selectedToken">Select token to pay fee first</span>
          <span v-else-if="txStatus == 1">Sending tx...</span>
          <span v-else-if="txStatus == 2"
            >Waiting until tx is committed...</span
          >
          <span v-else-if="txStatus == 3">Updating the page...</span>
          <span v-else-if="retreivingFee">Updating the fee...</span>
        </button>

<br>
        Contracts Listed below<br>
           <h2>zkBitcoin Contract: {{ (zkBTC_CONTRACT_ADDRESS2) }} </h2>
           <h2>Auctions Contract: {{ (AUCTION_CONTRACT_ADDRESS2) }} </h2>
           <h2>Staking Contract: {{ (Staking_zkBTC_CONTRACT_ADDRESS2) }} </h2>
           <h2>LP Contract: {{ (LP_CONTRACT_ADDRESS2) }} </h2>
           <h2>0xBitcoin Contract: {{ (ZeroxBitcoin_addresss2) }} </h2>
           <h2>Greeter Contract: {{ (GREETER_CONTRACT_ADDRESS2) }} </h2>
           <h3>Changes needed for mainnet, BLOCKS_PER_ADJUSTMENT needs to be changed from 16 to 1024</h3>
           <h3>Changes needed for mainnet, Auction length needs to be 25 days instead of 10 minutes</h3>
  

  </div>
  <div id="app" v-else>
    <div class="start-screen">
      <h1>Download Testnet Miner for zkBitcoin @ <a href="https://github.com/Untouchable2k/zkBTC-Miner-Windows/tree/main">Click here to download Windows GPU and CPU Miner</a></h1>
    
      <h1>Get ZK Sync Testnet ETH @ <a href="https://faucet.triangleplatform.com/zksync/testnet?">CLICK HERE TO GO TO ETH FAUCET</a></h1>
      <h1>Add ZK Sync Testnet to Your Metamask @  <a href="https://chainlist.org/chain/280">CLICK HERE TO ADD ZK SYNC TESTNET TO METAMASK</a></h1>
      <h1>Welcome to zkBitcoin Main dApp! Connect Metamask Below to enter</h1>
      <button v-on:click="connectMetamask">Connect Metamask</button> 
      <h1>Enter Discord @  <a href="https://discord.gg/FwXGz5PvjF">CLICK HERE TO GO TO DISCORD</a></h1>
     
    </div>
  </div>
</template>

  <script src="https://bundle.run/buffer@6.0.3"></script>
<script>
import Header from './Header.vue';

import Web3 from 'web3';
import {} from "zksync-web3";
import {} from "ethers";
import { Contract, Web3Provider, Provider } from "zksync-web3";
import { ethers , BigNumber, utils } from "ethers";

// eslint-disable-next-line
// eslint-disable-next-line
const GREETER_CONTRACT_ABI = require("./abi.json"); // TODO: Complete and import the ABI
const ABAS_CONTRACT_ABI = require("./abasabi.json")

const AUCTION_CONTRACT_ABI = require("./auctionabi.json");

const LP_CONTRACT_ABI = require("./LPFaucetToken.json");

const ETH_L1_ADDRESS = "0x0000000000000000000000000000000000000000";
const allowedTokens = require("./eth.json");
const Staking_AbAS_CONTRACT_ABI = require("./abasStakingABI.json");

const ZeroxBitcoin__CONTRACT_ABI = require("./LPFaucetToken.json");

const GREETER_CONTRACT_ADDRESS = "0xf5ADD0c27C4a15690f48F54E2D64cD72E204b6Ad"; // TODO: Add smart contract address

//INPUT HERE FOR DEPLOY DATAconst 
const LP_CONTRACT_ADDRESS = "0xB1564eeB99486fEaa31043D2Cb5A932c7E6776B0"
const Staking_zkBTC_CONTRACT_ADDRESS = "0x19f991Baf794225113A8Afb37DFc1208941f20e2"
const zkBTC_CONTRACT_ADDRESS = "0x01F92596915d104ebf5455C7FacE573fF696b31D"
const ZeroxBitcoin_addresss = "0xa0E1d12603EA3E256aA52AaB96271e97dC66ED7a"
const AUCTION_CONTRACT_ADDRESS = "0x244176bd632A0F2E12ceb07Cae4Fd251949dA904"


//SECOND STAKING ADDRESS
const Staking_0xBTC_zkBTC_CONTRACT_ADDRESS = "0xa0E1d12603EA3E256aA52AaB96271e97dC66ED7a"; 

const PERMIT_ADDRESS = LP_CONTRACT_ADDRESS;

const PERMIT_CONTRACT_ABI = require("./PermitABI.json");

console.log("PERMIT_addRESS", PERMIT_ADDRESS);
console.log("PERMIT_CONTRACT_ABI", PERMIT_CONTRACT_ABI);
console.log("TEST", AUCTION_CONTRACT_ABI);
console.log("22222", AUCTION_CONTRACT_ADDRESS);
console.log("TEST", ABAS_CONTRACT_ABI);
console.log("Staking_AbAS_CONTRACT_ABI", Staking_AbAS_CONTRACT_ABI);
console.log("Staking_zkBTC_CONTRACT_ADDRESS", Staking_zkBTC_CONTRACT_ADDRESS);
console.log("LP_CONTRACT_ADDRESS", LP_CONTRACT_ADDRESS);
console.log("LP_CONTRACT_ABI", LP_CONTRACT_ABI);
export default {
  name: "App",
  data() {
    return {
      StartingDay: 1,
      era: 1,
      amountOfDays: 1,
      Permit_nonce: 0,
      Permit_r: 0,
      Permit_s: 0,
      Permit_v: 0,
      name2: '',
      number2: 0.01,
      CLAIM_AMOUNT: 0.01,
      maxQuantity: 0,
      message: 0.01,
      newGreeting: "",
      AuctionLengthInHours: 24,
      greeting: "unknown",
      greetingStakeBalance: "staking",
      StakeReward: "staking",
      startEthToSend: 0.0013,
      StepEthToSend: 0.012,
      CurrentTimestamp: 123,
      StakeReward2: "staking",
      StakeReward3: "staking",
      ApprovedLPforContract: 0.0,
      greetingStakeBalanceTotal: "Total Supply",
      tokens: allowedTokens,
      showButton: true,
      selectedToken: null,
      StakingNewPeriod: 12345,
      selectedTokenAddress: "",
      sliderValue: 0.00,
      MaxsliderValue: 0.01,
      sliderStep: 0.01,
      sliderStep2: 0.01,
      sliderValue2: 0.00,
      MaxsliderValue2: 0.01,
      mainLoading: true,
      provider: null,
      signer: null,
      contract: null,
      canSubmit: true,
      // 0 stands for no status, i.e no tx has been sent
      // 1 stands for tx is beeing submitted to the operator
      // 2 stands for tx awaiting commit
      // 3 stands for updating the balance and greeting on the page
      txStatus: 0,
      retreivingFee: false,
      retreivingBalance: false,

      currentBalance: "",
      currentFee: "",
    };
  },created() {
    this.changeTokenETH(); // call your function here
  },
  components: {
    Header,
  },
  computed: {
    shouldDisplayButton1() {
      // Adjust this condition based on your requirement
      return this.sliderValue2 >= this.ApprovedLPforContract/1e18;

    },adjustedDays() {
      const totalDays = parseInt(this.amountOfDays) + parseInt(this.StartingDay);

      if (totalDays > 151) {
        return 151 - this.StartingDay;
      } else {
        return this.amountOfDays;
      }
    },adjustedDays2() {
      const totalDays = parseInt(this.amountOfDays) + parseInt(this.StartingDay);

      if (totalDays > 151) {
        return 151 - this.amountOfDays;
      } else {
        return this.StartingDay;
      }
    },headerText() {
      const startingDay = parseInt(this.StartingDay);
      const endDay = startingDay + parseInt(this.amountOfDays) - 1;

      if (parseInt(this.amountOfDays) == 1) {
        return `Send ${this.number2} ETH to bid for ${this.amountOfDays} auction. For Era #${this.era} Auction #${startingDay}`;
      } else {
        return `Send ${this.number2} ETH to bid for ${this.amountOfDays} auctions. For Era #${this.era} Auctions #${startingDay} - #${endDay}`;
      }
    },
  },
  watch: {
    name2(newValue){
      this.message21 = newValue;
      console.log("NEW VALUE", newValue);
    },
    number2(newValue){
      this.message = newValue;
      console.log("NEW VALUE2", newValue);
    },StartingDay: 'debouncedAdjustDays',
    amountOfDays: 'adjustDays',
era: 'adjustDays2',
  },
  methods: {
    SetMessage(){
      this.message21=this.message;
    },adjustDays() {
console.log("this.amountOfDays", this.amountOfDays);
console.log("this.StartingDay", this.StartingDay);
      const totalDays = parseInt(this.amountOfDays) + parseInt(this.StartingDay);

console.log("this.totalDays", totalDays);
      if (totalDays > 151) {
        this.amountOfDays = 151 - this.StartingDay;
      }
    },adjustDays2() {
console.log("this.amountOfDays", this.amountOfDays);
console.log("this.StartingDay", this.StartingDay);
      const totalDays = parseInt(this.amountOfDays) + parseInt(this.StartingDay);

console.log("this.totalDays", totalDays);
console.log("this.era", this.era);
      if(parseInt(this.era) > parseInt(15)){
            this.era = 15;
      }
      if(parseInt(this.currentEra) < parseInt(this.era)){
            if (totalDays > 151) {
                  this.StartingDay = 151 - this.amountOfDays;
            }
      }else if(parseInt(this.era) == parseInt(this.currentEra)){
            if (totalDays > 151) {
                  this.StartingDay = parseInt(this.greetingAuctionNumber);
                  this.amountOfDays = 151 - parseInt(this.StartingDay);
            }if(parseInt(this.StartingDay) < parseInt(this.greetingAuctionNumber)){
console.log("DOES THIS THING", this.StartingDay);
                  this.StartingDay = parseInt(this.greetingAuctionNumber);
                  this.amountOfDays = 151 - parseInt(this.greetingAuctionNumber);
console.log("DOES THIS THING2",  this.amountOfDays);
            }
	}else{
		this.era = this.currentEra;
	}
    },
    debouncedAdjustDays() {
      clearTimeout(this.debounceTimeout);

      // Debounce the adjustment for 500 milliseconds (adjust as needed)
      this.debounceTimeout = setTimeout(() => {
        this.adjustDays2();
      }, 500);
    },
    initializeProviderAndSigner() {
    this.provider = new Provider('https://mainnet.era.zksync.io');
    // Note that we still need to get the Metamask signer
    this.signer = (new Web3Provider(window.ethereum)).getSigner();
    this.contract = new Contract(
        GREETER_CONTRACT_ADDRESS,
        GREETER_CONTRACT_ABI,
        this.signer
    );
     this.contract2 = new Contract(
        AUCTION_CONTRACT_ADDRESS,
        AUCTION_CONTRACT_ABI,
        this.signer
    );

     this.contractABAS = new Contract(
        zkBTC_CONTRACT_ADDRESS,
        ABAS_CONTRACT_ABI,
        this.signer
    );

     this.contract0xBitcoinToken = new Contract(
        ZeroxBitcoin_addresss,
        ZeroxBitcoin__CONTRACT_ABI,
        this.signer
    );

     this.contractPermit = new Contract(
        PERMIT_ADDRESS,
        PERMIT_CONTRACT_ABI,
        this.signer
    );

     this.contractABASStaking = new Contract(
        Staking_zkBTC_CONTRACT_ADDRESS,
        Staking_AbAS_CONTRACT_ABI,
        this.signer
    );

     this.contractLPToken = new Contract(
        LP_CONTRACT_ADDRESS,
        LP_CONTRACT_ABI,
        this.signer
    );

    this.changeTokenETH();
},

    async getGreeting() {
     return await this.contract.greet();
    },

    async getApprovedLPforContract() {
      const userAddy = await this.getAddress();
console.log("userAddy", userAddy );
     return await this.contractLPToken.allowance(userAddy, Staking_zkBTC_CONTRACT_ADDRESS);
    },
    async getLPBalance() {
      const userAddy = await this.getAddress();
console.log("userAddy", userAddy );
     return await this.contractLPToken.balanceOf(userAddy);
    },
    async getStakeReward() {
      const userAddy = await this.getAddress();
console.log("userAddy", userAddy );
     return await this.contractABASStaking.earned(userAddy);
    },
    async getStakeReward2() {
      const userAddy = await this.getAddress();
console.log("userAddy", userAddy );
     return await this.contractABASStaking.earned2(userAddy);
    },
    async getStakeReward3() {
      const userAddy = await this.getAddress();
console.log("userAddy", userAddy );
     return await this.contractABASStaking.earned3(userAddy);
    },
    async getStakeNextRewardTime() {
      const userAddy = await this.getAddress();
console.log("userAddy", userAddy );

      const Finish = await this.contractABASStaking.periodFinish();
console.log("Finish", Finish );
     return await this.contractABASStaking.periodFinish();
    },
    async getGreetingStakeBalance() {
      const userAddy = await this.getAddress();
console.log("userAddy", userAddy );
     return await this.contractABASStaking.balanceOf(userAddy);
    },
    async getGreetingStakeBalanceTotal() {
      const userAddy = await this.getAddress();
console.log("userAddy", userAddy );
     return await this.contractABASStaking.totalSupply();
    },

    async getGreetingAuctionLength() {
     return await this.contract2.secondsPerDay();
    },

    async getGreetingAuctionNumber() {
     return await this.contract2.currentDay();
    },
    async getAuctionTotalZKBTC() {
      const userAddy = await this.getAddress()
     return await this.contract2.Check_Withdraw_Amt(userAddy);
    },
    async getUserTotal() {
      const userAddy = await this.getAddress();
console.log("userAddy", userAddy );
     var day = await this.contract2.currentDay();
     var era = await this.contract2.currentEra();
     return await this.contract2.mapEraDay_MemberUnits(era, day, userAddy);
    },
    async getGreetingAuctionERA() {
     return await this.contract2.currentEra();
    },
    async UpdateContracts() {
     var sec = await this.contract2.secondsPerDay();

     var time = await this.contract2.nextDayTime();
     console.log("TME ", time.toString());
        this.zkBTC_CONTRACT_ADDRESS2 = zkBTC_CONTRACT_ADDRESS;
        this.LP_CONTRACT_ADDRESS2 = LP_CONTRACT_ADDRESS;
        this.ZeroxBitcoin_addresss2 = ZeroxBitcoin_addresss
        this.AUCTION_CONTRACT_ADDRESS2 =AUCTION_CONTRACT_ADDRESS;
        this.Staking_zkBTC_CONTRACT_ADDRESS2 =Staking_zkBTC_CONTRACT_ADDRESS;
        this.GREETER_CONTRACT_ADDRESS2 =GREETER_CONTRACT_ADDRESS;
     const now = Date.now(); // Unix timestamp in milliseconds
     var currentTime = (now / 1000).toFixed(0);
     this.CurrentTimestamp = currentTime;
     var remainTime = time - currentTime;
     const percentageDay = remainTime / sec * 100;
console.log("TME2 ", (now / 1000).toFixed(0) );
     console.log("percentageDay ", percentageDay);
     return (remainTime / 3600).toFixed(2);
    },
    async getNextDayTime() {
     var sec = await this.contract2.secondsPerDay();

     var time = await this.contract2.nextDayTime();
     console.log("TME ", time.toString());
     const now = Date.now(); // Unix timestamp in milliseconds
     var currentTime = (now / 1000).toFixed(0);
     this.CurrentTimestamp = currentTime;
     var remainTime = time - currentTime;
     const percentageDay = remainTime / sec * 100;
console.log("TME2 ", (now / 1000).toFixed(0) );
     console.log("percentageDay ", percentageDay);
     return (remainTime / 3600).toFixed(2);
    },
    async getNextDay() {
     var sec = await this.contract2.secondsPerDay();

     var time = await this.contract2.nextDayTime();
     console.log("TME ", time.toString());
     const now = Date.now(); // Unix timestamp in milliseconds
     var currentTime = (now / 1000).toFixed(0);
     var remainTime = time - currentTime;
     const percentageDay = remainTime / sec * 100;
console.log("TME2 ", (now / 1000).toFixed(0) );
     console.log("percentageDay ", percentageDay);
     return remainTime;
    },
    async getAuctionTotal() {
     var day = await this.contract2.currentDay();
     var era = await this.contract2.currentEra();
     return await this.contract2.mapEraDay_Units(era, day);
    },
    async getDifficulty() {
     return await this.contractABAS.getMiningDifficulty();
    },
    async getFee() {
    // Getting the amount of gas (gas) needed for one tthis.contract2.mapEraDay_MemberUnits(era, day, userAddy)ransaction
    const feeInGas = await this.contract.estimateGas.setGreeting(this.newGreeting);
    // Getting the gas price per one erg. For now, it is the same for all tokens.
    const gasPriceInUnits = await this.provider.getGasPrice();
    const feeInGas2 = await this.contract2.estimateGas.burn0xForMember("0x0000000000000000000000000000000000000000", {value: (8)});
    console.log("FE2, ", feeInGas.toString());
    // To display the number of tokens in the human-readable format, we need to format them,
    // e.g. if feeInGas*gasPriceInUnits returns 500000000000000000 wei of ETH, we want to display 0.5 ETH the user
    return ethers.utils.formatUnits(feeInGas2.mul(gasPriceInUnits), this.selectedToken.decimals);
},

    async getBalance() {
    // Getting the balance for the signer in the selected token
    const balanceInUnits = await this.signer.getBalance(this.selectedToken.l2Address);
    const address = await this.signer.getAddress();
    console.log("TEST123123: ", address);
    const ret =  ethers.utils.formatUnits(balanceInUnits, this.selectedToken.decimals);
    this.maxQuantity = ret;
  if(this.number2 == 0.01){
  this.number2 = (ret / 100).toFixed(18);
  this.StepEthToSend = (ret / 100).toFixed(6);
  }
  this.startEthToSend = (ret / 100).toFixed(18);
    // To display the number of tokens in the human-readable format, we need to format them,
    // e.g. if balanceInUnits returns 500000000000000000 wei of ETH, we want to display 0.5 ETH the user
    return ret;
    },
    async getAddress() {
    // Getting the balance for the signer in the selected token
    return await this.signer.getAddress();
    },

    async getOverrides() {
      if (this.selectedToken.l1Address != ETH_L1_ADDRESS) {
        // TODO: Return data for the paymaster
      }

      return {};
    },
    async changeGreeting() {
    this.txStatus = 1;
    try {
        const txHandle = await this.contract.setGreeting(this.newGreeting, await this.getOverrides());

        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle.wait();
        this.txStatus = 3;

        // Update greeting
        this.greeting = await this.getGreeting();

        this.greetingStakeBalance = await this.getGreetingStakeBalance();
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
        this.LPBalance = await this.getLPBalance();
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingFee = true;
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},


    async GetFreeLPTokens() {
    this.txStatus = 1;
    try {
        const txHandle = await this.contractLPToken.withdrawToken("123123123123123123123");

        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle.wait();
        this.txStatus = 3;

        // Update greeting
        this.greeting = await this.getGreeting();

        this.greetingStakeBalance = await this.getGreetingStakeBalance();
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();
        this.retreivingFee = true;
        this.LPBalance = await this.getLPBalance();
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},



    async GetFreeLPTokens2() {
    this.txStatus = 1;
    try {
        const txHandle = await this.contract0xBitcoinToken.withdrawToken("54545454545");

        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle.wait();
        this.txStatus = 3;

        // Update greeting
        this.greeting = await this.getGreeting();

        this.greetingStakeBalance = await this.getGreetingStakeBalance();
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();
        this.retreivingFee = true;
        this.LPBalance = await this.getLPBalance();
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},


async GetPermitAndStake() {
  await this.GetPermitData();

        console.log("Permit input user: ", this.Permit_user);
        console.log("Permit input Permit_spender: ", this.Permit_spender);
        console.log("Permit input Permit_value: ", this.Permit_value);
        console.log("Permit input Permit_nonce: ", this.Permit_nonce);
        console.log("Permit input Permit_v: ", this.Permit_v);
        console.log("Permit input Permit_r: ", '0x'+this.Permit_r);
        console.log("Permit input Permit_s: ", '0x'+this.Permit_v);


      const userAddy = await this.getAddress()
console.log("222212", userAddy );
    this.txStatus = 1;
    try {
console.log("ffsdfsdfsd", this.sliderValue2 * 1.11  );
console.log("ffsdfsdfsd222212", (this.MaxsliderValue2/1e18) );
const amountToStake = (parseFloat(this.sliderValue2).toFixed(18)).toString(); // or parseFloat(this.sliderValue2)
var bigNumber = BigNumber.from(utils.parseUnits(amountToStake, 18));
console.log("Test nog", bigNumber.toString() );
if(this.sliderValue2 * 1.01 > (this.MaxsliderValue2/1e18)){
console.log("22221BOGIE2", userAddy );
const txHandle = await this.contractABASStaking.MAXstakePermit(this.Permit_user, this.Permit_value, this.Permit_deadline, this.Permit_v, '0x'+this.Permit_r, '0x'+this.Permit_s);

console.log("22221BOGIE2", userAddy );
        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle.wait();
}else{
  const txHandle2 = await this.contractABASStaking.stakePermit(bigNumber.toString(), this.Permit_user, this.Permit_value, this.Permit_deadline, this.Permit_v, '0x'+this.Permit_r, '0x'+this.Permit_s);

        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle2.wait();

}

        this.txStatus = 3;

     


        // Update greeting
        this.greeting = await this.getGreeting();

        this.greetingStakeBalance = await this.getGreetingStakeBalance();
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();
        this.retreivingFee = true;
        this.LPBalance = await this.getLPBalance();
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
        this.currentAuctionTotal = await this.getAuctionTotal();
        this.UserTotal = await this.getUserTotal();
        this.NextDayTime = await this.getNextDayTime();
        this.CLAIM_AMOUNT = await this.getAuctionTotalZKBTC();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},


    async Permit2() {
    this.txStatus = 1;

    try {

        console.log("Permit input user: ", this.Permit_user);
        console.log("Permit input Permit_spender: ", this.Permit_spender);
        console.log("Permit input Permit_value: ", this.Permit_value);
        console.log("Permit input Permit_deadline: ", this.Permit_deadline);
        console.log("Permit input Permit_deadline: ", this.Permit_nonce);
        console.log("Permit input Permit_v: ", this.Permit_v);
        console.log("Permit input Permit_r: ", '0x'+this.Permit_r);
        console.log("Permit input Permit_s: ", '0x'+this.Permit_s);

        const txHandle = await this.contractPermit.permit(this.Permit_user, this.Permit_spender, this.Permit_value, this.Permit_deadline, this.Permit_v, '0x'+this.Permit_r, '0x'+this.Permit_s  );

        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle.wait();
        this.txStatus = 3;

        // Update greeting
        this.greeting = await this.getGreeting();

        this.greetingStakeBalance = await this.getGreetingStakeBalance();
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();
        this.retreivingFee = true;
        this.LPBalance = await this.getLPBalance();
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},




    async GetPermitData() {
    this.txStatus = 1;
      var userAddy2 = await this.getAddress()
	const spender = Staking_zkBTC_CONTRACT_ADDRESS;
	var test = 123050000*10**18;
      console.log("PERMITY STUFF VALUE: ",test);
	const value =  parseFloat(test).toLocaleString().replace(/,/g, '');
      console.log("PERMITY STUFF VALUE: ",value);
	const deadline = 2661766724;

	var nonce =  parseInt(await this.contractPermit.nonces(userAddy2));   

	

	var namez =  await this.contractPermit.name();   

	
      console.log("PERMITY STUFF NONCE WORK: ",nonce);
      console.log("PERMITY STUFF NONCE Name: ",namez);
    try {
	const permit = { owner: userAddy2, spender, value, nonce, deadline };
      const Permit = [
        { name: "owner", type: "address" },
        { name: "spender", type: "address" },
        { name: "value", type: "uint256" },
        { name: "nonce", type: "uint256" },
        { name: "deadline", type: "uint256" },
      ];

      console.log("PERMITY STUFF: ",permit);
      console.log("PERMITY STUFF2: ",Permit);

 const domainName = namez; // put your token name 
    const domainVersion = "1"; // leave this to "280"
    const chainId = 280; // this is for the chain's ID. value is 1 for remix
    const contractAddressAA = PERMIT_ADDRESS; // Put the address here from remix

   const domainType = [
      { name: 'name', type: 'string' },
      { name: 'version', type: 'string' },
      { name: 'chainId', type: 'uint256' },
      { name: 'verifyingContract', type: 'address' },
    ];
    
    const domain = {
      name: domainName,
      version: domainVersion,
      verifyingContract: contractAddressAA,
      chainId
    };

const dataToSign = JSON.stringify({
          types: {
              EIP712Domain: domainType,
              Permit: Permit
          },
          domain: domain,
          primaryType: "Permit",
          message: permit
      });
  
    console.log('PERMITY Signature:', dataToSign);
	const signature = await window.ethereum.request({
  method: 'eth_signTypedData_v4',
  params: [userAddy2, dataToSign],
  from: userAddy2
});
	
	console.log("PERMITY SIGNATURE: ", signature);
	var sig = signature;
	const pureSig = sig.replace("0x", "");

      const r = pureSig.substring(0, 64);
      const s = pureSig.substring(64, 128);
      const v = parseInt(pureSig.substring(128, 130), 16);

console.log("PERMITY SIGNATURE r: ", r);
	console.log("PERMITY SIGNATURE s: ", s);
	console.log("PERMITY SIGNATURE v: ", v);


      this.Permit_nonce = nonce;
      this.Permit_r = r;
      this.Permit_s = s;
      this.Permit_v = v;
      this.Permit_user = userAddy2;
      this.Permit_spender = spender;
      this.Permit_value = value;
      this.Permit_deadline = deadline;

	
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},





    async initilizeAuction() {
    this.txStatus = 1;
    try {
        const txHandle = await this.contract2.zSetUP1(zkBTC_CONTRACT_ADDRESS);

        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle.wait();
        this.txStatus = 3;

        // Update greeting
        this.greeting = await this.getGreeting();

        this.greetingStakeBalance = await this.getGreetingStakeBalance();
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();
        this.retreivingFee = true;
        this.LPBalance = await this.getLPBalance();
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},



    async initilizeNewStakingPeriod() {
    this.txStatus = 1;
    try {
        const txHandle = await this.contractABASStaking.setRewardParamsALL(5);

        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle.wait();
        this.txStatus = 3;

        // Update greeting
        this.greeting = await this.getGreeting();

        this.greetingStakeBalance = await this.getGreetingStakeBalance();
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();
        this.retreivingFee = true;
        this.LPBalance = await this.getLPBalance();
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},



    async sendETHtoAuction() {
      const web3 = new Web3();

      const amount = this.message;
      const amountInWei = web3.utils.toWei(parseFloat(amount).toFixed(18).toString());
      const userAddy = await this.getAddress()
console.log("222212", userAddy );
    this.txStatus = 1;
    try {
        const txHandle = await this.contract2.burn0xForMember(userAddy,  {value: amountInWei});

        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle.wait();
        this.txStatus = 3;

        // Update greeting
        this.greeting = await this.getGreeting();

        this.greetingStakeBalance = await this.getGreetingStakeBalance();
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();
        this.retreivingFee = true;
        this.LPBalance = await this.getLPBalance();
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
        this.currentAuctionTotal = await this.getAuctionTotal();
        this.UserTotal = await this.getUserTotal();
        this.NextDayTime = await this.getNextDayTime();
        this.CLAIM_AMOUNT = await this.getAuctionTotalZKBTC();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},



    async sendETHtoAuctionAdvanced() {
      const web3 = new Web3();

      const amount = this.message;
      const amountInWei = web3.utils.toWei(parseFloat(amount).toFixed(18).toString());
      const userAddy = await this.getAddress()
console.log("222212", userAddy );
    this.txStatus = 1;
    try {
        const txHandle = await this.contract2.FutureBurn0xEasier(this.era, this.StartingDay, this.amountOfDays, userAddy,  {value: amountInWei});

        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle.wait();
        this.txStatus = 3;

        // Update greeting
        this.greeting = await this.getGreeting();

        this.greetingStakeBalance = await this.getGreetingStakeBalance();
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();
        this.retreivingFee = true;
        this.LPBalance = await this.getLPBalance();
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
        this.currentAuctionTotal = await this.getAuctionTotal();
        this.UserTotal = await this.getUserTotal();
        this.NextDayTime = await this.getNextDayTime();
        this.CLAIM_AMOUNT = await this.getAuctionTotalZKBTC();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},

    async sendETHtoAuction2() {
      const userAddy = await this.getAddress()
console.log("222212", userAddy );
    this.txStatus = 1;
    try {
        const txHandle = await this.contract2.WithdrawEz(userAddy);

        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle.wait();
        this.txStatus = 3;

        // Update greeting
        this.greeting = await this.getGreeting();

        this.greetingStakeBalance = await this.getGreetingStakeBalance();
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();
        this.retreivingFee = true;
        this.LPBalance = await this.getLPBalance();
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
        this.currentAuctionTotal = await this.getAuctionTotal();
        this.UserTotal = await this.getUserTotal();
        this.NextDayTime = await this.getNextDayTime();
        this.CLAIM_AMOUNT = await this.getAuctionTotalZKBTC();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},

    async GetStakingRewardsOnly() {
      const userAddy = await this.getAddress()
console.log("222212", userAddy );
    this.txStatus = 1;
    try {
        const txHandle = await this.contractABASStaking.getReward();

        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle.wait();
        this.txStatus = 3;

        // Update greeting
        this.greeting = await this.getGreeting();

        this.greetingStakeBalance = await this.getGreetingStakeBalance();
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();
        this.retreivingFee = true;
        this.LPBalance = await this.getLPBalance();
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
        this.currentAuctionTotal = await this.getAuctionTotal();
        this.UserTotal = await this.getUserTotal();
        this.NextDayTime = await this.getNextDayTime();
        this.CLAIM_AMOUNT = await this.getAuctionTotalZKBTC();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},




    async ApproveLPtoStake() {
      const userAddy = await this.getAddress()
console.log("222212", userAddy );
    this.txStatus = 1;
    try {
const amountToStake = (parseFloat(this.sliderValue2*1.001)).toString(); // or parseFloat(this.sliderValue2)
const bigNumber = BigNumber.from(utils.parseUnits(amountToStake, 18));
     
console.log("Testing12321312123", amountToStake);
console.log("Testing12321312123", bigNumber);
const txHandle = await this.contractLPToken.approve(Staking_zkBTC_CONTRACT_ADDRESS, (bigNumber).toString());

        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle.wait();
        this.txStatus = 3;

        // Update greeting
        this.greeting = await this.getGreeting();

        this.greetingStakeBalance = await this.getGreetingStakeBalance();
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();
        this.retreivingFee = true;
        this.LPBalance = await this.getLPBalance();
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
        this.currentAuctionTotal = await this.getAuctionTotal();
        this.UserTotal = await this.getUserTotal();
        this.NextDayTime = await this.getNextDayTime();
        this.CLAIM_AMOUNT = await this.getAuctionTotalZKBTC();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},




    async AddPortionToStake() {
      const userAddy = await this.getAddress()
console.log("222212", userAddy );
    this.txStatus = 1;
    try {
console.log("ffsdfsdfsd", this.sliderValue2 * 1.11  );
console.log("ffsdfsdfsd222212", (this.MaxsliderValue2/1e18) );
const amountToStake = (parseFloat(this.sliderValue2).toFixed(18)).toString(); // or parseFloat(this.sliderValue2)
var bigNumber = BigNumber.from(utils.parseUnits(amountToStake, 18));
if(this.sliderValue2 * 1.01 > (this.MaxsliderValue2/1e18)){
console.log("22221BOGIE2", userAddy );
const txHandle = await this.contractABASStaking.MAXstake();

console.log("22221BOGIE2", userAddy );
        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle.wait();
}else{
  const txHandle2 = await this.contractABASStaking.stake((bigNumber));

        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle2.wait();

}

        this.txStatus = 3;

     


        // Update greeting
	
        this.greeting = await this.getGreeting();

        this.greetingStakeBalance = await this.getGreetingStakeBalance();
	this.MaxsliderValue = parseInt(this.greetingStakeBalance);
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();
        this.retreivingFee = true;
        this.LPBalance = await this.getLPBalance();
	this.MaxsliderValue2 = parseInt(this.LPBalance);
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
        this.currentAuctionTotal = await this.getAuctionTotal();
        this.UserTotal = await this.getUserTotal();
        this.NextDayTime = await this.getNextDayTime();
        this.CLAIM_AMOUNT = await this.getAuctionTotalZKBTC();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},


    async RemovePortionOfStake() {
      const userAddy = await this.getAddress()
console.log("222212", userAddy );
    this.txStatus = 1;
    try {
  var  amountToStake =  (parseFloat(this.sliderValue)).toString();
if(this.sliderValue<=(this.greetingStakeBalance/1e18 * 99/100)){
  console.log("BIGGIERRRRR");
          amountToStake = (parseFloat((this.sliderValue)).toFixed(18)).toString();
        

var bigNumber = BigNumber.from(utils.parseUnits(amountToStake, 18));

        console.log("BIGNUM", bigNumber)
        var txHandle = await this.contractABASStaking.withdraw(bigNumber);        
        
        this.txStatus = 2;
        await txHandle.wait();

await txHandle.wait();
}else{
        var txHandle2 = await this.contractABASStaking.exit();
        
        this.txStatus = 2;
        await txHandle2.wait();

}

        // Wait until the transaction is committed
        this.txStatus = 3;

        // Update greeting
        this.greeting = await this.getGreeting();

        this.greetingStakeBalance = await this.getGreetingStakeBalance();
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
	this.MaxsliderValue = parseInt(this.greetingStakeBalance);
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();
        this.retreivingFee = true;
        this.LPBalance = await this.getLPBalance();
	this.MaxsliderValue2 = parseInt(this.LPBalance);
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
        this.currentAuctionTotal = await this.getAuctionTotal();
        this.UserTotal = await this.getUserTotal();
        this.NextDayTime = await this.getNextDayTime();
        this.CLAIM_AMOUNT = await this.getAuctionTotalZKBTC();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},





    async ExitOnly() {
      const userAddy = await this.getAddress()
console.log("222212", userAddy );
    this.txStatus = 1;
    try {
        const txHandle = await this.contractABASStaking.exit();

        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle.wait();
        this.txStatus = 3;

        // Update greeting
        this.greeting = await this.getGreeting();

        this.greetingStakeBalance = await this.getGreetingStakeBalance();
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();
        this.retreivingFee = true;
        this.LPBalance = await this.getLPBalance();
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
        this.currentAuctionTotal = await this.getAuctionTotal();
        this.UserTotal = await this.getUserTotal();
        this.NextDayTime = await this.getNextDayTime();
        this.CLAIM_AMOUNT = await this.getAuctionTotalZKBTC();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},



    async initilizeABAS() {
    this.txStatus = 1;
    try {
      
        const txHandle = await this.contractABAS.zinit2(AUCTION_CONTRACT_ADDRESS, Staking_zkBTC_CONTRACT_ADDRESS, Staking_0xBTC_zkBTC_CONTRACT_ADDRESS);

        this.txStatus = 2;

        // Wait until the transaction is committed
        await txHandle.wait();
        this.txStatus = 3;

        // Update greeting
        this.greeting = await this.getGreeting();
        // Update greeting
        this.greetingStakeBalance = await this.getGreetingStakeBalance();
        this.greetingStakeBalanceTotal = await this.getGreetingStakeBalanceTotal();
        this.StakeReward = await this.getStakeReward();
        this.StakeReward2 = await this.getStakeReward2();
        this.StakeReward3 = await this.getStakeReward3();

        this.LPBalance = await this.getLPBalance();
        this.ApprovedLPforContract = await this.getApprovedLPforContract();
        this.retreivingFee = true;
        this.retreivingBalance = true;
        // Update balance and fee
        this.currentBalance = await this.getBalance();
        this.currentFee = await this.getFee();
    } catch (e) {
        alert(JSON.stringify(e));
    }

    this.txStatus = 0;
    this.retreivingFee = false;
    this.retreivingBalance = false;
},



    updateFee() {
      this.retreivingFee = true;
      this.getFee()
        .then((fee) => {
          this.currentFee = fee;
        })
        .catch((e) => console.log(e))
        .finally(() => {
          this.retreivingFee = false;
        });
    },
    updateBalance() {
      this.retreivingBalance = true;
      this.getBalance()
        .then((balance) => {
          this.currentBalance = balance;
        })
        .catch((e) => console.log(e))
        .finally(() => {
          this.retreivingBalance = false;
        });
    },
    changeToken() {
      this.retreivingFee = true;
      this.retreivingBalance = true;
      const l1Token = this.tokens.filter(
        (t) => t.address == this.selectedTokenAddress
      )[0];
      this.provider
        .l2TokenAddress(l1Token.address)
        .then((l2Address) => {
          this.selectedToken = {
            l1Address: l1Token.address,
            l2Address: l2Address,
            decimals: l1Token.decimals,
            symbol: l1Token.symbol,
          };
          this.updateFee();
          this.updateBalance();
        })
        .catch((e) => console.log(e))
        .finally(() => {
          this.retreivingFee = false;
          this.retreivingBalance = false;
        });
    },
    async changeTokenETH() {
      this.currentAuctionTotal = await this.getAuctionTotal();
      this.retreivingFee = true;
      this.retreivingBalance = true;
      this.provider
        .l2TokenAddress("0x0000000000000000000000000000000000000000")
        .then((l2Address) => {
          this.selectedToken = {
            l1Address: "0x0000000000000000000000000000000000000000",
            l2Address: l2Address,
            decimals: 18  ,
            symbol: "ETH",
          };
          this.updateFee();
          this.updateBalance();
        })
        .catch((e) => console.log(e))
        .finally(() => {
          this.retreivingFee = false;
          this.retreivingBalance = false;
        });
    },
    loadMainScreen() {
      this.initializeProviderAndSigner();

      if (!this.provider || !this.signer) {
        alert("Follow the tutorial to learn how to connect to Metamask!");
        return;
      }

      this.getDifficulty().then((difficulty) => {
        this.difficulty  = difficulty;
        this.mainLoading2 = false;
      });

      this.getGreetingAuctionNumber().then((greetingAuctionNumber) => {
        this.greetingAuctionNumber = greetingAuctionNumber;
	this.StartingDay = greetingAuctionNumber;
        this.mainLoading2 = false;
      });

      this.getGreetingAuctionLength().then((AuctionLengthInHours) => {
        this.AuctionLengthInHours = AuctionLengthInHours;
        this.mainLoading2 = false;
      });
      this.getGreetingAuctionERA().then((currentEra) => {
        this.currentEra = currentEra;
	this.era = currentEra;
        this.mainLoading2 = false;
      });

      this.getAuctionTotal().then((currentAuctionTotal) => {
        this.currentAuctionTotal = currentAuctionTotal;
        this.mainLoading2 = false;
      });

      this.getNextDayTime().then((NextDayTime) => {
        this.NextDayTime = NextDayTime;
        this.mainLoading2 = false;
      });

      this.UpdateContracts().then((NextDayTime) => {
        this.NextDayTime = NextDayTime;
        this.mainLoading2 = false;
      });

      this.getUserTotal().then((UserTotal) => {
        this.UserTotal = UserTotal;
        this.mainLoading2 = false;
      });

      this.getAuctionTotalZKBTC().then((CLAIM_AMOUNT) => {
        this.CLAIM_AMOUNT = CLAIM_AMOUNT;
        this.mainLoading2 = false;
      });

      
      this.getGreeting().then((greeting) => {
        this.greeting = greeting;
        this.mainLoading = false;
      });

      this.getGreetingStakeBalance().then((greetingStakeBalance) => {
        this.greetingStakeBalance = greetingStakeBalance;
        this.MaxsliderValue=greetingStakeBalance;
        this.mainLoading = false;
      });

      this.getLPBalance().then((LPBalance) => {
        this.LPBalance = LPBalance;
        this.MaxsliderValue2=LPBalance;
        this.mainLoading = false;
      });
      this.getApprovedLPforContract().then((ApprovedLPforContract) => {
        this.ApprovedLPforContract = ApprovedLPforContract;

        this.mainLoading = false;
      });
      this.getGreetingStakeBalanceTotal().then((greetingStakeBalanceTotal) => {
        this.greetingStakeBalanceTotal = greetingStakeBalanceTotal;
        this.mainLoading = false;
      });

      this.getStakeReward().then((StakeReward) => {
        this.StakeReward = StakeReward;
        this.mainLoading = false;
      });

      this.getStakeReward2().then((StakeReward2) => {
        this.StakeReward2 = StakeReward2;
        this.mainLoading = false;
      });

      this.getStakeReward3().then((StakeReward3) => {
        this.StakeReward3 = StakeReward3;
        this.mainLoading = false;
      });

      this.getStakeNextRewardTime().then((StakingNewPeriod) => {
        this.StakingNewPeriod = StakingNewPeriod;
        this.mainLoading = false;
      });

    },
    connectMetamask() {
      window.ethereum
        .request({ method: "eth_requestAccounts" })
        .then(() => {
        //  if (+window.ethereum.networkVersion == 280 || +window.ethereum.networkVersion == 324 ) {
            if (+window.ethereum.networkVersion == 280 ) {
            this.loadMainScreen();
          } else {
            alert("Please switch network to zkSync Testnet!");
          }
        })
        .catch((e) => console.log(e));
    },
  },
};
</script>

<style>
.form-control {
  padding: 3px; /* Optional: Add padding for better visual appearance */
  font-size: 30px; /* Adjust the width to your preference */
}
.larger-input {
  width: 80px; /* Adjust the width to your preference */
  padding: 10px; /* Add padding for better visual appearance */
  font-size: 16px; /* Optional: Adjust the font size */
}
.my-button {
  font-size: 20px;
  padding: 10px 20px;
}

.my-button5 {
  font-size: 20px;
  padding: 10px 20px;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 30px;
}

#app ul {
  display: inline-block;
}

.main-box {
  text-align: left;
  width: 400px;

  margin: auto;
  margin-top: 40px;
}

.greeting-input {
  margin-top: 20px;
}

.change-button {
  margin-left: 20px;
}

.start-screen {
  margin-top: 100px;
}

.balance {
  margin-top: 10px;
}

.refresh-button {
  margin-left: 15px;
}
</style>
