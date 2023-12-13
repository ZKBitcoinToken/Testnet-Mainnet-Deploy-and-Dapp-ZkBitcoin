import { Wallet, Provider, utils } from "zksync-web3";
import * as ethers from "ethers";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { Deployer } from "@matterlabs/hardhat-zksync-deploy";


// An example of a deploy script that will deploy and call a simple contract.
export default async function (hre: HardhatRuntimeEnvironment) {
  console.log(`Running deploy script for the zkBitcoin contract`);

const Factory_ADDRESS = "0xA97f21BFe79a37088D0599B7cde319da7f8f5a38";
const CONTRACT_ADDRESS_0xBTC = "0xa0E1d12603EA3E256aA52AaB96271e97dC66ED7a";
const CONTRACT_ADDRESS_WETH = "0x20b28B1e4665FFf290650586ad76E977EAb90c5D";


  // Initialize the wallet.
  const wallet = new Wallet('ENTER PRIVATE KEY');

  // Create deployer object and load the artifact of the contract you want to deploy.
  const deployer = new Deployer(hre, wallet);
  const artifact = await deployer.loadArtifact("zkBitcoin");

  // Estimate contract deployment fee
  const greeting = "Hi there!";
  const test2 = '';
  const test3 = '3';
  const deploymentFee = await deployer.estimateDeployFee(artifact, []);


  // Deploy this contract. The returned object will be of a `Contract` type, similarly to ones in `ethers`.
  // `greeting` is an argument for contract constructor.
  const parsedFee = ethers.utils.formatEther(deploymentFee.toString());
  console.log(`The deployment is estimated to cost ${parsedFee} ETH`);

  const greeterContractZKBTC = await deployer.deploy(artifact, []);

  //obtain the Constructor Arguments
  console.log("constructor args:" + greeterContractZKBTC.interface.encodeDeploy([]));

  // Show the contract info.
  const contractAddressZKBTC = greeterContractZKBTC.address;
  console.log(`${artifact.contractName} was deployed to ${contractAddressZKBTC}`);



  console.log(`Running deploy script for the zkBitcoin contract`);



  const artifact2 = await deployer.loadArtifact("zkBitcoinAuctions");

  // Estimate contract deployment fee
  const deploymentFee2 = await deployer.estimateDeployFee(artifact2, []);


  // Deploy this contract. The returned object will be of a `Contract` type, similarly to ones in `ethers`.
  // `greeting` is an argument for contract constructor.
  const parsedFee2 = ethers.utils.formatEther(deploymentFee2.toString());
  console.log(`The deployment is estimated to cost ${parsedFee2} ETH`);

  const greeterContractAuctions = await deployer.deploy(artifact2, []);

  //obtain the Constructor Arguments
  console.log("constructor args:" + greeterContractAuctions.interface.encodeDeploy([]));

  // Show the contract info.
  const contractAddress2 = greeterContractAuctions.address;
  console.log(`${artifact2.contractName} was deployed to ${contractAddress2}`);
  
  console.log("zkBTC Contract: ", contractAddressZKBTC);
  console.log("Auctions: ", contractAddress2);







  var provider = new Provider("https://testnet.era.zksync.dev");
  var signer = new ethers.Wallet(wallet, provider);




const poolFactoryInterface = [
  'function createPool(bytes calldata data) external returns (address pool)',
];
// Address of the contract on zksync testnet
const CONTRACT_ADDRESS_zkBTC = contractAddressZKBTC;

if (!CONTRACT_ADDRESS_0xBTC) throw "⛔️ Contract address not provided";

// An example of a deploy script that will deploy and call a simple contract.

  console.log(`Running script to interact with contract ${Factory_ADDRESS}`);

// Connect to the deployed contract
var poolFactoryContract = new ethers.Contract(Factory_ADDRESS, poolFactoryInterface, signer);

// Example data for creating a pool (replace with actual data)
var data = ethers.utils.defaultAbiCoder.encode(['address', 'address'], [CONTRACT_ADDRESS_zkBTC, CONTRACT_ADDRESS_0xBTC]);
var contract0xBTCLPAddress = null;
try {
    const tx = await poolFactoryContract.createPool(data);
    const receipt = await tx.wait(); // Wait for the transaction to be mined
    const poolData = JSON.stringify(receipt, null, 2);
    console.log('Receipt data:', poolData);
    contract0xBTCLPAddress = receipt.contractAddress;
    console.log('Contract Address of New LP:', contract0xBTCLPAddress);
  } catch (error) {
    console.error('Error creating pool:', error);
  }


















//FILL IN 0xBTC Staking CONTRACT ADDRESSES
  const contractAddressAuctions = contractAddress2;

  const contractAddress0xBTC = CONTRACT_ADDRESS_0xBTC; //"0xfEa352c0D005a1e4AC7E092ef14Fca18b8E6c8fd";   //ZK Sync Mainnet 0xBTC Token 

  const contractAddressLP = contract0xBTCLPAddress;


  
  console.log("zkBTC Contract: ", contractAddressZKBTC);
  console.log("LP Contract: ", contractAddressLP);
  console.log("0xBTC Contract: ", contractAddress0xBTC );
  console.log("Auctions: ", contractAddressAuctions);
  


  console.log(`DEPLOY STAKING FOR TESTING`);
  // Create deployer object and load the artifact of the contract you want to deploy.
  var artifactSTAKING = await deployer.loadArtifact("zkBitcoinStaking0xBTC");

  // Estimate contract deployment fee
  var greetingSTAKING = "Hi there!";
  var test2STAKING = '';
  var test3STAKING = '3';
  var deploymentFeeSTAKING = await deployer.estimateDeployFee(artifactSTAKING, [contractAddressZKBTC, contractAddressLP, contractAddress0xBTC, contractAddressAuctions]);

  var parsedFeeSTAKING = ethers.utils.formatEther(deploymentFeeSTAKING.toString());
  console.log(`The deployment is estimated to cost ${parsedFeeSTAKING} ETH`);

  var greeterContractSTAKING = await deployer.deploy(artifactSTAKING, [contractAddressZKBTC, contractAddressLP, contractAddress0xBTC, contractAddressAuctions]);

  //obtain the Constructor Arguments
  console.log("constructor args:" + greeterContractSTAKING.interface.encodeDeploy([contractAddressZKBTC, contractAddressLP, contractAddress0xBTC, contractAddressAuctions]));

  // Show the contract info.
  var contractAddressSTAKING = greeterContractSTAKING.address;
  console.log(`${artifactSTAKING.contractName} was deployed to ${contractAddressSTAKING}`);



  console.log("zkBTC Contract: ", contractAddressZKBTC);
  console.log("Auctions Contract: ", contractAddressAuctions);
  console.log("Staking Contract: ", contractAddressSTAKING);
  console.log("0xBTC Contract: ", contractAddress0xBTC );
  console.log("0xBTC LP Token Contract: ", contractAddressLP);
  
console.log("FINISHED");
const stringz3 = "yarn hardhat verify --network zkSyncTestnet "+contractAddressSTAKING+` "`+contractAddressZKBTC+`" "`+contractAddressLP+`" "`+contractAddress0xBTC+`" "`+contractAddressAuctions+`" --contract "contracts/zkBitcoinStaking0xBTC.sol:zkBitcoinStaking0xBTC"`;
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
console.log(stringz3);

  console.log('const LP_CONTRACT_ADDRESS = "'+ contractAddressLP + '"');
  console.log('const Staking_zkBTC_CONTRACT_ADDRESS = "'+ contractAddressSTAKING + '"');
  console.log('const zkBTC_CONTRACT_ADDRESS = "'+ contractAddressZKBTC + '"');
  console.log('const ZeroxBitcoin_addresss = "'+ contractAddress0xBTC + '"');
  console.log('const AUCTION_CONTRACT_ADDRESS = "'+ contractAddressAuctions + '"');
  










if (!Factory_ADDRESS) throw "⛔️ Contract address not provided";

// An example of a deploy script that will deploy and call a simple contract.
  console.log(`Running script to interact with contract ${Factory_ADDRESS}`);

  // Initialize the provider.
  // @ts-ignore
  var provider = new Provider("https://testnet.era.zksync.dev");
  var signer = new ethers.Wallet(wallet, provider);


// Connect to the deployed contract
var poolFactoryContract = new ethers.Contract(Factory_ADDRESS, poolFactoryInterface, signer);

// Example data for creating a pool (replace with actual data)
var data = ethers.utils.defaultAbiCoder.encode(['address', 'address'], [CONTRACT_ADDRESS_zkBTC, CONTRACT_ADDRESS_WETH]);
var contractStaking_ETH_Address = null;
try {
    const tx = await poolFactoryContract.createPool(data);
    const receipt = await tx.wait(); // Wait for the transaction to be mined
    const poolData = JSON.stringify(receipt, null, 2);
    console.log('Receipt data:', poolData);
    var contractStaking_ETH_Address = receipt.contractAddress;
    console.log('Contract Address of New ETH LP:', contractStaking_ETH_Address);
  } catch (error) {
    console.error('Error creating pool:', error);
  }






  const contractAddressLP_ETH = contractStaking_ETH_Address;


  
  console.log("zkBTC Contract: ", contractAddressZKBTC);
  console.log("ETH LP Contract: ", contractAddressLP_ETH);
  console.log("0xBTC Contract: ", contractAddress0xBTC );
  console.log("Auctions: ", contractAddressAuctions);
  


  console.log(`DEPLOY STAKING FOR TESTING`);
  // Create deployer object and load the artifact of the contract you want to deploy.
  var artifactSTAKING = await deployer.loadArtifact("zkBitcoinStakingETH");

  // Estimate contract deployment fee
  var greetingSTAKING = "Hi there!";
  var test2STAKING = '';
  var test3STAKING = '3';
  var deploymentFeeSTAKING = await deployer.estimateDeployFee(artifactSTAKING, [contractAddressZKBTC, contractAddressLP_ETH, contractAddress0xBTC, contractAddressAuctions]);

 var parsedFeeSTAKING = ethers.utils.formatEther(deploymentFeeSTAKING.toString());
  console.log(`The deployment is estimated to cost ${parsedFeeSTAKING} ETH`);

  var greeterContractSTAKING = await deployer.deploy(artifactSTAKING, [contractAddressZKBTC, contractAddressLP_ETH, contractAddress0xBTC, contractAddressAuctions]);

  //obtain the Constructor Arguments
  console.log("constructor args:" + greeterContractSTAKING.interface.encodeDeploy([contractAddressZKBTC, contractAddressLP_ETH, contractAddress0xBTC, contractAddressAuctions]));

  // Show the contract info.
  const contractAddressSTAKING_ETH = greeterContractSTAKING.address;
  console.log(`${artifactSTAKING.contractName} was deployed to ${contractAddressSTAKING_ETH}`);



  console.log("zkBTC Contract: ", contractAddressZKBTC);
  console.log("Auctions Contract: ", contractAddressAuctions);
  console.log("Staking Contract: ", contractAddressSTAKING_ETH);
  console.log("0xBTC Contract: ", contractAddress0xBTC );
  console.log("ETH LP Token Contract: ", contractAddressLP_ETH);
  
console.log("FINISHED");
const stringz = "yarn hardhat verify --network zkSyncTestnet "+contractAddressSTAKING_ETH+` "`+contractAddressZKBTC+`" "`+contractAddressLP_ETH+`" "`+contractAddress0xBTC+`" "`+contractAddressAuctions+`" --contract "contracts/zkBitcoinStakingETH.sol:zkBitcoinStakingETH"`;
console.log("FINISHED");
console.log("zkBTC Contract: ", contractAddressZKBTC);
console.log(`yarn hardhat verify --network zkSyncTestnet `,contractAddressZKBTC,` --contract "contracts/zkBitcoin.sol:zkBitcoin"`);
console.log("LP Contract: ", contractAddressLP_ETH);
console.log(`yarn hardhat verify --network zkSyncTestnet `,contractAddressLP_ETH,` --contract "contracts/aLPMock.sol:aLPMock"`);
console.log("0xBTC Contract: ", contractAddress0xBTC );
console.log(`yarn hardhat verify --network zkSyncTestnet `,contractAddress0xBTC,` --contract "contracts/a0xbtcMock.sol:a0xbtcMock"`);

console.log("Auctions: ", contractAddressAuctions);
console.log(`yarn hardhat verify --network zkSyncTestnet `,contractAddressAuctions,` --contract "contracts/zkBitcoinAuctions.sol:zkBitcoinAuctions"`);

console.log("Staking, zkBitcoinStaking: ", contractAddressSTAKING_ETH);
console.log(stringz);
console.log("0xBTC Staking verifies below");
console.log(stringz3);
  console.log('\n');
  console.log('\n');
  console.log('\n');
  console.log('//FOR ETH POOL and Auctions only Main Contracts Below');
  console.log('const LP_CONTRACT_ADDRESS = "'+ contractAddressLP_ETH + '"');
  console.log('const Staking_zkBTC_CONTRACT_ADDRESS = "'+ contractAddressSTAKING_ETH + '"');
  console.log('const zkBTC_CONTRACT_ADDRESS = "'+ contractAddressZKBTC + '"');
  console.log('const ZeroxBitcoin_addresss = "'+ contractAddress0xBTC + '"');
  console.log('const AUCTION_CONTRACT_ADDRESS = "'+ contractAddressAuctions + '"');
  console.log('\n//SECOND STAKING ADDRESS');
  console.log('const LP_SECOND_CONTRACT_ADDRESS = "'+ contractAddressLP + '"');
  console.log('const LP_SECOND_STAKING_CONTRACT_ADDRESS = "'+ contractAddressSTAKING + '"');





  console.log('\n');
  console.log('\n');
  console.log('\n');
  console.log('// 0xBTC POOL ONLY Main Contracts Below');
  console.log('const LP_CONTRACT_ADDRESS = "'+ contractAddressLP + '"');
  console.log('const Staking_zkBTC_CONTRACT_ADDRESS = "'+ contractAddressSTAKING + '"');
  console.log('const zkBTC_CONTRACT_ADDRESS = "'+ contractAddressZKBTC + '"');
  console.log('const ZeroxBitcoin_addresss = "'+ contractAddress0xBTC + '"');
  console.log('const AUCTION_CONTRACT_ADDRESS = "'+ contractAddressAuctions + '"');
  console.log('\n//SECOND STAKING ADDRESS');
  console.log('const LP_SECOND_CONTRACT_ADDRESS = "'+ contractAddressLP_ETH + '"');
  console.log('const LP_SECOND_STAKING_CONTRACT_ADDRESS = "'+ contractAddressSTAKING_ETH + '"');

  console.log('\n');



















}
