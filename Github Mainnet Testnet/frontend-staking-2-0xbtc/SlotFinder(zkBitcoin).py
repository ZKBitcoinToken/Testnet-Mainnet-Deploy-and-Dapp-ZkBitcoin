#!/usr/bin/env python
# -*- coding: utf-8 -*-
import requests
import logging
import time
import json
import os
import time
import binascii
import redis
import datetime
from web3 import Web3
r = redis.Redis(host='127.0.0.1')
import datetime
# ENABLE LOGGING - options, DEBUG,INFO, WARNING?
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)
# Load up MCD and 1 Inch split contract ABIs

zkBitcoinAddress = Web3.toChecksumAddress(
        '0x2Fe4abE63F6A2805D540F6da808527D21Bc9ea60')  # zkBitcoin contract
if 'PRIVATE_KEY' in os.environ:
	private_key = os.environ["PRIVATE_KEY"]
else:
	logger.warning(
		'No private key has been set. Script will not be able to send transactions!')
	private_key = False
if 'ETH_PROVIDER_URL' in os.environ:
	eth_provider_url = os.environ["ETH_PROVIDER_URL"]
else:
	logger.warning(
		'No ETH_PROVIDER_URL has been set! Please set that and run the script again.')
	quit()
if 'BASE_ACCOUNT' in os.environ:
	base_account = Web3.toChecksumAddress(os.environ["BASE_ACCOUNT"])
else:
	logger.warning(
		'No BASE_ACCOUNT has been set! Please set that and run the script again.')
	quit()
def main():
	x=0
	while x == 0:
		try:
			main2()
		except Exception:
			time.sleep(150)
			print("ERRORZ")

		time.sleep(5)

def main2():
	x = 0
	nosend = 0
	while(x<100000000000000000000):
		findtheslotsforcontract = findSlots()
		time.sleep(500)
		time.sleep(100)






def findSlots():
#nextz2 = bnbitcoin_contract.functions.mapEraDay_Units(1, day).call({'from': base_account})
	variz = web3.eth.blockNumber;
	print("CURRENT BLOCK " + str(variz));
	contents = web3.eth.getStorageAt(zkBitcoinAddress, 0)
	for x in range(0,55):
		contents = web3.eth.getStorageAt(zkBitcoinAddress, x, 14450702)
		print("Slot "+ str(x) + " : ", contents.hex())
		print("Slot "+ str(x) + " : ", int(contents.hex(), 16))

	return 2



def connect_to_ETH_provider():
	try:
		web3 = Web3(Web3.HTTPProvider(eth_provider_url))
	except Exception as e:
		logger.warning(
			"There is an issue with your initial connection to Ethereum Provider: {0}".format(e))
		quit()
	return web3


# establish web3 connection
web3 = connect_to_ETH_provider()
# run it!
if __name__ == '__main__':
	main()


#-----------------#
# Here are some examples of single methods/functions being executed
#-----------------#

# Get a trade quote directly from the blockchain
# response is a list like: [1533867641279495750, [0, 95, 5, 0, 0, 0, 0, 0, 0, 0]]
# where first item is amount, second is a list of how your order will be distributed across exchanges
# logger.info(one_inch_get_quote(ethereum, mcd_contract_address, amount_to_exchange))

#--- Making an Approval ---#
# check if MCD contract has allowance for provided account to spend tokens
# get_allowance(base_account)

# This will approve the one inch split contract to spend to spend amount_of_dai worth of base_account's tokens
# you will need to call this before trading your MCD/DAI on 1 inch. Will cost a small bit of ETH/gas
# approve_ERC20(amount_of_dai)

# check MCD again to confirm approval worked
# get_allowance(base_account)

#--- Using API to get data and make trades ---#
# get_api_quote_data("DAI", "ETH", amount_to_exchange)
# get_api_call_data("DAI", "ETH", amount_to_exchange)
		
		

