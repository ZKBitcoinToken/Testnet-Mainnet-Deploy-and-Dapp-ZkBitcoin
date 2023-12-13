nvm use 16

yarn hardhat compile

yarn hardhat deploy-zksync --script deployaZKBTC.ts

Take zkBitcoin Token and Make LP Pools.

Take all info (zkBitcoin, Auctions, 0xBTC, and LP Token addresses) and add to deployStakingContracts

Have STAKING FILLED OUT WITH CORRECT INFO into deployStaking0xBTC.ts & deployStakingETH.ts

yarn hardhat deploy-zksync --script deployStakingETH.ts

yarn hardhat deploy-zksync --script deployStaking0xBTC.ts

Put those variables outputted into the dAPPs App.vue file

yarn serve
yarn build

Will make the projects for you


OOOORRRR



nvm use 16

yarn hardhat compile

yarn hardhat deploy-zksync --script deploy_Everything_Including_Pools.ts


use output of deploy scripts to verify contracts



Then go to my dapp and fill in information in App.vue and run

yarn serve
or
yarn build
