nvm use 16

yarn hardhat compile

yarn hardhat deploy-zksync --script deployaZKBTC.ts

Take zkBitcoin Token and Make LP Pools.

Take all info (zkBitcoin, Auctions, 0xBTC, and LP Token addresses) and add to deployStakingContracts

Have STAKING FILLED OUT WITH CORRECT INFO into deployStaking0xBTC.ts & deployStakingETH.ts

yarn hardhat deploy-zksync --script deployStakingETH.ts

yarn hardhat deploy-zksync --script deployStaking0xBTC.ts


