import { Provider } from "zksync-web3";
import * as ethers from "ethers";
import { HardhatRuntimeEnvironment } from "hardhat/types";


const poolFactoryInterface = [
  'function createPool(bytes calldata data) external returns (address pool)',
];

// Example data for creating a pool (replace with actual data)

const PRIVATE_KEY = 'ENTER PRIVATE KEY';

if (!PRIVATE_KEY) throw "⛔️ Private key not detected! Add it to the .env file!";

// Address of the contract on zksync testnet
const Factory_ADDRESS = "0xA97f21BFe79a37088D0599B7cde319da7f8f5a38";
const CONTRACT_ADDRESS_WETH = "0x20b28B1e4665FFf290650586ad76E977EAb90c5D";
const CONTRACT_ADDRESS_zkBTC = "0x5954130F2f8C0eAaF9c23C342336991eA6D045DA";

if (!Factory_ADDRESS) throw "⛔️ Contract address not provided";

// An example of a deploy script that will deploy and call a simple contract.
export default async function (hre: HardhatRuntimeEnvironment) {
  console.log(`Running script to interact with contract ${Factory_ADDRESS}`);

  // Initialize the provider.
  // @ts-ignore
  const provider = new Provider("https://testnet.era.zksync.dev");
  const signer = new ethers.Wallet(PRIVATE_KEY, provider);


// Connect to the deployed contract
const poolFactoryContract = new ethers.Contract(Factory_ADDRESS, poolFactoryInterface, signer);

// Example data for creating a pool (replace with actual data)
const data = ethers.utils.defaultAbiCoder.encode(['address', 'address'], [CONTRACT_ADDRESS_zkBTC, CONTRACT_ADDRESS_WETH]);

try {
    const tx = await poolFactoryContract.createPool(data);
    const receipt = await tx.wait(); // Wait for the transaction to be mined
    const poolData = JSON.stringify(receipt, null, 2);
    console.log('Receipt data:', poolData);
    const contractStaking_ETH_Address = receipt.contractAddress;
    console.log('Contract Address of New ETH LP:', contractStaking_ETH_Address);
  } catch (error) {
    console.error('Error creating pool:', error);
  }
}

