import { Wallet, utils } from "zksync-web3";
import * as ethers from "ethers";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { Deployer } from "@matterlabs/hardhat-zksync-deploy";


// An example of a deploy script that will deploy and call a simple contract.
export default async function (hre: HardhatRuntimeEnvironment) {
  console.log(`Running deploy script for the zkBitcoin contract`);

  // Initialize the wallet.
  const wallet = new Wallet('ENTER PRIVATE KEY');

  // Create deployer object and load the artifact of the contract you want to deploy.
  const deployer = new Deployer(hre, wallet);
 
	//FILL IN CONTRACT ADDRESSES
  const contractAddressZKBTC = "0x4F95f7077f1416296Fad9dC52D4836d114b9B769";
  const contractAddressAuctions = "0x8F989bd9943DD3897fB08937dBb6deAA7d2086f7";

  const contractAddress0xBTC = "0xa0E1d12603EA3E256aA52AaB96271e97dC66ED7a" //"0xfEa352c0D005a1e4AC7E092ef14Fca18b8E6c8fd";   //ZK Sync Mainnet 0xBTC Token 

  const contractAddressLP = "0x5b6E5E376A90658c0c8F37ad6a6b75B9E056Cb27";


  
  console.log("zkBTC Contract: ", contractAddressZKBTC);
  console.log("LP Contract: ", contractAddressLP);
  console.log("0xBTC Contract: ", contractAddress0xBTC );
  console.log("Auctions: ", contractAddressAuctions);
  


  console.log(`DEPLOY STAKING FOR TESTING`);
  // Create deployer object and load the artifact of the contract you want to deploy.
  const artifactSTAKING = await deployer.loadArtifact("zkBitcoinStaking0xBTC");

  // Estimate contract deployment fee
  const greetingSTAKING = "Hi there!";
  const test2STAKING = '';
  const test3STAKING = '3';
  const deploymentFeeSTAKING = await deployer.estimateDeployFee(artifactSTAKING, [contractAddressZKBTC, contractAddressLP, contractAddress0xBTC, contractAddressAuctions]);

  // OPTIONAL: Deposit funds to L2
  // Comment this block if you already have funds on zkSync.
 // const depositHandle = await deployer.zkWallet.deposit({
 //   to: deployer.zkWallet.address,
  //  token: utils.ETH_ADDRESS,
 //   amount: deploymentFee.mul(2),
 // });
  // Wait until the deposit is processed on zkSync
 // await depositHandle.wait();

  // Deploy this contract. The returned object will be of a `Contract` type, similarly to ones in `ethers`.
  // `greeting` is an argument for contract constructor.
  const parsedFeeSTAKING = ethers.utils.formatEther(deploymentFeeSTAKING.toString());
  console.log(`The deployment is estimated to cost ${parsedFeeSTAKING} ETH`);

  const greeterContractSTAKING = await deployer.deploy(artifactSTAKING, [contractAddressZKBTC, contractAddressLP, contractAddress0xBTC, contractAddressAuctions]);

  //obtain the Constructor Arguments
  console.log("constructor args:" + greeterContractSTAKING.interface.encodeDeploy([contractAddressZKBTC, contractAddressLP, contractAddress0xBTC, contractAddressAuctions]));

  // Show the contract info.
  const contractAddressSTAKING = greeterContractSTAKING.address;
  console.log(`${artifactSTAKING.contractName} was deployed to ${contractAddressSTAKING}`);



  console.log("zkBTC Contract: ", contractAddressZKBTC);
  console.log("Auctions Contract: ", contractAddressAuctions);
  console.log("Staking Contract: ", contractAddressSTAKING);
  console.log("0xBTC Contract: ", contractAddress0xBTC );
  console.log("LP Token Contract: ", contractAddressLP);
  
console.log("FINISHED");
const stringz = "yarn hardhat verify --network zkSyncTestnet "+contractAddressSTAKING+` "`+contractAddressZKBTC+`" "`+contractAddressLP+`" "`+contractAddress0xBTC+`" "`+contractAddressAuctions+`" --contract "contracts/zkBitcoinStaking0xBTC.sol:zkBitcoinStaking0xBTC"`;
console.log("FINISHED");
console.log("zkBTC Contract: ", contractAddressZKBTC);
console.log(`yarn hardhat verify --network zkSyncTestnet `,contractAddressZKBTC,` --contract "contracts/zkBitcoin.sol:zkBitcoin"`);
console.log("LP Contract: ", contractAddressLP);
console.log(`yarn hardhat verify --network zkSyncTestnet `,contractAddressLP,` --contract "contracts/aLPMock.sol:aLPMock"`);
console.log("0xBTC Contract: ", contractAddress0xBTC );
console.log(`yarn hardhat verify --network zkSyncTestnet `,contractAddress0xBTC,` --contract "contracts/a0xbtcMock.sol:a0xbtcMock"`);

console.log("Auctions: ", contractAddressAuctions);
console.log(`yarn hardhat verify --network zkSyncTestnet `,contractAddressAuctions,` --contract "contracts/zkBitcoinAuctions.sol:zkBitcoinAuctions"`);

console.log("Staking, zkBitcoinStaking: ", contractAddressSTAKING);
console.log(stringz);

  console.log('const LP_CONTRACT_ADDRESS = "'+ contractAddressLP + '"');
  console.log('const Staking_zkBTC_CONTRACT_ADDRESS = "'+ contractAddressSTAKING + '"');
  console.log('const zkBTC_CONTRACT_ADDRESS = "'+ contractAddressZKBTC + '"');
  console.log('const ZeroxBitcoin_addresss = "'+ contractAddress0xBTC + '"');
  console.log('const AUCTION_CONTRACT_ADDRESS = "'+ contractAddressAuctions + '"');
  
const LP_CONTRACT_ADDRESS = "0xdEd772f8a2aF0f8b29fe071124e831695a781490";
const Staking_AbAS_CONTRACT_ADDRESS = "0xB10Dd5c416acF5591D938B706947A926c2E14793";
const ABAS_CONTRACT_ADDRESS = "0x9FCC1494E98744D078bE9493cadE020B965d9beE";
const ZeroxBitcoin_addresss = "0xf5ce713aa183fB976C6fB48864AAbAf00F928D90";
const AUCTION_CONTRACT_ADDRESS = "0x12a7d4353259E93f8A2dC58E8b7cBB5c361A1f83";



}
