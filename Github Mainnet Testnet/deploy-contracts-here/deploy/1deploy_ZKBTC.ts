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









}
